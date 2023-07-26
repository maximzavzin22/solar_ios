//
//  DeviceInverterCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 26/07/23.
//

import UIKit

class DeviceInverterCellView: UICollectionViewCell {
    
    var device: Device? {
        didSet {
            self.nameLabel.text = device?.devName ?? ""
            self.plantValueLabel.text = device?.stationCode ?? ""
            self.snValueLabel.text = device?.esnCode ?? ""
            self.typeValueLabel.text = NSLocalizedString("inverter", comment: "")
        }
    }
    
    var status: String? {
        didSet {
            if let value = status {
                if(value == "running") {
                    self.statusLabel.text = NSLocalizedString("running", comment: "")
                    self.statusLabel.textColor = .rgb(101, green: 161, blue: 149)
                    self.statusBorderView.backgroundColor = .rgb(229, green: 250, blue: 245)
                }
                if(value == "offline") {
                    self.statusLabel.text = NSLocalizedString("offline", comment: "")
                    self.statusLabel.textColor = .rgb(106, green: 106, blue: 106)
                    self.statusBorderView.backgroundColor = .rgb(242, green: 242, blue: 242)
                }
            }
        }
    }
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16.dp
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 16.dp)
        label.numberOfLines = 1
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12.dp)
        return label
    }()
    
    let statusBorderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5.dp
        return view
    }()
    
    //textsContentView
    let textsContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let plantTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("plant_name", comment: "")
        return label
    }()
    
    let plantValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let snTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("sn", comment: "")
        return label
    }()
    
    let snValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let typeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("device_type", comment: "")
        return label
    }()
    
    let typeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let statusTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("inverter_status", comment: "")
        return label
    }()
    
    let statusValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let powerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("active_power", comment: "")
        return label
    }()
    
    let powerValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "--\(NSLocalizedString("kw", comment: ""))"
        return label
    }()
    
    let yieldTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("yield_today", comment: "")
        return label
    }()
    
    let yieldValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "--\(NSLocalizedString("kwh", comment: ""))"
        return label
    }()
    
    let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("warranty_expiration_date", comment: "")
        return label
    }()
    
    let dateValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-/-/-"
        return label
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupTextsContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(borderView)
        borderView.addSubview(nameLabel)
        borderView.addSubview(statusBorderView)
        borderView.addSubview(statusLabel)
        borderView.addSubview(textsContentView)
        
        self.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: borderView)
        borderView.addConstraintsWithFormat("H:|-\(20.dp)-[v0(\(262.dp))]", views: nameLabel)
        borderView.addConstraintsWithFormat("H:[v0]-\(26.dp)-|", views: statusLabel)
        borderView.addConstraintsWithFormat("H:[v0(\(320.dp))]", views: textsContentView)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: borderView)
        borderView.addConstraintsWithFormat("V:|-\(24.dp)-[v0]-\(24.dp)-[v1(\(180.dp))]", views: nameLabel, textsContentView)
        borderView.addConstraintsWithFormat("V:[v0]", views: statusLabel)
        borderView.addConstraintsWithFormat("V:[v0(\(22.dp))]", views: statusBorderView)
        
        borderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textsContentView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        statusBorderView.leftAnchor.constraint(equalTo: statusLabel.leftAnchor, constant: -6.dp).isActive = true
        statusBorderView.rightAnchor.constraint(equalTo: statusLabel.rightAnchor, constant: 6.dp).isActive = true
        
        statusLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        statusBorderView.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor).isActive = true
    }
    
    func setupTextsContentView() {
        textsContentView.addSubview(plantTitleLabel)
        textsContentView.addSubview(plantValueLabel)
        textsContentView.addSubview(snTitleLabel)
        textsContentView.addSubview(snValueLabel)
        textsContentView.addSubview(typeTitleLabel)
        textsContentView.addSubview(typeValueLabel)
        textsContentView.addSubview(statusTitleLabel)
        textsContentView.addSubview(statusValueLabel)
        textsContentView.addSubview(powerTitleLabel)
        textsContentView.addSubview(powerValueLabel)
        textsContentView.addSubview(yieldTitleLabel)
        textsContentView.addSubview(yieldValueLabel)
        textsContentView.addSubview(dateTitleLabel)
        textsContentView.addSubview(dateValueLabel)
        
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: plantTitleLabel, plantValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: snTitleLabel, snValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: typeTitleLabel, typeValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: statusTitleLabel, statusValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: powerTitleLabel, powerValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: yieldTitleLabel, yieldValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: dateTitleLabel, dateValueLabel)
        
        textsContentView.addConstraintsWithFormat("V:|[v0]-\(8.dp)-[v1]-\(8.dp)-[v2]-\(8.dp)-[v3]-\(8.dp)-[v4]-\(8.dp)-[v5]-\(8.dp)-[v6]", views: plantTitleLabel, snTitleLabel, typeTitleLabel, statusTitleLabel, powerTitleLabel, yieldTitleLabel, dateTitleLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: plantValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: snValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: typeValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: statusValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: powerValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: yieldValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: dateValueLabel)
        
        plantValueLabel.topAnchor.constraint(equalTo: plantTitleLabel.topAnchor).isActive = true
        snValueLabel.topAnchor.constraint(equalTo: snTitleLabel.topAnchor).isActive = true
        typeValueLabel.topAnchor.constraint(equalTo: typeTitleLabel.topAnchor).isActive = true
        statusValueLabel.topAnchor.constraint(equalTo: statusTitleLabel.topAnchor).isActive = true
        powerValueLabel.topAnchor.constraint(equalTo: powerTitleLabel.topAnchor).isActive = true
        yieldValueLabel.topAnchor.constraint(equalTo: yieldTitleLabel.topAnchor).isActive = true
        dateValueLabel.topAnchor.constraint(equalTo: dateTitleLabel.topAnchor).isActive = true
    }
    
}
