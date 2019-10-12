//
//  WeatherData.swift
//  weather_app
//
//  Created by Tuukka Juusela on 12/10/2019.
//  Copyright © 2019 Tuukka Juusela. All rights reserved.
//

import Foundation

class WeatherData: NSObject, NSCoding {
    var icon : String
    var temp : Float
    var desc : String
    
    init(icon:String, temp:Float, desc:String) {
        self.icon = icon
        self.temp = temp
        self.desc = desc
    }
    
    required init(coder decoder: NSCoder) {
        self.icon = decoder.decodeObject(forKey: "weatherIcon") as! String
        self.temp = decoder.decodeFloat(forKey: "weatherTemp")
        self.desc = decoder.decodeObject(forKey: "weatherDesc") as! String
    }
    
    func encode(with encoder: NSCoder) {
        encoder.encode(icon, forKey: "weatherIcon")
        encoder.encode(temp, forKey: "weatherTemp")
        encoder.encode(desc, forKey: "weatherDesc")
    }
}
