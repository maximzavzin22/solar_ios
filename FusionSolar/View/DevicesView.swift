//
//  DevicesView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit

class DevicesView: UIView {
    
    var homeController: HomeController?
    
    var topSafeArea: CGFloat = 0.0
    
    //topView
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(241, green: 243, blue: 245)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("devices", comment: "")
        label.font = .boldSystemFont(ofSize: 24.dp)
        label.textColor = .rgb(1, green: 6, blue: 10)
        return label
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupTopView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(topView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topView)
        
        let window = UIApplication.shared.keyWindow
        topSafeArea = window?.safeAreaInsets.top ?? 0.0
        
        self.addConstraintsWithFormat("V:|[v0(\(125.dp + topSafeArea))]", views: topView)
    }
    
    func setupTopView() {
        topView.addSubview(titleLabel)
        
        topView.addConstraintsWithFormat("H:|-\(25.dp)-[v0]", views: titleLabel)
        
        topView.addConstraintsWithFormat("V:|-\(16.dp + topSafeArea)-[v0]", views: titleLabel)
    }
}

class SearchDevicesView: UIView {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
}
