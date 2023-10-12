//
//  Station.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit

class Station: NSObject {
    var capacity: Double?
    var contactMethod: String?
    var contactPerson: String?
    var gridConnectionDate: String?
    var latitude: String?
    var longitude: String?
    var plantAddress: String?
    var plantCode: String?
    var plantName: String?
    var status: Int? //1-normal//2-faulity//3-offline
    
    var alarms: [Alarm]?
    var stationRealKpi: StationRealKpi?
}



