//
//  WeatherData.swift
//  weather_app
//
//  Created by Tuukka Juusela on 11/10/2019.
//  Copyright © 2019 Tuukka Juusela. All rights reserved.
//

import Foundation

class WeatherModel {
    struct Weather : Decodable {
        var weather : [Description]
        var main : Data
    }
    
    struct Data : Decodable {
        var temp : Float
    }

    struct Description : Decodable {
        var icon : String
        var main : String
    }
    
    struct WeatherData : Decodable {
        var list : [Weather]
    }
}
