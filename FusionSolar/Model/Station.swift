//
//  Station.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit

class Station: NSObject {
    var id: Int?
    var capacity: Double?
    var contactMethod: String?
    var contactPerson: String?
    var gridConnectionDate: String?
    var latitude: String?
    var longitude: String?
    var plantAddress: String?
    var plantCode: String?
    var plantName: String?
    var mountedDn: String?
    var status: Int? //1-normal//2-faulity//3-offline
    var attitude: Double?
    
    var alarms: [Alarm]?
    var stationRealKpi: StationRealKpi?
    var devices: [Device]?
}
