//
//  IconToImage.swift
//  weather_app
//
//  Created by Tuukka Juusela on 13/10/2019.
//  Copyright © 2019 Tuukka Juusela. All rights reserved.
//

import UIKit


class WeatherHelper {
    static func iconStringToImage(iconString:String) -> UIImage {
        var systemIcon : String
        
        let hour = Calendar.current.component(.hour, from: Date())
                
        // Some icons have different options depending on if it's night or day in OpenWeather. In first switch case are icons which could be different depending on if it's night or day. In second are icons which should be similiar on night and day.
        switch iconString {
        case "01d":
            systemIcon = "sun.max.fill"
        case "01n":
            systemIcon = "moon.fill"
        case "02d":
            systemIcon = "cloud.sun.fill"
        case "02n":
            systemIcon = "cloud.moon.fill"
        case "10d":
            systemIcon = "cloud.sun.rain.fill"
        case "10n":
            systemIcon = "cloud.moon.fill"
        default:
            switch String(iconString.prefix(2)) {
            case "03":
                systemIcon = "cloud.fill"
            case "04":
                systemIcon = "cloud.fill"
            case "09":
                systemIcon = "cloud.rain.fill"
            case "11":
                systemIcon = "cloud.bolt.fill"
            case "13":
                systemIcon = "cloud.snow.fill"
            case "50":
                systemIcon = "cloud.fog.fill"
            default:
                if hour > 7 && hour < 21 {
                    systemIcon = "sun.max.fill"
                } else {
                    systemIcon = "moon.fill"
                }
            }
        }
        
        return UIImage(systemName: systemIcon)!
    }
}
