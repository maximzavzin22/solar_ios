//
//  AlarmCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit
import Lottie

class AlarmCellView: UICollectionViewCell {
    
    var alarm: Alarm? {
        didSet {
            if let lev = alarm?.lev {
                if(lev == 1) {
                    animationView.animation = LottieAnimation.named("alarm pink")
                }
                if(lev == 2) {
                    animationView.animation = LottieAnimation.named("alarm orange")
                }
                if(lev == 3) {
                    animationView.animation = LottieAnimation.named("alarm yellow")
                }
                if(lev == 4) {
                    animationView.animation = LottieAnimation.named("alarm warning")
                }
                animationView.play()
            }
            nameLabel.text = alarm?.alarmName ?? ""
            deviceValueLabel.text = alarm?.devName ?? ""
            plantValueLabel.text = alarm?.stationName ?? ""
            if let milliseconds = alarm?.raiseTime {
                let date = Date(milliseconds: milliseconds)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                dateValueLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16.dp
        return view
    }()
    
    let animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.animationSpeed = 0.7
        view.loopMode = .loop
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 16.dp)
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(59, green: 103, blue: 138)
        label.font = .systemFont(ofSize: 12.dp)
        label.text = NSLocalizedString("unacked", comment: "")
        return label
    }()
    
    let statusBorderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5.dp
        view.backgroundColor = .rgb(239, green: 247, blue: 255)
        return view
    }()
    
    //textsContentView
    let textsContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let defectTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("defect_elimination_status", comment: "")
        return label
    }()
    
    let defectValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let deviceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("device_name", comment: "")
        return label
    }()
    
    let deviceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let plantTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("plant_name", comment: "")
        return label
    }()
    
    let plantValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("occurrence_time", comment: "")
        return label
    }()
    
    let dateValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .rgb(241, green: 243, blue: 245)

        self.setupView()
        self.setupTextsContentView()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(borderView)
        borderView.addSubview(animationView)
        borderView.addSubview(nameLabel)
        borderView.addSubview(statusBorderView)
        borderView.addSubview(statusLabel)
        borderView.addSubview(textsContentView)
        
        self.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: borderView)
        borderView.addConstraintsWithFormat("H:|-\(20.dp)-[v0(\(24.dp))]-\(10.dp)-[v1]-\(100.dp)-|", views: animationView, nameLabel)
        borderView.addConstraintsWithFormat("H:[v0]-\(26.dp)-|", views: statusLabel)
        borderView.addConstraintsWithFormat("H:[v0(\(320.dp))]", views: textsContentView)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: borderView)
        borderView.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: animationView)
        borderView.addConstraintsWithFormat("V:|-\(24.dp)-[v0]", views: nameLabel)
        borderView.addConstraintsWithFormat("V:[v0(\(22.dp))]", views: statusBorderView)
        borderView.addConstraintsWithFormat("V:[v0]", views: statusLabel)
        borderView.addConstraintsWithFormat("V:|-\(79.dp)-[v0(\(120.dp))]", views: textsContentView)
        
        borderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textsContentView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        statusBorderView.leftAnchor.constraint(equalTo: statusLabel.leftAnchor, constant: -6.dp).isActive = true
        statusBorderView.rightAnchor.constraint(equalTo: statusLabel.rightAnchor, constant: 6.dp).isActive = true
        
        animationView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        statusLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        statusBorderView.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor).isActive = true
    }
    
    func setupTextsContentView() {
        textsContentView.addSubview(defectTitleLabel)
        textsContentView.addSubview(defectValueLabel)
        textsContentView.addSubview(deviceTitleLabel)
        textsContentView.addSubview(deviceValueLabel)
        textsContentView.addSubview(plantTitleLabel)
        textsContentView.addSubview(plantValueLabel)
        textsContentView.addSubview(dateTitleLabel)
        textsContentView.addSubview(dateValueLabel)
        
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: defectTitleLabel, defectValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: deviceTitleLabel, deviceValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: plantTitleLabel, plantValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: dateTitleLabel, dateValueLabel)
        
        textsContentView.addConstraintsWithFormat("V:|[v0]-\(8.dp)-[v1]-\(8.dp)-[v2]-\(8.dp)-[v3]", views: defectTitleLabel, deviceTitleLabel, plantValueLabel, dateTitleLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: defectValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: deviceValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: plantValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: dateValueLabel)
        
        defectValueLabel.topAnchor.constraint(equalTo: defectTitleLabel.topAnchor).isActive = true
        deviceValueLabel.topAnchor.constraint(equalTo: deviceTitleLabel.topAnchor).isActive = true
        plantTitleLabel.topAnchor.constraint(equalTo: plantValueLabel.topAnchor).isActive = true
        dateValueLabel.topAnchor.constraint(equalTo: dateTitleLabel.topAnchor).isActive = true
    }
}
