//
//  StatusNavigationView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 18/04/24.
//

import UIKit

class StatusNavigationView: UIView {
    
    var plantsView: PlantsView?
    
    var stations: [Station]? {
        didSet {
            allPlantsTopView.valueLabel.text = "\(self.stations?.count ?? 0)"
            if let stations = self.stations {
                var normalCount = 0
                var faultyCount = 0
                var offlineCount = 0
                for station in stations {
                    if let status = station.stationRealKpi?.real_health_state {
                        if(status == 3) {
                            normalCount = normalCount + 1
                        }
                        if(status == 2) {
                            faultyCount = faultyCount + 1
                        }
                        if(status == 1) {
                            offlineCount = offlineCount + 1
                        }
                    }
                }
                normalPlantsTopView.valueLabel.text = "\(normalCount ?? 0)"
                faultyPlantsTopView.valueLabel.text = "\(faultyCount ?? 0)"
                offlinePlantsTopView.valueLabel.text = "\(offlineCount ?? 0)"
            }
        }
    }
    
    var plantsTopView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.spacing = 5.dp
        view.axis = .horizontal
        view.alignment = .fill
        return view
    }()
    
    let allPlantsTopView: PlantsTopView = {
        let view = PlantsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelect = true
        view.titleLabel.text = NSLocalizedString("all", comment: "")
        view.valueLabel.text = "0"
        view.valueLabel.textColor = .rgb(0, green: 0, blue: 0)
        return view
    }()
    
    let normalPlantsTopView: PlantsTopView = {
        let view = PlantsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelect = false
        view.titleLabel.text = NSLocalizedString("normal", comment: "")
        view.valueLabel.text = "0"
        view.valueLabel.textColor = .rgb(84, green: 164, blue: 110)
        return view
    }()
    
    let faultyPlantsTopView: PlantsTopView = {
        let view = PlantsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelect = false
        view.titleLabel.text = NSLocalizedString("faulty", comment: "")
        view.valueLabel.text = "0"
        view.valueLabel.textColor = .rgb(224, green: 69, blue: 76)
        return view
    }()
    
    let offlinePlantsTopView: PlantsTopView = {
        let view = PlantsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelect = false
        view.titleLabel.text = NSLocalizedString("offline", comment: "")
        view.valueLabel.text = "0"
        view.valueLabel.textColor = .rgb(106, green: 106, blue: 106)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupView()
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(plantsTopView)
        self.addConstraintsWithFormat("H:|[v0]|", views: plantsTopView)
        self.addConstraintsWithFormat("V:|[v0]|", views: plantsTopView)
        
        allPlantsTopView.widthAnchor.constraint(equalToConstant: 86.dp).isActive = true
        normalPlantsTopView.widthAnchor.constraint(equalToConstant: 86.dp).isActive = true
        faultyPlantsTopView.widthAnchor.constraint(equalToConstant: 86.dp).isActive = true
        offlinePlantsTopView.widthAnchor.constraint(equalToConstant: 86.dp).isActive = true
        
        allPlantsTopView.heightAnchor.constraint(equalToConstant: 60.dp).isActive = true
        normalPlantsTopView.heightAnchor.constraint(equalToConstant: 60.dp).isActive = true
        faultyPlantsTopView.heightAnchor.constraint(equalToConstant: 60.dp).isActive = true
        offlinePlantsTopView.heightAnchor.constraint(equalToConstant: 60.dp).isActive = true
        
        plantsTopView.addArrangedSubview(allPlantsTopView)
        plantsTopView.addArrangedSubview(normalPlantsTopView)
        plantsTopView.addArrangedSubview(faultyPlantsTopView)
        plantsTopView.addArrangedSubview(offlinePlantsTopView)
        
        let allPlantsTopViewTap = UITapGestureRecognizer(target: self, action: #selector(self.allPlantsTopViewPress))
        allPlantsTopView.isUserInteractionEnabled = true
        allPlantsTopView.addGestureRecognizer(allPlantsTopViewTap)
        
        let normalPlantsTopViewTap = UITapGestureRecognizer(target: self, action: #selector(self.normalPlantsTopViewPress))
        normalPlantsTopView.isUserInteractionEnabled = true
        normalPlantsTopView.addGestureRecognizer(normalPlantsTopViewTap)
        
        let faultyPlantsTopViewTap = UITapGestureRecognizer(target: self, action: #selector(self.faultyPlantsTopViewPress))
        faultyPlantsTopView.isUserInteractionEnabled = true
        faultyPlantsTopView.addGestureRecognizer(faultyPlantsTopViewTap)
        
        let offlinePlantsTopViewTap = UITapGestureRecognizer(target: self, action: #selector(self.offlinePlantsTopViewPress))
        offlinePlantsTopView.isUserInteractionEnabled = true
        offlinePlantsTopView.addGestureRecognizer(offlinePlantsTopViewTap)
    }
    
    @objc func allPlantsTopViewPress() {
        self.disactiveAll()
        allPlantsTopView.isSelect = true
        self.plantsView?.status = "all"
    }
    
    @objc func normalPlantsTopViewPress() {
        self.disactiveAll()
        normalPlantsTopView.isSelect = true
        self.plantsView?.status = "normal"
    }
    
    @objc func faultyPlantsTopViewPress() {
        self.disactiveAll()
        faultyPlantsTopView.isSelect = true
        self.plantsView?.status = "faulty"
    }
    
    @objc func offlinePlantsTopViewPress() {
        self.disactiveAll()
        offlinePlantsTopView.isSelect = true
        self.plantsView?.status = "offline"
    }
    
    func disactiveAll() {
        allPlantsTopView.isSelect = false
        normalPlantsTopView.isSelect = false
        faultyPlantsTopView.isSelect = false
        offlinePlantsTopView.isSelect = false
    }
}
