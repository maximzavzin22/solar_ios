//
//  DetailRealKpi.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 24/04/24.
//

import UIKit

class DetailRealKpi: NSObject {
    var id: Int?
    var installed_capacity: Double?
    var radiation_intensity: Double?
    var inverter_power: Double?
    var ongrid_power: Double?
    var power_profit: Double?
    var theory_power: Double?
    var collectTime: Int64?
    var use_power: Double?
    var perpower_ratio: Double?
    var reduction_total_co2: Double?
    var reduction_total_coal: Double?
    var reduction_total_tree: Double?
    var date: Date?
}

class GraphValue: NSObject {
    var key: String?
    var powerProfit: Double?
    var inverterPower: Double?
}
