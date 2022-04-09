import Foundation

enum RequestError: Error {
    case badRequest
    case nilData
}

protocol WeatherServicing: AnyObject {
    func fetchWeather(completion: @escaping(Result<WeatherResponse, RequestError>) -> Void)
}

final class WeatherService: WeatherServicing {
    private let endpoint = "https://www.metaweather.com/api/location/4118/"
    
    func fetchWeather(completion: @escaping (Result<WeatherResponse, RequestError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badRequest))
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _ , error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.badRequest))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.nilData))
                    return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let weather = try decoder.decode(WeatherResponse.self, from: data)
                    completion(.success(weather))
                } catch let decodeError {
                    print(decodeError)
                    completion(.failure(.nilData))
                }
            }
        }
        
        task.resume()
    }
}
