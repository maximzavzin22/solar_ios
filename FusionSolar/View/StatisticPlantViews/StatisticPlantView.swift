//
//  StatisticPlantView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit
import Lottie

class StatisticPlantView: UIView {
    
    var homeController: HomeController?
    
    var height: CGFloat = 1
    
    var stations: [Station]? {
        didSet {
            self.getTopStations()
            self.totalStatisticsView.stations = self.stations
        }
    }
    
    var topStations: [Station]? {
        didSet {
            var count = topStations?.count ?? 0
            if(count > 5) {
                count = 5
            }
            height = 24.dp + CGFloat(count) * 62.dp + 21.dp + 16.dp + 24.dp
            plantsViewHeightConstraint?.constant = height
            self.setScrollViewHeight()
            self.layoutIfNeeded()
            self.plantsView.stations = topStations
        }
    }
    
    let topWhiteView: UIView = {
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
    
    lazy var totalStatisticsView: TotalStatisticsView = {
        let view = TotalStatisticsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.statisticPlantView = self
        return view
    }()
    
    //graphView
    let graphView: GraphView = {
        let view = GraphView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //
    
    //plantsView
    var plantsViewHeightConstraint: NSLayoutConstraint?
    let plantsView: StatisticsPlantsView = {
        let view = StatisticsPlantsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //
    
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
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(topWhiteView)
        self.addSubview(contentScrollView)
        
        contentScrollView.addSubview(totalStatisticsView)
        contentScrollView.addSubview(graphView)
        contentScrollView.addSubview(plantsView)
        contentScrollView.addSubview(environmentalView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topWhiteView)
        self.addConstraintsWithFormat("H:|[v0]|", views: contentScrollView)
        contentScrollView.addConstraintsWithFormat("H:|[v0]|", views: totalStatisticsView)
        contentScrollView.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: graphView)
        contentScrollView.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: plantsView)
        contentScrollView.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: environmentalView)
        
        self.addConstraintsWithFormat("V:|[v0(\(HomeController.topPadding))]", views: topWhiteView)
        contentScrollView.addConstraintsWithFormat("V:[v0(\(196.dp))]", views: totalStatisticsView)
        contentScrollView.addConstraintsWithFormat("V:[v0(\(434.dp))]", views: graphView)
        contentScrollView.addConstraintsWithFormat("V:[v0(\(218.dp))]", views: environmentalView)
        
        contentScrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        graphView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        plantsView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        environmentalView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        
        contentScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: HomeController.topPadding).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        totalStatisticsView.topAnchor.constraint(equalTo: contentScrollView.topAnchor).isActive = true
        graphView.topAnchor.constraint(equalTo: totalStatisticsView.bottomAnchor, constant: 16.dp).isActive = true
        plantsView.topAnchor.constraint(equalTo: graphView.bottomAnchor, constant: 16.dp).isActive = true
        environmentalView.topAnchor.constraint(equalTo: plantsView.bottomAnchor, constant: 16.dp).isActive = true
        
        height = 24.dp + 24.dp + 21.dp
        plantsViewHeightConstraint = plantsView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: self.height)[0]
        plantsViewHeightConstraint?.isActive = true
        
        self.setScrollViewHeight()
        
        self.graphView.homeStatisticsCellView = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    func setScrollViewHeight() {
        let contentScrollViewHeight = 196.dp + 16.dp + 434.dp + 16.dp + height + 16.dp + 218.dp + 16.dp
        self.contentScrollView.contentSize = CGSize(width: 390.dp, height: contentScrollViewHeight)
    }
    
    func getTopStations() {
        if let stations = self.stations {
            let newStations = stations.sorted(by: {($0.attitude ?? 0.0) > ($1.attitude ?? 0.0)})
            dump(newStations)
            if(stations.count > 5) {
                self.topStations = Array(newStations.prefix(5))
            } else {
                self.topStations = newStations
            }
        }
    }
}

class HomeStatisticsTopView: UIView {
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 20.dp)
        return label
    }()
    
    let parametrLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .boldSystemFont(ofSize: 18.dp)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .rgb(245, green: 244, blue: 244)
        self.layer.cornerRadius = 16.dp

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(valueLabel)
        self.addSubview(parametrLabel)
        self.addSubview(titleLabel)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(4.dp)-[v1]", views: valueLabel, parametrLabel)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: titleLabel)
        
        self.addConstraintsWithFormat("V:|-\(16.dp)-[v0]-\(4.dp)-[v1]", views: valueLabel, titleLabel)
        self.addConstraintsWithFormat("V:[v0]", views: parametrLabel)
        
        parametrLabel.bottomAnchor.constraint(equalTo: valueLabel.bottomAnchor).isActive = true
    }
}






 
