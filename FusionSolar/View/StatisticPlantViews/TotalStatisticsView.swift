//
//  TotalStatisticsView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 18/04/24.
//

import UIKit

class TotalStatisticsView: UIView {
    
    var statisticPlantView: StatisticPlantView?
    
    var stations: [Station]? {
        didSet {
            var totalCapacity: Double = 0.0
            var totalDayPower: Double = 0.0
            var totalYearPower: Double = 0.0
            var totalRevenue: Double = 0.0
            if let stations = self.stations {
                for station in stations {
                    totalCapacity = totalCapacity + (station.capacity ?? 0.0)
                    totalDayPower = totalDayPower + (station.stationRealKpi?.day_power ?? 0.0)
                    totalYearPower = totalYearPower + (station.stationRealKpi?.total_power ?? 0.0)
                    totalRevenue = totalRevenue + (station.stationRealKpi?.day_income ?? 0.0)
                }
            }
            
            if(totalCapacity < 1000.0) {
                powerHomeStatisticsTopView.valueLabel.text = "\(totalCapacity.rounded(toPlaces: 2))"
                powerHomeStatisticsTopView.parametrLabel.text = NSLocalizedString("kw", comment: "")
            } else {
                if(totalCapacity < 1000000.0) {
                    powerHomeStatisticsTopView.valueLabel.text = "\((totalCapacity/1000.0).rounded(toPlaces: 2))"
                    powerHomeStatisticsTopView.parametrLabel.text = NSLocalizedString("mw", comment: "")
                } else {
                    powerHomeStatisticsTopView.valueLabel.text = "\((totalCapacity/1000000.0).rounded(toPlaces: 2))"
                    powerHomeStatisticsTopView.parametrLabel.text = NSLocalizedString("gw", comment: "")
                }
            }
            if(totalDayPower < 1000.0) {
                todayHomeStatisticsTopView.valueLabel.text = "\(totalDayPower.rounded(toPlaces: 2))"
                todayHomeStatisticsTopView.parametrLabel.text = NSLocalizedString("kwh", comment: "")
            } else {
                if(totalDayPower < 1000000.0) {
                    todayHomeStatisticsTopView.valueLabel.text = "\((totalDayPower/1000.0).rounded(toPlaces: 2))"
                    todayHomeStatisticsTopView.parametrLabel.text = NSLocalizedString("mwh", comment: "")
                } else {
                    todayHomeStatisticsTopView.valueLabel.text = "\((totalDayPower/1000000.0).rounded(toPlaces: 2))"
                    todayHomeStatisticsTopView.parametrLabel.text = NSLocalizedString("gwh", comment: "")
                }
            }
            if(totalYearPower < 1000.0) {
                totalHomeStatisticsTopView.valueLabel.text = "\(totalYearPower.rounded(toPlaces: 2))"
                totalHomeStatisticsTopView.parametrLabel.text = NSLocalizedString("kwh", comment: "")
            } else {
                if(totalYearPower < 1000000.0) {
                    totalHomeStatisticsTopView.valueLabel.text = "\((totalYearPower/1000.0).rounded(toPlaces: 2))"
                    totalHomeStatisticsTopView.parametrLabel.text = NSLocalizedString("mwh", comment: "")
                } else {
                    totalHomeStatisticsTopView.valueLabel.text = "\((totalYearPower/1000000.0).rounded(toPlaces: 2))"
                    totalHomeStatisticsTopView.parametrLabel.text = NSLocalizedString("gwh", comment: "")
                }
            }
            if(totalRevenue > 1000.0) {
                self.revenueHomeStatisticsTopView.valueLabel.text = "\((totalRevenue/1000.0).rounded(toPlaces: 2))k"
            } else {
                self.revenueHomeStatisticsTopView.valueLabel.text = "\(totalRevenue.rounded(toPlaces: 2))"
            }
        }
    }
    
    let topContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let powerHomeStatisticsTopView: HomeStatisticsTopView = {
        let view = HomeStatisticsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("current_power", comment: "")
        view.valueLabel.text = "0.00"
        view.parametrLabel.text = NSLocalizedString("kw", comment: "")
        return view
    }()
    
    let revenueHomeStatisticsTopView: HomeStatisticsTopView = {
        let view = HomeStatisticsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("revenue_today", comment: "")
        view.valueLabel.text = "0.00"
        view.parametrLabel.text = "$"
        return view
    }()
    
    let todayHomeStatisticsTopView: HomeStatisticsTopView = {
        let view = HomeStatisticsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("yield_today", comment: "")
        view.valueLabel.text = "0.00"
        view.parametrLabel.text = NSLocalizedString("kwh", comment: "")
        return view
    }()
    
    let totalHomeStatisticsTopView: HomeStatisticsTopView = {
        let view = HomeStatisticsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("total_yield", comment: "")
        view.valueLabel.text = "0.00"
        view.parametrLabel.text = NSLocalizedString("mwh", comment: "")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(topContentView)
        topContentView.addSubview(powerHomeStatisticsTopView)
        topContentView.addSubview(revenueHomeStatisticsTopView)
        topContentView.addSubview(todayHomeStatisticsTopView)
        topContentView.addSubview(totalHomeStatisticsTopView)
        
        self.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: topContentView)
        
        self.addConstraintsWithFormat("V:|-\(24.dp)-[v0(\(156.dp))]", views: topContentView)
        topContentView.addConstraintsWithFormat("V:|[v0(\(73.dp))]-\(10.dp)-[v1(\(73.dp))]", views: powerHomeStatisticsTopView, revenueHomeStatisticsTopView)
        topContentView.addConstraintsWithFormat("V:|[v0(\(73.dp))]-\(10.dp)-[v1(\(73.dp))]", views: todayHomeStatisticsTopView, totalHomeStatisticsTopView)
        
        topContentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        powerHomeStatisticsTopView.leftAnchor.constraint(equalTo: topContentView.leftAnchor).isActive = true
        powerHomeStatisticsTopView.rightAnchor.constraint(equalTo: topContentView.centerXAnchor, constant: -5.dp).isActive = true
        revenueHomeStatisticsTopView.leftAnchor.constraint(equalTo: topContentView.leftAnchor).isActive = true
        revenueHomeStatisticsTopView.rightAnchor.constraint(equalTo: topContentView.centerXAnchor, constant: -5.dp).isActive = true
        todayHomeStatisticsTopView.leftAnchor.constraint(equalTo: topContentView.centerXAnchor, constant: 5.dp).isActive = true
        todayHomeStatisticsTopView.rightAnchor.constraint(equalTo: topContentView.rightAnchor).isActive = true
        totalHomeStatisticsTopView.leftAnchor.constraint(equalTo: topContentView.centerXAnchor, constant: 5.dp).isActive = true
        totalHomeStatisticsTopView.rightAnchor.constraint(equalTo: topContentView.rightAnchor).isActive = true
    }
}
