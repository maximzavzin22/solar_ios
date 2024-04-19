//
//  PlantMapInfoContentView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 19/04/24.
//

import UIKit

class PlantMapInfoContentView: UIView {
    
    var station: Station? {
        didSet {
            self.powerValueLabel.text = HomeController.amountEnergyConvert(value: station?.capacity)
            self.yieldValueLabel.text = HomeController.powerConvert(value: station?.stationRealKpi?.day_power)
            self.capacityValueLabel.text = HomeController.powerConvert(value: station?.stationRealKpi?.total_power)
            self.addressValueLabel.text = station?.plantAddress ?? ""
        }
    }
    
    //powerView
    let powerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let powerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = NSLocalizedString("map_info_current_power", comment: "")
        return label
    }()
    
    let powerValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = "0.00 \(NSLocalizedString("kw", comment: ""))"
        return label
    }()
    
    let powerSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(223, green: 223, blue: 223)
        return view
    }()
    //
    
    //yieldView
    let yieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let yieldTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = NSLocalizedString("map_info_yield_today", comment: "")
        return label
    }()
    
    let yieldValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = "0.00 \(NSLocalizedString("kwh", comment: ""))"
        return label
    }()
    
    let yieldSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(223, green: 223, blue: 223)
        return view
    }()
    //
    
    //capacityView
    let capacityView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let capacityTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        label.numberOfLines = 2
        label.text = NSLocalizedString("total_yield", comment: "")
        return label
    }()
    
    let capacityValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = "0.00 \(NSLocalizedString("kwp", comment: ""))"
        return label
    }()
    
    let capacitySeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(223, green: 223, blue: 223)
        return view
    }()
    //
    
    //addressView
    let addressView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addressTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = NSLocalizedString("map_info_plant_address", comment: "")
        return label
    }()
    
    let addressValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        label.numberOfLines = 2
        return label
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupPowerView()
        self.setupYieldView()
        self.setupCapacityView()
        self.setupAddressView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(powerView)
        self.addSubview(yieldView)
        self.addSubview(capacityView)
        self.addSubview(addressView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: powerView)
        self.addConstraintsWithFormat("H:|[v0]|", views: yieldView)
        self.addConstraintsWithFormat("H:|[v0]|", views: capacityView)
        self.addConstraintsWithFormat("H:|[v0]|", views: addressView)
        
        self.addConstraintsWithFormat("V:|[v0(\(49.dp))][v1(\(49.dp))][v2(\(49.dp))][v3(\(49.dp))]", views: powerView, yieldView, capacityView, addressView)
    }
    
    func setupPowerView() {
        powerView.addSubview(powerTitleLabel)
        powerView.addSubview(powerValueLabel)
        powerView.addSubview(powerSeperateView)
        
        powerView.addConstraintsWithFormat("H:|-\(24.dp)-[v0(\(150.dp))]-\(8.dp)-[v1]-\(24.dp)-|", views: powerTitleLabel, powerValueLabel)
        powerView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: powerSeperateView)
        
        powerView.addConstraintsWithFormat("V:[v0]", views: powerTitleLabel)
        powerView.addConstraintsWithFormat("V:[v0]", views: powerValueLabel)
        powerView.addConstraintsWithFormat("V:[v0(\(1.dp))]|", views: powerSeperateView)
        
        powerTitleLabel.centerYAnchor.constraint(equalTo: powerView.centerYAnchor).isActive = true
        powerValueLabel.centerYAnchor.constraint(equalTo: powerView.centerYAnchor).isActive = true
    }
    
    func setupYieldView() {
        yieldView.addSubview(yieldTitleLabel)
        yieldView.addSubview(yieldValueLabel)
        yieldView.addSubview(yieldSeperateView)

        yieldView.addConstraintsWithFormat("H:|-\(24.dp)-[v0(\(150.dp))]-\(8.dp)-[v1]-\(24.dp)-|", views: yieldTitleLabel, yieldValueLabel)
        yieldView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: yieldSeperateView)
        
        yieldView.addConstraintsWithFormat("V:[v0]", views: yieldTitleLabel)
        yieldView.addConstraintsWithFormat("V:[v0]", views: yieldValueLabel)
        yieldView.addConstraintsWithFormat("V:[v0(\(1.dp))]|", views: yieldSeperateView)
        
        yieldTitleLabel.centerYAnchor.constraint(equalTo: yieldView.centerYAnchor).isActive = true
        yieldValueLabel.centerYAnchor.constraint(equalTo: yieldView.centerYAnchor).isActive = true
    }

    func setupCapacityView() {
        capacityView.addSubview(capacityTitleLabel)
        capacityView.addSubview(capacityValueLabel)
        capacityView.addSubview(capacitySeperateView)

        capacityView.addConstraintsWithFormat("H:|-\(24.dp)-[v0(\(150.dp))]-\(8.dp)-[v1]-\(24.dp)-|", views: capacityTitleLabel, capacityValueLabel)
        capacityView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: capacitySeperateView)
        
        capacityView.addConstraintsWithFormat("V:[v0]", views: capacityTitleLabel)
        capacityView.addConstraintsWithFormat("V:[v0]", views: capacityValueLabel)
        capacityView.addConstraintsWithFormat("V:[v0(\(1.dp))]|", views: capacitySeperateView)
        
        capacityTitleLabel.centerYAnchor.constraint(equalTo: capacityView.centerYAnchor).isActive = true
        capacityValueLabel.centerYAnchor.constraint(equalTo: capacityView.centerYAnchor).isActive = true
    }

    func setupAddressView() {
        addressView.addSubview(addressTitleLabel)
        addressView.addSubview(addressValueLabel)

        addressView.addConstraintsWithFormat("H:|-\(24.dp)-[v0(\(150.dp))]-\(8.dp)-[v1]-\(24.dp)-|", views: addressTitleLabel, addressValueLabel)
        
        capacityView.addConstraintsWithFormat("V:[v0]", views: addressTitleLabel)
        capacityView.addConstraintsWithFormat("V:[v0]", views: addressValueLabel)
        
        addressTitleLabel.centerYAnchor.constraint(equalTo: addressView.centerYAnchor).isActive = true
        addressValueLabel.centerYAnchor.constraint(equalTo: addressView.centerYAnchor).isActive = true
    }
}
