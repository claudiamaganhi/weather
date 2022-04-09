import UIKit

protocol ViewControllerDisplaying: AnyObject {
    func displayWeatherDetails(with viewModel: WeatherViewModel)
    func startLoading()
    func stopLoading()
    func displayErrorAlert(title: String, message: String)
}

final class WeatherViewController: UIViewController {
    private lazy var loadingView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.isHidden = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, temperatureLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var weatherDetailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, weatherDetailLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private let interactor: WeatherInteracting
    
    init(interactor: WeatherInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        interactor.fetchWeather()
    }
    
    func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        view.addSubview(loadingView)
        view.addSubview(mainStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 50.0),
            imageView.heightAnchor.constraint(equalToConstant: 50.0),
            
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension WeatherViewController: ViewControllerDisplaying {
    func displayWeatherDetails(with viewModel: WeatherViewModel) {
        title = viewModel.city
        temperatureLabel.text = viewModel.temperature
        weatherDetailLabel.text = viewModel.weatherState
        imageView.image = viewModel.temperatureImage
    }
    
    func startLoading() {
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    func stopLoading() {
        loadingView.isHidden = true
        loadingView.stopAnimating()
    }
    
    func displayErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .destructive))
        present(alert, animated: true)
    }
}


