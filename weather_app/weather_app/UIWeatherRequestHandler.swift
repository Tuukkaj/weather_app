//
//  Runnable.swift
//  weather_app
//
//  Created by Tuukka Juusela on 13/10/2019.
//  Copyright © 2019 Tuukka Juusela. All rights reserved.
//

protocol UIWeatherRequestHandler {
    func setData(_ data: [WeatherData]?)
    func setLoadingUI()
    func setErrorUI()
}
