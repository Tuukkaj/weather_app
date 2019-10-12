//
//  ViewController.swift
//  weather_app
//
//  Created by Tuukka Juusela on 08/10/2019.
//  Copyright © 2019 Tuukka Juusela. All rights reserved.
//

import UIKit

class CitiesController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var stuff = [] as [String]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let selectedCity = UserDefaults.standard.string(forKey: Constants.PREF_SELECTED_CITY)
        
        if let selectedCity_ = selectedCity {
            cityNameLabel.text = selectedCity_
        } else {
            cityNameLabel.text = Constants.CURRENT_LOCATION_TEXT
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stuff.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaultDB = UserDefaults.standard
        defaultDB.set(stuff[indexPath.row], forKey: Constants.PREF_SELECTED_CITY)
        defaultDB.synchronize()
        
        cityNameLabel.text = stuff[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cityCellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        cell!.textLabel!.text = self.stuff[indexPath.row]
        
        if (indexPath.row != 0) {
            cell!.imageView?.image = UIImage(systemName: "trash")
            
            cell!.imageView?.isUserInteractionEnabled = true
            cell?.imageView?.tag = indexPath.row
            let singleTap = UITapGestureRecognizer(target: self,  action: #selector(deleteFromStuff(tapGesture:)))
                
            cell?.imageView?.addGestureRecognizer(singleTap)
        }

        return cell!
    }

    @objc func deleteFromStuff(tapGesture: UITapGestureRecognizer) {
            let imgView = tapGesture.view as! UIImageView
            let tag = imgView.tag
            let defaultDB = UserDefaults.standard
        
            //Setting table data
            var selectedCities = defaultDB.array(forKey: Constants.PREF_CITIES) as! [String]
                NSLog("\(String(describing: tag))")
            let removed = selectedCities.remove(at: tag - 1 )
            
            var temp = [Constants.CURRENT_LOCATION_TEXT]
            temp += selectedCities
            stuff = temp
           
            defaultDB.set(selectedCities, forKey: Constants.PREF_CITIES)
            
            // Setting label name
            let currentSelection = defaultDB.string(forKey: Constants.PREF_SELECTED_CITY)
            
            if (currentSelection == removed) {
                defaultDB.set(Constants.CURRENT_LOCATION_TEXT, forKey: Constants.PREF_SELECTED_CITY)
                cityNameLabel.text = Constants.CURRENT_LOCATION_TEXT
            }
            
            defaultDB.synchronize()
            
            tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        var tempStuff = [Constants.CURRENT_LOCATION_TEXT]
        
        let prefCities = UserDefaults.standard.array(forKey: Constants.PREF_CITIES)
        
        if let prefCities_ = prefCities {
            tempStuff += prefCities_ as! [String]
        }
        
        stuff = tempStuff
        
        tableView.reloadData()
    }
}
