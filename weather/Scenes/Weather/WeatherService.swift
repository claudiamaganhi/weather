import Foundation

protocol WeatherServicing: AnyObject {
    func fetchWeather(endpoint: WeatherEndpoint, completion: @escaping(Result<WeatherResponse, RequestError>) -> Void)
}

final class WeatherService: WeatherServicing {
    let service: Servicing
    
    init(service: Servicing = Service(session: URLSession(configuration: .default), queue: DispatchQueue.main)) {
        self.service = service
    }
    
    func fetchWeather(endpoint: WeatherEndpoint, completion: @escaping (Result<WeatherResponse, RequestError>) -> Void) {
        service.fetchData(stringUrl: endpoint.path, decodingStrategy: .convertFromSnakeCase, completion: completion)
    }
}
