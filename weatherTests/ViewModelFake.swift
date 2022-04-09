import Foundation
@testable import weather

extension WeatherViewModel {
    static let response = WeatherDetailsResponse(weatherStateName: "Light rain", weatherStateAbbr: "lr", theTemp: 22.0)
    static let mock: WeatherViewModel = WeatherViewModel(weatherData: WeatherResponse(consolidatedWeather: [response], title: "Rio de Janeiro"))
}
