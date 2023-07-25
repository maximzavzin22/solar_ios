//
//  JSONParse.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 20/07/23.
//

import UIKit

class JSONParse: NSObject {
 
    static let sharedInstance = JSONParse()
    
    func errorParse(json: Any) -> CustomError? {
        if let result = json as? Dictionary<String,Any> {
            if let errorDictionary = result["error"] as? Dictionary<String,Any> {
                var error = CustomError()
                error.title = NSLocalizedString("error", comment: "")
                error.code = errorDictionary["code"] as? Int ?? 0
                error.message = errorDictionary["message"] as? String ?? ""
                return error
            }
            if let messageDictionary = result["message"] as? Dictionary<String,Any> {
                var error = CustomError()
                var messages = [String]()
                if let messageErrors = messageDictionary["login"] as? Array<String> {
                    for message in messageErrors as [String] {
                        messages.append(message)
                    }
                }
                error.message = messages[0]
                error.title = NSLocalizedString("error", comment: "")
                error.code = result["errors"] as? Int ?? 0
                return error
            }
            var error = CustomError()
            error.title = NSLocalizedString("error", comment: "")
            error.code = result["errors"] as? Int ?? 0
            error.message = result["message"] as? String ?? ""
            return error
        }
        return nil
    }
    
    func stationsParse(json: Any) -> [Station]? {
        if let result = json as? Dictionary<String,Any> {
            if let data = result["data"] as? Dictionary<String,Any> {
                if let list = data["list"] as? Array<Dictionary<String,Any>> {
                    var stations = [Station]()
                    for stationDictionary in list as [[String: AnyObject]] {
                        if let station = stationParse(json: stationDictionary) {
                            stations.append(station)
                        }
                    }
                    return stations
                }
            }
        }
        return nil
    }

    func stationParse(json: Any) -> Station? {
        if let result = json as? Dictionary<String,Any> {
            var station = Station()
            station.capacity = result["capacity"] as? Double ?? 0.0
            station.contactMethod = result["contactMethod"] as? String ?? ""
            station.contactPerson = result["contactPerson"] as? String ?? ""
            station.gridConnectionDate = result["gridConnectionDate"] as? String ?? ""
            station.latitude = result["latitude"] as? String ?? ""
            station.longitude = result["longitude"] as? String ?? ""
            station.plantAddress = result["plantAddress"] as? String ?? ""
            station.plantCode = result["plantCode"] as? String ?? ""
            station.plantName = result["plantName"] as? String ?? ""
            return station
        }
        return nil
    }
    
}
