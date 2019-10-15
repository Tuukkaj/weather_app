//
//  ViewController.swift
//  weather_app
//
//  Created by Tuukka Juusela on 08/10/2019.
//  Copyright © 2019 Tuukka Juusela. All rights reserved.
//

import UIKit

class NowController: UIViewController, UIWeatherRequestHandler {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    let activityIndicator = UIActivityIndicatorView(style: .large)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.nowUIHandler = self
        
        activityIndicator.frame = weatherIcon.frame
        activityIndicator.color = .systemBlue
        activityIndicator.hidesWhenStopped = true
        weatherIcon.addSubview(activityIndicator)
        
        setLoadingUI()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        setInfo(appDelegate.weather.data)
    }
    
    func setData(_ data: [WeatherData]?) {
        setInfo(data)
    }
    
    func setErrorUI() {
        weatherIcon.image = UIImage(systemName: "exclamationmark.icloud.fill")
        locationLabel.text = "Error"
        temperatureLabel.text = "Check GPS or city name"
        descLabel.text = nil
    }
    
    func setLoadingUI() {
        weatherIcon.image = nil
        activityIndicator.startAnimating()
        locationLabel.text = "Loading..."
        temperatureLabel.text = nil
        descLabel.text = nil 
    }
    
    func setInfo(_ dataOpt:[WeatherData]?) {
        if let data = dataOpt {
            activityIndicator.stopAnimating()
            let closestTime = data[WeatherHelper.getClosestTimeIndex()]
            
            let cityOpt = UserDefaults.standard.string(forKey: Constants.PREF_SELECTED_CITY)
            
            if let city = cityOpt {
                locationLabel.text = city
            } else {
                locationLabel.text = Constants.CURRENT_LOCATION_TEXT
            }
            
            weatherIcon.image = WeatherHelper.iconStringToImage(iconString: closestTime.icon)
            temperatureLabel.text = String("\(WeatherHelper.kelvinToCelcius(closestTime.temp))°C")
            descLabel.text = closestTime.desc
        } else {
            NSLog("EMPTY DATA")
        }
    }

}

