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
                    
        // Some icons have different options depending on if it's night or day in OpenWeather.
        // In first switch case are icons which could be different depending on if it's night or day.
        // In second are icons which should be similiar on night and day.
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
                let hour = Calendar.current.component(.hour, from: Date())

                if hour > 7 && hour < 21 {
                    systemIcon = "sun.max.fill"
                } else {
                    systemIcon = "moon.fill"
                }
            }
        }
        
        return UIImage(systemName: systemIcon)!
    }
    
    static func getClosestTimeIndex() -> Int {
        let date = Date()
        let hours = Calendar.current.component(.hour, from: date)
        let minutes = Float(Calendar.current.component(.minute, from: date)) / 60
        let time = Float(hours) + minutes
        
        let times = getClosestThreeHours(time)
        
        let diff1 = abs(times.0 - time)
        let diff2 = abs(times.1 - time)
        
        return diff1 <= diff2 ? 0 : 1
    }
    
    static func getClosestThreeHours(_ time: Float) -> (Float, Float) {
        let times : [Float] = [0,3,6,9,12,15,18,21]
        
        for i in 0..<times.count {
            let k = i == times.count - 1 ? 24.00 : times[i + 1]
            
            if (time > times[i] && time < k) {
                return (times[i], k)
            }
        }
        
        return (-1, -1)
    }
}
