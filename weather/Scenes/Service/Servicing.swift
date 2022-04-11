import Foundation

protocol Servicing {
    func fetchData<T: Decodable>(stringUrl: String, decodingStrategy: JSONDecoder.KeyDecodingStrategy, completion: @escaping(Result<T, RequestError>) -> Void)
}
