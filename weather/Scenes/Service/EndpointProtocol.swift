protocol EndpointProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var bodyParams: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension EndpointProtocol {
    var method: HTTPMethod {
        .get
    }
    
    var bodyParams: [String: Any]? {
        nil
    }
    
    var headers: [String: String]? {
        nil
    }
}
