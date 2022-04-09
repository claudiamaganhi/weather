struct WeatherResponse: Decodable {
    let consolidatedWeather: [WeatherDetailsResponse]
    let title: String
}

struct WeatherDetailsResponse: Decodable {
    let weatherStateName: String
    let weatherStateAbbr: String
    let theTemp: Float
}
