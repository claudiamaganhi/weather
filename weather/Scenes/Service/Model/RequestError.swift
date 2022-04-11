enum RequestError: Error {
    case badRequest
    case urlParse
    case nilResponse
    case statusCode(code: StatusCode)
    case server(error: Error)
    case nilData
    case jsonParse
    case unknown
}
