import UIKit

protocol ViewControllerDisplaying {
    func displayWeatherDetails()
}

class WeatherViewController: UIViewController {
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
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
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, weatherDetailLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        displayWeatherDetails()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(mainStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80.0),
            imageView.heightAnchor.constraint(equalToConstant: 80.0),
            
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension WeatherViewController: ViewControllerDisplaying {
    func displayWeatherDetails() {
        title = "PAÍS"
        temperatureLabel.text = "42"
        weatherDetailLabel.text = "quentao"
        imageView.image = getWeatherImage(acronym: "sn")
    }
}


