import Foundation

class Service: Servicing {
    let session: SessionProtocol
    let queue: DispatchQueueProtocol
    
    init(session: SessionProtocol, queue: DispatchQueueProtocol) {
        self.session = session
        self.queue = queue
    }
    
    func fetchData<T: Decodable>(stringUrl: String, decodingStrategy: JSONDecoder.KeyDecodingStrategy, completion: @escaping(Result<T, RequestError>) -> Void) {
        guard let url = URL(string: stringUrl) else {
            completion(.failure(.urlParse))
            return
        }
        session.dataTask(with: url) { [weak self] data, response , error in
            self?.queue.callAsync {
                if error != nil {
                    guard let self = self else { return }
                    completion(.failure(self.checkError(response: response)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.nilData))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder(keyDecodingStrategy: decodingStrategy).decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.nilData))
                }
            }
        }
    }
}

private extension Service {
    func checkError(response: URLResponse?) -> RequestError {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .nilResponse
        }
        let statusCode = StatusCode.getType(code: httpResponse.statusCode)
        return .statusCode(code: statusCode)
    }
}
