import UIKit

struct WeatherViewModel {
    let weatherData: WeatherResponse
    
    var city: String {
        weatherData.title
    }
    
    var weatherState: String {
        weatherData.consolidatedWeather[0].weatherStateName
    }
    
    var temperature: String {
        "\(weatherData.consolidatedWeather[0].theTemp)º"
    }
    
    var temperatureImage: UIImage {
        getWeatherImage(abbreviation: weatherData.consolidatedWeather[0].weatherStateAbbr) ?? #imageLiteral(resourceName: "weather")
        
    }
}

private extension WeatherViewModel {
    func getWeatherImage(abbreviation: String) -> UIImage? {
        var image: UIImage?
        switch abbreviation {
        case "sn" :
            image = UIImage(systemName: "cloud.snow")
        case "sl":
            image = UIImage(systemName: "cloud.sleet")
        case "h":
            image = UIImage(systemName: "cloud.hail")
        case "t":
            image = UIImage(systemName: "cloud.bolt.rain")
        case "hr":
            image = UIImage(systemName: "cloud.heavyrain")
        case "lr":
            image = UIImage(systemName: "cloud.drizzle")
        case "s":
            image = UIImage(systemName: "cloud.drizzle")
        case "hc":
            image = UIImage(systemName: "smoke")
        case "lc":
            image = UIImage(systemName: "cloud.sun")
        case "c":
            image = UIImage(systemName: "sun.max")
        default:
            image = UIImage(systemName: "smoke")
        }
        return image
    }
}
