//
//  WeatherView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 27/07/23.
//

import UIKit
 
class WeatherView: UIView {
    
    var weather: Weather? {
        didSet {
            if let status = weather?.status {
                if(status != 0) {
                    if(status == 1) {
                        iconImageView.image = UIImage(named: "sun")
                    }
                    noDataLabel.isHidden = true
                    iconImageView.isHidden = false
                    valueLabel.isHidden = false
                    valueLabel.text = "\(weather?.startTemp ?? 0)°C ~ \(weather?.endTemp ?? 0)°C"
                }
            }
        }
    }
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let noDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = "\(NSLocalizedString("weather", comment: "")) --"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(iconImageView)
        self.addSubview(valueLabel)
        self.addSubview(noDataLabel)
        
        self.addConstraintsWithFormat("H:|[v0(\(24.dp))]-\(9.dp)-[v1]", views: iconImageView, valueLabel)
        self.addConstraintsWithFormat("H:|[v0]", views: noDataLabel)
        
        self.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: iconImageView)
        self.addConstraintsWithFormat("V:[v0]", views: valueLabel)
        self.addConstraintsWithFormat("V:[v0]", views: noDataLabel)
        
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        noDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        iconImageView.isHidden = true
        valueLabel.isHidden = false
    }
}
