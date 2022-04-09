import UIKit

protocol WeatherPresenting: AnyObject {
    var controller: ViewControllerDisplaying? { get set }
    func presentWeatherDetails(with viewModel: WeatherViewModel)
    func startLoading()
    func stopLoading()
    func presentErrorAlert()
}

final class WeatherPresenter: WeatherPresenting {
    weak var controller: ViewControllerDisplaying?
    
    func presentWeatherDetails(with viewModel: WeatherViewModel) {
        controller?.displayWeatherDetails(with: viewModel)
    }
    
    func startLoading() {
        controller?.startLoading()
    }
    
    func stopLoading() {
        controller?.stopLoading()
    }
    
    func presentErrorAlert() {
        controller?.displayErrorAlert(title: "Ops...", message: "Something went wrong")
    }
}
