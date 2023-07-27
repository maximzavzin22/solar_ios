//
//  StationLayotView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 27/07/23.
//

import UIKit

class StationLayotView: UIView {
    
    var overviewController: OverviewController?
    
    let whiteTopView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let emptyView: EmptyDataView = {
        let view = EmptyDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        let window = UIApplication.shared.keyWindow
        var topSafeArea = window?.safeAreaInsets.top ?? 0

        self.addSubview(whiteTopView)
        self.addSubview(emptyView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: whiteTopView)
        self.addConstraintsWithFormat("H:[v0(\(143.dp))]", views: emptyView)
        
        self.addConstraintsWithFormat("V:|[v0(\(70.dp + topSafeArea))]", views: whiteTopView)
        self.addConstraintsWithFormat("V:[v0(\(154.dp))]", views: emptyView)
        
        emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        emptyView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
