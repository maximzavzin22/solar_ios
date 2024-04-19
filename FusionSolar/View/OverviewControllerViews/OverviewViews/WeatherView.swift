//
//  WeatherView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 27/07/23.
//

import UIKit
import Lottie
 
class WeatherView: UIView {
    
    var weather: Weather? {
        didSet {
            if let status = weather?.status {
                if(status != 0) {
                    if(status == 1) {
                       // iconImageView.image = UIImage(named: "sun")
                        
                    }
                    noDataLabel.isHidden = true
                   // iconImageView.isHidden = false
                    animationView.isHidden = false
                    animationView.play()
                    valueLabel.isHidden = false
                    valueLabel.text = "\(weather?.startTemp ?? 0)°C ~ \(weather?.endTemp ?? 0)°C"
                }
            }
        }
    }
    
    let animationView: LottieAnimationView = {
        let view = LottieAnimationView.init(name: "sun")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        return view
    }()
    
//    let iconImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
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
       // self.addSubview(iconImageView)
        self.addSubview(animationView)
        self.addSubview(valueLabel)
        self.addSubview(noDataLabel)
        
        self.addConstraintsWithFormat("H:|[v0(\(35.dp))]", views: animationView)
        self.addConstraintsWithFormat("H:|-\(31.dp)-[v0]", views: valueLabel)
      //  self.addConstraintsWithFormat("H:|[v0(\(24.dp))]-\(9.dp)-[v1]", views: iconImageView, valueLabel)
        self.addConstraintsWithFormat("H:|[v0]", views: noDataLabel)
        
        self.addConstraintsWithFormat("V:[v0(\(35.dp))]", views: animationView)
       // self.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: iconImageView)
        self.addConstraintsWithFormat("V:[v0]", views: valueLabel)
        self.addConstraintsWithFormat("V:[v0]", views: noDataLabel)
        
        animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      //  iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        noDataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
     //   iconImageView.isHidden = true
        animationView.isHidden = true
        valueLabel.isHidden = false
    }
}
