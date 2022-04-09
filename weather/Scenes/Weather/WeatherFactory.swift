import UIKit

enum WeatherFactory {
    static func make() -> UIViewController {
        let service: WeatherServicing = WeatherService()
        let presenter: WeatherPresenting = WeatherPresenter()
        let interactor: WeatherInteracting = WeatherInteractor(service: service, presenter: presenter)
        let controller = WeatherViewController(interactor: interactor)
        presenter.controller = controller
        
        return controller
    }
}
