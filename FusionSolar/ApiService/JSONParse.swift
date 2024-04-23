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
            
            station.devices = devicesParse(json: result["devices"])
            
            station.alarms = alarmsParse(json: result["alarms"])
            
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
    
    func devicesParse(json: Any) -> [Device]? {
        if let result = json as? Array<Dictionary<String,Any>> {
            var devices = [Device]()
            for deviceDictionary in result as [[String: AnyObject]] {
                if let device = deviceParse(json: deviceDictionary) {
                    devices.append(device)
                }
            }
            return devices
        }
        return nil
    }
    
    func deviceParse(json: Any) -> Device? {
        if let result = json as? Dictionary<String,Any> {
            let device = Device()
            device.id = result["id"] as? Int64 ?? -1
            device.devName = result["dev_name"] as? String ?? ""
            device.dev_dn = result["dev_dn"] as? String ?? ""
            device.stationCode = result["station_code"] as? String ?? ""
            device.esnCode = result["esn_code"] as? String ?? ""
            device.devTypeId = result["dev_type_id"] as? Int ?? -1
            device.softwareVersion = result["software_version"] as? String ?? ""
            device.optimizer_number = result["optimizer_number"] as? String ?? ""
            device.invType = result["inv_type"] as? String ?? ""
            device.latitude = result["latitude"] as? Double ?? 0.0
            device.longitude = result["longitude"] as? Double ?? 0.0
            return device
        }
        return nil
    }
    
    func alarmsParse(json: Any) -> [Alarm]? {
        if let result = json as? Array<Dictionary<String,Any>> {
            var alarms = [Alarm]()
            for alarmDictionary in result as [[String: AnyObject]] {
                if let alarm = alarmParse(json: alarmDictionary) {
                    alarms.append(alarm)
                }
            }
            return alarms
        }
        return nil
    }
    
    func alarmParse(json: Any) -> Alarm? {
        if let result = json as? Dictionary<String,Any> {
            let alarm = Alarm()
            alarm.alarmId = result["alarm_id"] as? Int ?? -1
            alarm.alarmCause = result["alarm_cause"] as? String ?? ""
            alarm.alarmName = result["alarm_name"] as? String ?? ""
            alarm.alarmType = result["alarm_type"] as? Int ?? -1
            alarm.causeId = result["cause_id"] as? Int ?? -1
            alarm.devName = result["dev_name"] as? String ?? ""
            alarm.devTypeId = result["dev_type_id"] as? Int ?? -1
            alarm.esnCode = result["esn_code"] as? String ?? ""
            alarm.lev = result["lev"] as? Int ?? -1
            alarm.raiseTime = result["raise_time"] as? Int64 ?? -1
            alarm.repairSuggestion = result["repair_suggestion"] as? String ?? ""
            alarm.stationCode = result["station_code"] as? String ?? ""
            alarm.stationName = result["station_name"] as? String ?? ""
            alarm.status = result["status"] as? Int ?? -1
            return alarm
        }
        return nil
    }
    
    func regionsParse(json: Any) -> [Region]? {
        if let result = json as? Dictionary<String,Any> {
            if let list = result["result"] as? Array<Dictionary<String,Any>> {
                var regions = [Region]()
                for regionDictionary in list as [[String: AnyObject]] {
                    if let region = regionParse(json: regionDictionary) {
                        regions.append(region)
                    }
                }
                return regions
            }
        }
        return nil
    }
    
    func regionParse(json: Any) -> Region? {
        if let result = json as? Dictionary<String,Any> {
            let region = Region()
            region.id = result["id"] as? Int ?? 0
            region.is_parent = result["is_parent"] as? Bool ?? false
            region.node_name = result["node_name"] as? String ?? ""
            region.element_id = result["element_id"] as? String ?? ""
            region.element_dn = result["element_dn"] as? String ?? ""
            region.parent_dn = result["parent_dn"] as? String ?? ""
            region.node_icon = result["node_icon"] as? String ?? ""
            region.status = result["status"] as? String ?? ""
            region.type_id = result["type_id"] as? Int ?? 0
            region.moc_id = result["moc_id"] as? Int ?? 0
            region.has_more_child = result["has_more_child"] as? Bool ?? false
            return region
        }
        return nil
    }
}

