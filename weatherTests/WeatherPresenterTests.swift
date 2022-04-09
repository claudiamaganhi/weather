import Foundation
import XCTest
@testable import weather

final class ControllerSpy: ViewControllerDisplaying {
    private(set) var displayWeatherDetailsCount = 0
    private(set) var startLoadingCount = 0
    private(set) var stopLoadingCount = 0
    private(set) var displayErrorAlertCount = 0
    
    private(set) var viewModel: WeatherViewModel?
    
    func displayWeatherDetails(with viewModel: WeatherViewModel) {
        displayWeatherDetailsCount += 1
        self.viewModel = viewModel
    }
    
    func startLoading() {
        startLoadingCount += 1
    }
    
    func stopLoading() {
        stopLoadingCount += 1
    }
    
    func displayErrorAlert(title: String, message: String) {
        displayErrorAlertCount += 1
    }
}

final class WeatherPresenterTests: XCTestCase {
    private let spy = ControllerSpy()
    
    private lazy var sut: WeatherPresenter = {
        let presenter = WeatherPresenter()
        presenter.controller = spy
        return presenter
    }()
    
    func testDisplayWeatherDetails_WhenCalledFromInteractor_ShouldCallDisplayWeatherDetails() {
        sut.presentWeatherDetails(with: .mock)
        
        XCTAssertEqual(spy.displayWeatherDetailsCount, 1)
        XCTAssertEqual(spy.viewModel?.city, WeatherViewModel.mock.city)
        XCTAssertEqual(spy.viewModel?.weatherState, WeatherViewModel.mock.weatherState)
        XCTAssertEqual(spy.viewModel?.temperature, WeatherViewModel.mock.temperature)
        XCTAssertEqual(spy.viewModel?.temperatureImage, WeatherViewModel.mock.temperatureImage)
    }
    
    func testStartLoading_WhenCalledFromInteractor_ShouldCallStartLoading() {
        sut.startLoading()
        
        XCTAssertEqual(spy.startLoadingCount, 1)
    }
    
    func testStopLoading_WhenCalledFromInteractor_ShouldCallStopLoading() {
        sut.stopLoading()
        
        XCTAssertEqual(spy.stopLoadingCount, 1)
    }
    
    func testPresentErrorAlert_WhenCalledFromInteractor_ShouldCallDisplayError() {
        sut.presentErrorAlert()
        
        XCTAssertEqual(spy.displayErrorAlertCount, 1)
    }
}
