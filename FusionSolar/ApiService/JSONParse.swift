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
                let error = CustomError()
                error.title = NSLocalizedString("error", comment: "")
                error.code = errorDictionary["code"] as? Int ?? 0
                error.message = errorDictionary["message"] as? String ?? ""
                return error
            }
            if let messageDictionary = result["message"] as? Dictionary<String,Any> {
                let error = CustomError()
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
            let error = CustomError()
            error.title = NSLocalizedString("error", comment: "")
            error.code = result["errors"] as? Int ?? 0
            error.message = result["message"] as? String ?? ""
            return error
        }
        return nil
    }
    
    func stationsParse(json: Any) -> [Station]? {
        if let result = json as? Dictionary<String,Any> {
            if let list = result["result"] as? Array<Dictionary<String,Any>> {
                var stations = [Station]()
                for stationDictionary in list as [[String: AnyObject]] {
                    if let station = stationParse(json: stationDictionary) {
                        stations.append(station)
                    }
                }
                return stations
            }
        }
        return nil
    }

    func stationParse(json: Any) -> Station? {
        if let result = json as? Dictionary<String,Any> {
            let station = Station()
            station.id = result["id"] as? Int ?? 0
            station.capacity = result["capacity"] as? Double ?? 0.0
            station.contactMethod = result["contact_method"] as? String ?? ""
            station.contactPerson = result["contact_person"] as? String ?? ""
            station.gridConnectionDate = result["gridConnectionDate"] as? String ?? ""
            station.latitude = result["latitude"] as? String ?? "0.0"
            station.longitude = result["longitude"] as? String ?? "0.0"
            station.plantAddress = result["plant_address"] as? String ?? ""
            station.plantCode = result["plant_code"] as? String ?? ""
            station.plantName = result["plantName"] as? String ?? ""
            station.mountedDn = result["mounted_dn"] as? String ?? ""
            
            if let stationRealKpi = kpiParse(json: result["kpi"]) {
                station.stationRealKpi = stationRealKpi
            }
            
            return station
        }
        return nil
    }
    
    func kpiParse(json: Any) -> StationRealKpi? {
        if let result = json as? Dictionary<String,Any> {
            let stationRealKpi = StationRealKpi()
            stationRealKpi.day_power = result["day_power"] as? Double ?? 0.0
            stationRealKpi.month_power = result["month_power"] as? Double ?? 0.0
            stationRealKpi.total_power = result["total_power"] as? Double ?? 0.0
            stationRealKpi.day_income = result["day_income"] as? Double ?? 0.0
            stationRealKpi.total_income = result["total_income"] as? Double ?? 0.0
            stationRealKpi.real_health_state = result["real_health_state"] as? Int ?? 0
            stationRealKpi.stationCode = result["station_code"] as? String ?? ""
            return stationRealKpi
        }
        return nil
    }
    
    //sablab
    func profileParse(json: Any) -> Profile? {
        if let result = json as? Dictionary<String,Any> {
            let profile = Profile()
            profile.id = result["id"] as? Int ?? 0
            profile.username = result["username"] as? String ?? ""
            profile.role = result["role"] as? String ?? ""
            profile.email = result["email"] as? String ?? ""
            profile.company_name = result["company_name"] as? String ?? ""
            profile.user_id = result["user_id"] as? Int ?? 0
            profile.company_id = result["company_id"] as? Int ?? 0
            profile.company_dn = result["company_dn"] as? String ?? ""
            profile.access_token = result["access_token"] as? String ?? ""
            return profile
        }
        return nil
    }
    //
}

