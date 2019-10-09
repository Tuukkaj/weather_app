//
//  AppDelegate.swift
//  weather_app
//
//  Created by Tuukka Juusela on 08/10/2019.
//  Copyright © 2019 Tuukka Juusela. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    var gps : CLLocationManager?
    var weather = Weather()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.gps = CLLocationManager()
        
        gps?.requestAlwaysAuthorization()
        self.gps?.delegate = self
        fetchWeather()
        
        return true
    }

     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            weather.coordinate = coordinate
            fetchWeather()
            gps?.stopUpdatingLocation()
        }
    }
    
    func fetchUrl(url : String) {
        let config = URLSessionConfiguration.default

        let session = URLSession(configuration: config)

        let url : URL? = URL(string: url)

        let task = session.dataTask(with: url!, completionHandler: doneFetching);

        // Starts the task, spawns a new thread and calls the callback function
        task.resume();

     }
     
     func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        NSLog(String(describing: data))
        if let data_ = data {
            let resstr = String(data: data_, encoding: String.Encoding.utf8)

            // Execute stuff in UI thread
            DispatchQueue.main.async(execute: {() in
             NSLog(resstr!)
            })
        } else {
            NSLog("No data in response")
        }

     }
    
    func fetchWeather() {
        NSLog("FETCH WEATHER")
        
        let selectedCity = UserDefaults.standard.string(forKey: Constants.PREF_SELECTED_CITY)
        
        var stringURL : String?
        
        if let city = selectedCity {
            if city != Constants.CURRENT_LOCATION_TEXT {
                stringURL = "https://api.openweathermap.org/data/2.5/forecast?q=\(city.lowercased()),fi&mode=json&appid=\(Keys.WEATHER_KEY)"
            } else {
                if let coord = weather.coordinate {
                    stringURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(coord.latitude)&lon=\(coord.longitude)&mode=json&appid=f7c8b790eb8f30eb907abc83cb56dcfe"
                } else {
                    stringURL = nil
                }
            }
        } else {
            if let coord = weather.coordinate {
                stringURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(coord.latitude)&lon=\(coord.longitude)&mode=json&appid=f7c8b790eb8f30eb907abc83cb56dcfe"
            } else {
                stringURL = nil
            }
        }
        
        if let stringURL_ = stringURL {
            fetchUrl(url: stringURL_)
            NSLog(stringURL_)
        } else {
            self.gps?.startUpdatingLocation()
        }
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

