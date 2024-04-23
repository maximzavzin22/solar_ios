//
//  MaintenanceView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit

class MaintenanceView: UIView {
    
    var homeController: HomeController?
    
    let topWhiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var alarmsView: AlarmsView = {
        let view = AlarmsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.maintenanceView = self
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(topWhiteView)
        self.addSubview(alarmsView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topWhiteView)
        self.addConstraintsWithFormat("H:|[v0]|", views: alarmsView)
        
        self.addConstraintsWithFormat("V:|[v0(\(100.dp))]", views: topWhiteView)

        alarmsView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        alarmsView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
