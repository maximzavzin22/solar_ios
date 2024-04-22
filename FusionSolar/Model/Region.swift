//
//  Region.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 22/04/24.
//

import UIKit

class Region: NSObject {
    var id: Int?
    var is_parent: Bool?
    var node_name: String?
    var element_id: String?
    var element_dn: String?
    var parent_dn: String?
    var node_icon: String?
    var status: String?
    var type_id: Int?
    var moc_id: Int?
    var has_more_child: Bool?
    var isOpen: Bool?
    var isSelected: Bool?
    var regions: [Region]?
}
