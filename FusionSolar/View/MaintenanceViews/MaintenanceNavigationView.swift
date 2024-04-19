//
//  MaintenanceNavigationView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit

class MaintenanceNavigationView: UIView {
    
    var maintenanceView: MaintenanceView?
    
    var selectePage: Int? {
        didSet {
            if((selectePage ?? 0) == 0) {
                alarmsButton.titleLabel?.font = .systemFont(ofSize: 24.dp)
                alarmsButton.titleLabel?.textColor = .rgb(1, green: 6, blue: 10)
                alarmsButton.tintColor = .rgb(1, green: 6, blue: 10)
                
                tasksButton.titleLabel?.font = .systemFont(ofSize: 18.dp)
                tasksButton.titleLabel?.textColor = .rgb(106, green: 106, blue: 106)
                tasksButton.tintColor = .rgb(106, green: 106, blue: 106)
            } else {
                tasksButton.titleLabel?.font = .systemFont(ofSize: 24.dp)
                tasksButton.titleLabel?.textColor = .rgb(1, green: 6, blue: 10)
                tasksButton.tintColor = .rgb(1, green: 6, blue: 10)
                
                alarmsButton.titleLabel?.font = .systemFont(ofSize: 18.dp)
                alarmsButton.titleLabel?.textColor = .rgb(106, green: 106, blue: 106)
                alarmsButton.tintColor = .rgb(106, green: 106, blue: 106)
            }
//            self.maintenanceView?.scrollToMenuIndex()
        }
    }
    
    let alarmsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle(NSLocalizedString("storage_alarms", comment: ""), for: .normal)
        button.sizeToFit()
        return button
    }()
    
    let tasksButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle(NSLocalizedString("tasks", comment: ""), for: .normal)
        button.sizeToFit()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.setupView()
        
        selectePage = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(alarmsButton)
        self.addSubview(tasksButton)
        
        self.addConstraintsWithFormat("H:|-\(26.dp)-[v0]-\(20.dp)-[v1]", views: alarmsButton, tasksButton)
        
        self.addConstraintsWithFormat("V:[v0]", views: alarmsButton)
        self.addConstraintsWithFormat("V:[v0]", views: tasksButton)
        
        alarmsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tasksButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        alarmsButton.addTarget(self, action: #selector(self.alarmsButtonPress), for: .touchUpInside)
        tasksButton.addTarget(self, action: #selector(self.tasksButtonPress), for: .touchUpInside)
    }
    
    @objc func alarmsButtonPress() {
        self.selectePage = 0
    }
    
    @objc func tasksButtonPress() {
        self.selectePage = 1
    }
}
