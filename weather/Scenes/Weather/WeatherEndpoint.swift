import Foundation

enum WeatherEndpoint: EndpointProtocol {
    case locationWeather

    var path: String {
        "https://www.metaweather.com/api/location/4118/"
    }
}
