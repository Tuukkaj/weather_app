//
//  DateExtension.swift
//  weather_app
//
//  Created by Tuukka Juusela on 11/10/2019.
//  Copyright © 2019 Tuukka Juusela. All rights reserved.
//

import Foundation

extension Date {
    func toSeconds() -> Double {
        return self.timeIntervalSince1970
    }
}
