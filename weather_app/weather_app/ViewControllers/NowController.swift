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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.nowUIHandler = self
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        setInfo(appDelegate.weather.data)
    }
    
    func setData(_ data: [WeatherData]?) {
        setInfo(data)
    }
    
    func setErrorUI() {
        
    }
    
    func setLoadingUI() {
        
    }
    
    func setInfo(_ dataOpt:[WeatherData]?) {
        if let data = dataOpt {
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

