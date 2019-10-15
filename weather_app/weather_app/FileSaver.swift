//
//  FileSaver.swift
//  weather_app
//
//  Created by Tuukka Juusela on 12/10/2019.
//  Copyright © 2019 Tuukka Juusela. All rights reserved.
//

import Foundation

class FileSaver {
    static func giveDirectory() -> String {
        let documentDirectories =
            NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                FileManager.SearchPathDomainMask.userDomainMask, true)
        
        let documentDirectory = documentDirectories[0]
        let pathWithFileName = "\(documentDirectory)/filename.txt"

        return pathWithFileName
    }
    
    static func saveObject(data:[WeatherData]) {
        let pathWithFileName = self.giveDirectory()
     
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
            try data.write(to: URL(fileURLWithPath: pathWithFileName))
        } catch {
            NSLog("error")
        }
    }
    
    static func removeFile() {
        let path = giveDirectory()
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch let error as NSError {
            
        }
    }
    
    static func loadObject() -> [WeatherData]? {
        let pathWithFileName = self.giveDirectory()
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: pathWithFileName))
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [WeatherData]
        } catch {
            NSLog("error")
        }
        
        return nil
    }
}
