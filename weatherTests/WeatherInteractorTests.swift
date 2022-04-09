import Foundation
import XCTest
@testable import weather

final class PresenterSpy: WeatherPresenting {
    var controller: ViewControllerDisplaying?
    private(set) var presentWeatherDetailsCount = 0
    private(set) var startLoadingCount = 0
    private(set) var stopLoadingCount = 0
    private(set) var displayErrorAlertCount = 0
    
    private(set) var viewModel: WeatherViewModel?
    
    func presentWeatherDetails(with viewModel: WeatherViewModel) {
        presentWeatherDetailsCount += 1
        self.viewModel = viewModel
    }
    
    func startLoading() {
        startLoadingCount += 1
    }
    
    func stopLoading() {
        stopLoadingCount += 1
    }
    
    func presentErrorAlert() {
        displayErrorAlertCount += 1
    }
}

final class ServiceSpy: WeatherServicing {
    var expectedResult: Result<WeatherResponse, RequestError>?
    
    func fetchWeather(completion: @escaping (Result<WeatherResponse, RequestError>) -> Void) {
        guard let expectedResult = expectedResult else {
            return
        }
        completion(expectedResult)
    }
}

final class WeatherInteractorTests: XCTestCase {
    private let presenterSpy = PresenterSpy()
    private let service = ServiceSpy()
    private lazy var sut: WeatherInteractor = {
        let interactor = WeatherInteractor(service: service, presenter: presenterSpy)
        return interactor
    }()
    
    func testfetchWeather_WhenReceiveSuccessFromServer_ShouldCallPresentWeatherDetails() {
        let weatherDetail = WeatherDetailsResponse(weatherStateName: "Raining",
                                                   weatherStateAbbr: "r",
                                                   theTemp: 20.0)
        let response = WeatherResponse(consolidatedWeather: [weatherDetail], title: "Rio")
        service.expectedResult = .success(response)
        
        sut.fetchWeather()
        
        XCTAssertEqual(presenterSpy.startLoadingCount, 1)
        XCTAssertEqual(presenterSpy.stopLoadingCount, 1)
        XCTAssertEqual(presenterSpy.presentWeatherDetailsCount, 1)
        XCTAssertEqual(presenterSpy.viewModel?.city, response.title)
        XCTAssertEqual(presenterSpy.viewModel?.weatherState, response.consolidatedWeather[0].weatherStateName)
    }
    
    func testfetchWeather_WhenReceiveFailureFromServer_ShouldCallPresentErrorAlert() {
        service.expectedResult = .failure(.badRequest)
        
        sut.fetchWeather()
        
        XCTAssertEqual(presenterSpy.startLoadingCount, 1)
        XCTAssertEqual(presenterSpy.stopLoadingCount, 1)
        XCTAssertEqual(presenterSpy.displayErrorAlertCount, 1)
    }
}
