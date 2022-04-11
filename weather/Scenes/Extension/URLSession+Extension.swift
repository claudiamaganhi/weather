import Foundation

extension URLSession: SessionProtocol {
    public func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task: URLSessionDataTask = dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
    
    public func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task: URLSessionDataTask = dataTask(with: urlRequest, completionHandler: completionHandler)
        task.resume()
    }
}
