//
//  StatusOverviewView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 19/04/24.
//

import UIKit

class StatusOverviewView: UIView {
    
    var overviewView: OverviewView?
    
    var status: Int? {
        didSet {
            if let value = status {
                if(value == 1) {
                    borderView.backgroundColor = .rgb(215, green: 228, blue: 237)
                    statusLabel.text = NSLocalizedString("offline", comment: "")
                    statusLabel.textColor = .rgb(106, green: 106, blue: 106)
                    fonStatusView.backgroundColor = .rgb(207, green: 219, blue: 231)
                    alarmLabel.textColor = .rgb(106, green: 106, blue: 106)
                }
                if(value == 2) {
                    borderView.backgroundColor = .rgb(228, green: 214, blue: 227)
                    statusLabel.text = NSLocalizedString("faulty", comment: "")
                    statusLabel.textColor = .rgb(224, green: 69, blue: 76)
                    fonStatusView.backgroundColor = .rgb(234, green: 195, blue: 214)
                    alarmLabel.textColor = .rgb(224, green: 69, blue: 76)
                }
                if(value == 3) {
                    borderView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                    statusLabel.text = NSLocalizedString("normal", comment: "")
                    statusLabel.textColor = .rgb(84, green: 164, blue: 110)
                    fonStatusView.backgroundColor = .rgb(215, green: 234, blue: 239)
                }
            }
        }
    }
    
    var alarm: Alarm? {
        didSet {
            self.alarmLabel.isHidden = false
            self.arrowImageView.isHidden = false
            self.alarmLabel.text = alarm?.alarmName ?? ""
        }
    }
    
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16.dp
        return view
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 12.dp)
        return label
    }()
    
    let fonStatusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4.dp
        return view
    }()
    
    let alarmLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 14.dp)
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "btn_arrow")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(borderView)
        borderView.addSubview(fonStatusView)
        borderView.addSubview(statusLabel)
        borderView.addSubview(alarmLabel)
        borderView.addSubview(arrowImageView)
        
        self.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: borderView)
        borderView.addConstraintsWithFormat("H:|-\(21.dp)-[v0]-\(20.dp)-[v1]-\(7.dp)-[v2(\(9.dp))]-\(12.dp)-|", views: statusLabel, alarmLabel, arrowImageView)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: borderView)
        borderView.addConstraintsWithFormat("V:[v0]", views: statusLabel)
        borderView.addConstraintsWithFormat("V:[v0]", views: alarmLabel)
        borderView.addConstraintsWithFormat("V:[v0(\(14.dp))]", views: arrowImageView)
        borderView.addConstraintsWithFormat("V:[v0(\(22.dp))]", views: fonStatusView)
        
        borderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fonStatusView.leftAnchor.constraint(equalTo: statusLabel.leftAnchor, constant: -8.dp).isActive = true
        fonStatusView.rightAnchor.constraint(equalTo: statusLabel.rightAnchor, constant: 8.dp).isActive = true
        
        statusLabel.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
        alarmLabel.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
        fonStatusView.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor).isActive = true
        
        alarmLabel.isHidden = true
        arrowImageView.isHidden = true
        
        let borderViewTap = UITapGestureRecognizer(target: self, action: #selector(self.borderViewPress))
        borderView.isUserInteractionEnabled = true
        borderView.addGestureRecognizer(borderViewTap)
    }
    
    @objc func borderViewPress() {
        if let alarm = self.alarm {
            self.overviewView?.overviewController?.openAlarmDetailController(alarm: alarm)
        }
    }
}
