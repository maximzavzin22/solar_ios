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
            if let result = json as? Dictionary<String,Any> {
                let success = result["success"] as? Bool ?? false
                if(!success) {
                    var error = CustomError()
                    error.title = NSLocalizedString("error", comment: "")
                    error.code = result["failCode"] as? Int ?? 0
                    error.message = result["message"] as? String ?? ""
                    return error
                }
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
            station.latitude = result["latitude"] as? String ?? "0.0"
            station.longitude = result["longitude"] as? String ?? "0.0"
            station.plantAddress = result["plantAddress"] as? String ?? ""
            station.plantCode = result["plantCode"] as? String ?? ""
            station.plantName = result["plantName"] as? String ?? ""
            return station
        }
        return nil
    }
    
    func stationRealKpisParse(json: Any) -> [StationRealKpi]? {
        if let result = json as? Dictionary<String,Any> {
            if let data = result["data"] as? Array<Dictionary<String,Any>> {
                var stationRealKpis = [StationRealKpi]()
                for dictionary in data as [[String: AnyObject]]  {
                    if let stationRealKpi = stationRealKpiParse(json: dictionary["dataItemMap"] as? Dictionary<String,Any>) {
                        stationRealKpi.stationCode = dictionary["stationCode"] as? String ?? ""
                        stationRealKpis.append(stationRealKpi)
                    }
                }
                return stationRealKpis
            }
        }
        return nil
    }

    func stationRealKpiParse(json: Any) -> StationRealKpi? {
        if let result = json as? Dictionary<String,Any> {
            var stationRealKpi = StationRealKpi()
            stationRealKpi.real_health_state = result["result"] as? Int ?? 0
            stationRealKpi.day_power = result["day_power"] as? Double ?? 0.0
            stationRealKpi.total_power = result["total_power"] as? Double ?? 0.0
            stationRealKpi.day_income = result["day_income"] as? Double ?? 0.0
            stationRealKpi.month_power = result["month_power"] as? Double ?? 0.0
            stationRealKpi.total_income = result["total_income"] as? Double ?? 0.0
            return stationRealKpi
        }
        return nil
    }
    
}
