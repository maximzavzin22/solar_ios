//
//  HomeView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit

class HomeView: UIView {
    
    var homeController: HomeController?
    
    let topWhiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var plantsView: PlantsView = {
        let view = PlantsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeView = self
        return view
    }()
    
    lazy var mapView: MapView = {
        let view = MapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeView = self
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
        self.addSubview(plantsView)
        self.addSubview(mapView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topWhiteView)
        self.addConstraintsWithFormat("H:|[v0]|", views: plantsView)
        self.addConstraintsWithFormat("H:|[v0]|", views: mapView)
        
        self.addConstraintsWithFormat("V:|[v0(\(100.dp))]", views: topWhiteView)
        
        plantsView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        plantsView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.showMapView(isMap: false)
    }
    
    func showMapView(isMap: Bool) {
        if(isMap) {
            plantsView.isHidden = true
            mapView.isHidden = false
            mapView.setupGoogleMap()
        } else {
            plantsView.isHidden = false
            mapView.isHidden = true
        }
    }
}
