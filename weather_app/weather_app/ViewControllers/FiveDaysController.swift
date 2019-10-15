//
//  ViewController.swift
//  weather_app
//
//  Created by Tuukka Juusela on 08/10/2019.
//  Copyright © 2019 Tuukka Juusela. All rights reserved.
//

import UIKit

class FiveDaysController: UIViewController, UITableViewDataSource, UIWeatherRequestHandler {

    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var tableView: UITableView!
    
    var stuff = [] as [WeatherData]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.appDelegate.fiveDaysUIHandler = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stuff.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "weatherCellId"
        
        guard var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? WeatherCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        if cell == nil {
            cell = WeatherCell()
        }
        
        let data = self.stuff[indexPath.row]
        
        // Good idea to not implement substring method by Apple to String:)
        let hour = String(data.time[data.time.index(data.time.startIndex, offsetBy: 11)..<data.time.index(data.time.endIndex, offsetBy: -3)])
        let day = String(data.time[data.time.index(data.time.startIndex, offsetBy: 8)..<data.time.index(data.time.endIndex, offsetBy: -9)])
        let month = String(data.time[data.time.index(data.time.startIndex, offsetBy: 5)..<data.time.index(data.time.endIndex, offsetBy: -12)])
        
        cell.boldTitleLabel.text = "\(hour)"
        cell.normalTitleLabel.text = "\(day).\(month)"
        cell.subTitleLabel.text = "\(WeatherHelper.kelvinToCelcius(data.temp))°C"
        cell.subSubTitleLabel.text = data.desc
        cell.icon.image = WeatherHelper.iconStringToImage(iconString: data.icon)
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let data = appDelegate.weather.data {
            stuff = data
        }
    }
    
    func setData(_ data: [WeatherData]?) {
        if let data_ = data {
            self.stuff = data_
            tableView.reloadData()
        }
    }
    
    func setErrorUI() {
        
    }
    
    func setLoadingUI() {
        
    }
}

