//
//  UnissoLogin.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 05/09/23.
//

import UIKit

class UnissoLogin: Codable {
    var body: UnissoLoginBody?
    var url: String?
}

class UnissoLoginBody: Codable {
    var organizationName: String?
    var username: String?
    var password: String?
    var verifycode: String?
    var multiRegionName: String?
}
