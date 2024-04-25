//
//  DetailRealKpi.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 24/04/24.
//

import UIKit

class DetailRealKpi: NSObject {
    var id: Int?
    var radiation_intensity: Double?
    var inverter_power: Double?
    var ongrid_power: Double?
    var power_profit: Double?
    var theory_power: Double?
    var collectTime: Int64?
    var date: Date?
}

class GraphValue: NSObject {
    var key: String?
    var value: Double?
}
