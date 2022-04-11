import UIKit

protocol WeatherInteracting: AnyObject {
    func fetchWeather()
}

final class WeatherInteractor: WeatherInteracting {
    private let service: WeatherServicing
    private let presenter: WeatherPresenting
    
    init(service: WeatherServicing, presenter: WeatherPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

extension WeatherInteractor {
    func fetchWeather() {
        presenter.startLoading()
        service.fetchWeather(endpoint: .locationWeather) { [weak self] result in
            self?.presenter.stopLoading()
            switch result {
            case .success(let response):
                let viewModel = WeatherViewModel(weatherData: response)
                self?.presenter.presentWeatherDetails(with: viewModel)
            case .failure:
                self?.presenter.presentErrorAlert()
            }
        }
    }
}

