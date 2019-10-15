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
        
        if data.icon == Constants.LOADING_CELL_ICON {
            cell.icon.image = nil
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = .systemBlue
            cell.icon.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            cell.boldTitleLabel.text = "Loading..."
            cell.normalTitleLabel.text = nil
            cell.subTitleLabel.text = nil
            cell.subSubTitleLabel.text = nil
        } else if data.icon == Constants.ERROR_CELL_ICON {
            cell.icon.image = UIImage(systemName: "exclamationmark.icloud.fill")
            cell.boldTitleLabel.text = "Error"
            cell.normalTitleLabel.text = nil
            cell.subTitleLabel.text = "Check GPS or city name"
            cell.subSubTitleLabel.text = nil
        } else {
            // Good idea to not implement substring method by Apple to String:)
            let hour = String(data.time[data.time.index(data.time.startIndex, offsetBy: 11)..<data.time.index(data.time.endIndex, offsetBy: -3)])
            let day = String(data.time[data.time.index(data.time.startIndex, offsetBy: 8)..<data.time.index(data.time.endIndex, offsetBy: -9)])
            let month = String(data.time[data.time.index(data.time.startIndex, offsetBy: 5)..<data.time.index(data.time.endIndex, offsetBy: -12)])
            
            cell.boldTitleLabel.text = "\(hour)"
            cell.normalTitleLabel.text = "\(day).\(month)"
            cell.subTitleLabel.text = "\(WeatherHelper.kelvinToCelcius(data.temp))°C"
            cell.subSubTitleLabel.text = data.desc
            cell.icon.image = WeatherHelper.iconStringToImage(iconString: data.icon)
        }

        
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
        stuff = [] as [WeatherData]
        stuff.append(WeatherData(icon: Constants.ERROR_CELL_ICON, temp: 0, desc: "", time: ""))
        tableView.reloadData()
    }
    
    func setLoadingUI() {
        stuff = [] as [WeatherData]
        stuff.append(WeatherData(icon: Constants.LOADING_CELL_ICON, temp: 0, desc: "", time: ""))
        tableView.reloadData()
    }
}

