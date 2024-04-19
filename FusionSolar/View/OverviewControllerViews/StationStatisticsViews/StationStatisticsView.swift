//
//  StationStatisticsView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 27/07/23.
//

import UIKit

class StationStatisticsView: UIView {
    
    var overviewController: OverviewController?
    
    let whiteTopView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var stationChartsView: StationChartsView = {
        let view = StationChartsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.stationStatisticsView = self
        return view
    }()
    
    let environmentalView: EnvironmentalView = {
        let view = EnvironmentalView()
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
        print("setupView")
        let window = UIApplication.shared.keyWindow
        var topSafeArea = window?.safeAreaInsets.top ?? 0

        self.addSubview(whiteTopView)
        self.addSubview(contentScrollView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: whiteTopView)
        self.addConstraintsWithFormat("H:|[v0]|", views: contentScrollView)
        
        self.addConstraintsWithFormat("V:|[v0(\(70.dp + topSafeArea))][v1]|", views: whiteTopView, contentScrollView)
        
        contentScrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.setupContentScrollView()
        self.layoutIfNeeded()
    }
    
    func setupContentScrollView() {
        let contentScrollViewHeight = 16.dp + 900.dp + 16.dp + 218.dp + 16.dp
        self.contentScrollView.contentSize = CGSize(width: 390.dp, height: contentScrollViewHeight)
        
        contentScrollView.addSubview(stationChartsView)
        contentScrollView.addSubview(environmentalView)
        
        let screenWidth = UIScreen.main.bounds.width
        
        contentScrollView.addConstraintsWithFormat("H:[v0(\(screenWidth-30))]", views: stationChartsView)
        contentScrollView.addConstraintsWithFormat("H:[v0(\(screenWidth-30))]", views: environmentalView)
        
        contentScrollView.addConstraintsWithFormat("V:[v0(\(900.dp))]", views: stationChartsView)
        contentScrollView.addConstraintsWithFormat("V:[v0(\(218.dp))]", views: environmentalView)
        
        stationChartsView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        environmentalView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        
        stationChartsView.topAnchor.constraint(equalTo: contentScrollView.topAnchor, constant: 16.dp).isActive = true
        environmentalView.topAnchor.constraint(equalTo: stationChartsView.bottomAnchor, constant: 16.dp).isActive = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}




