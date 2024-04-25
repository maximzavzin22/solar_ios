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
    
    var totalRevenue: Double? { //не правильно, подумать как считать и где брать//в идеале брать только при первом запросе за сегодня
        didSet {
            let value = totalRevenue ?? 0.0
            if(value > 1000.0) {
                self.totalStatisticsView.revenueHomeStatisticsTopView.valueLabel.text = "\((value/1000.0).rounded(toPlaces: 2))k"
            } else {
                self.totalStatisticsView.revenueHomeStatisticsTopView.valueLabel.text = "\(value.rounded(toPlaces: 2))"
            }
        }
    }
    
    var detailRealKpis: [DetailRealKpi]? {
        didSet {
//            dump(detailRealKpis)
            var reductionTotalCo2: Double = 0.0
            var reductionTotalCoal: Double = 0.0
            var reductionTotalTree: Double = 0.0
            
            var graphValues = [GraphValue]()
            var koefficient = 1.0
            let maxDetailRealKpi = detailRealKpis?.max {($0.inverter_power ?? 0.0) < ($1.inverter_power ?? 0.0)}
            if let inverter_power = maxDetailRealKpi?.inverter_power {
                print("Max inverter_power \(inverter_power)")
                if(inverter_power < 1000.0) {
                    koefficient = 1.0
                    self.graphView.parametrLabel.text = NSLocalizedString("kwh", comment: "")
                } else {
                    if(inverter_power < 1000000.0) {
                        koefficient = 1000.0
                        self.graphView.parametrLabel.text = NSLocalizedString("mwh", comment: "")
                    } else {
                        koefficient = 1000000.0
                        self.graphView.parametrLabel.text = NSLocalizedString("gwh", comment: "")
                    }
                }
            }
            
            for detailRealKpi in detailRealKpis ?? [] {
                if let collectTime = detailRealKpi.collectTime {
                    detailRealKpi.date = Date(milliseconds: collectTime)
                    var graphValue = GraphValue()
                    let formatter = DateFormatter()
                    let selectedDateType = graphView.selectedDateType ?? "day"
                    if(selectedDateType == "day") {
                        formatter.dateFormat = "HH"
                    }
                    if(selectedDateType == "month") {
                        formatter.dateFormat = "dd"
                    }
                    if(selectedDateType == "year") {
                        formatter.dateFormat = "MM"
                    }
                    if(selectedDateType == "lifetime") {
                        formatter.dateFormat = "yyyy"
                    }
                    if let date = detailRealKpi.date {
                        let dateString = formatter.string(from: date)
                        graphValue.key = dateString
                        print("\(dateString) \(detailRealKpi.power_profit ?? 0.0) \(detailRealKpi.inverter_power ?? 0.0)")
                    }
                    graphValue.powerProfit = detailRealKpi.power_profit ?? 0.0
                    graphValue.inverterPower = (detailRealKpi.inverter_power ?? 0.0) / koefficient
                    
                    reductionTotalCo2 = reductionTotalCo2 + (detailRealKpi.reduction_total_co2 ?? 0.0)
                    reductionTotalCoal = reductionTotalCoal + (detailRealKpi.reduction_total_coal ?? 0.0)
                    reductionTotalTree = reductionTotalTree + (detailRealKpi.reduction_total_tree ?? 0.0)
                    
                    graphValues.append(graphValue)
                }
            }
            
            if(totalRevenue ?? 0.0 == 0.0) {
                for graphValue in graphValues ?? [] {
                    totalRevenue = (totalRevenue ?? 0.0) + (graphValue.powerProfit ?? 0.0)
                }
            }
            
            print("reductionTotalCo2 \(reductionTotalCo2.rounded(toPlaces: 2))  reductionTotalCoal \(reductionTotalCoal.rounded(toPlaces: 2)) reductionTotalTree \(reductionTotalTree.rounded(toPlaces: 2))")
            
            self.graphView.setupBarChartView(graphValues: graphValues)
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
            if(stations.count > 5) {
                self.topStations = Array(newStations.prefix(5))
            } else {
                self.topStations = newStations
            }
        }
    }
    
    func getDataForGraph() {
        let value = self.graphView.selectedDateType ?? "day"
        let date = self.graphView.selectedDate ?? Date()
        let collectTime = date.millisecondsSince1970
        print("getDataForGraph \(date) \(collectTime)")
        if(value == "day") {
            self.homeController?.fetchReportKpi(collectTime: collectTime, road: "kpi-hour")
        }
        if(value == "month") {
            self.homeController?.fetchReportKpi(collectTime: collectTime, road: "kpi-daily")
        }
        if(value == "year") {
            self.homeController?.fetchReportKpi(collectTime: collectTime, road: "kpi-monthly")
        }
        if(value == "lifetime") {
            self.homeController?.fetchReportKpi(collectTime: collectTime, road: "kpi-yearly")
        }
    }
}








 
