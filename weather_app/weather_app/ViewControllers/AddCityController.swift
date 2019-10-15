//
//  ViewController.swift
//  weather_app
//
//  Created by Tuukka Juusela on 08/10/2019.
//  Copyright © 2019 Tuukka Juusela. All rights reserved.
//

import UIKit

class AddCityController: UIViewController {

    @IBOutlet weak var cityNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func addClicked(_ sender: Any) {
        let defaultDB = UserDefaults.standard
        
        if let city = cityNameField.text {
            if city.count > 0 {
                var cities = [] as [Any]
                let prefCities = defaultDB.array(forKey: Constants.PREF_CITIES)
                
                if let prefCities_ = prefCities {
                    cities += prefCities_
                }
                
                cities.append(city)
                defaultDB.set(cities, forKey: Constants.PREF_CITIES)
                defaultDB.synchronize()
                self.navigationController?.popViewController(animated: true)
            } else {
                let alertController = UIAlertController(title: "Error", message: "You can't enter empty city name", preferredStyle: .alert)

                let infoAction = UIAlertAction(title: "Okay", style: .default) { (action) in
                }
                
                alertController.addAction(infoAction)
                
                self.present(alertController, animated: true, completion: {() -> Void in })
            }
        }
    }
}

