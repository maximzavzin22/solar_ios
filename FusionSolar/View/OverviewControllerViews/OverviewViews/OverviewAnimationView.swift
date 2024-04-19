//
//  OverviewAnimationView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 19/04/24.
//

import UIKit
import Lottie

class OverviewAnimationView: UIView {
    
    var real_health_state: Int? {
        didSet {
            if let value = real_health_state {
                if(real_health_state == 1) {
                    animationView.animation = LottieAnimation.named("3 shara off")
                    self.pvValueLabel.textColor = .white
                    self.pvIconImageView.image = UIImage(named: "ic_pv_white")
                }
                if(real_health_state == 2) {
                    animationView.animation = LottieAnimation.named("3 shara faulty")
                    self.pvValueLabel.textColor = .rgb(1, green: 6, blue: 10)
                    self.pvIconImageView.image = UIImage(named: "ic_pv")
                }
                if(real_health_state == 3) {
                    animationView.animation = LottieAnimation.named("3 shara")
                    self.pvValueLabel.textColor = .rgb(1, green: 6, blue: 10)
                    self.pvIconImageView.image = UIImage(named: "ic_pv")
                }
                animationView.play()
            }
        }
    }
    
    //animationView
    let animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.animationSpeed = 1.0
        view.loopMode = .loop
        return view
    }()
    
    let pvLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("pv", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let loadLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("load", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let gridLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("grid", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    //pvContentView
    let pvContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
       // view.backgroundColor = .green
        return view
    }()
    
    let pvIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_pv")
        return imageView
    }()
    
    let pvValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 12.dp)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    //
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(animationView)
        animationView.addSubview(pvLabel)
        self.addSubview(pvContentView)
        pvContentView.addSubview(pvIconImageView)
        pvContentView.addSubview(pvValueLabel)
        animationView.addSubview(loadLabel)
        animationView.addSubview(gridLabel)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: animationView)
        animationView.addConstraintsWithFormat("H:[v0]", views: pvLabel)
        self.addConstraintsWithFormat("H:[v0(\(70.dp))]", views: pvContentView)
        pvContentView.addConstraintsWithFormat("H:[v0(\(26.dp))]", views: pvIconImageView)
        pvContentView.addConstraintsWithFormat("H:|-\(6.dp)-[v0]-\(6.dp)-|", views: pvValueLabel)
        animationView.addConstraintsWithFormat("H:[v0]", views: loadLabel)
        animationView.addConstraintsWithFormat("H:[v0]", views: gridLabel)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: animationView)
        animationView.addConstraintsWithFormat("V:[v0]", views: pvLabel)
        self.addConstraintsWithFormat("V:[v0(\(70.dp))]", views: pvContentView)
        pvContentView.addConstraintsWithFormat("V:|-\(6.dp)-[v0(\(28.dp))]-\(6.dp)-[v1]", views: pvIconImageView, pvValueLabel)
        
        pvLabel.centerXAnchor.constraint(equalTo: animationView.centerXAnchor).isActive = true
        pvContentView.centerXAnchor.constraint(equalTo: animationView.centerXAnchor).isActive = true
        pvIconImageView.centerXAnchor.constraint(equalTo: pvContentView.centerXAnchor).isActive = true
        pvValueLabel.centerXAnchor.constraint(equalTo: pvContentView.centerXAnchor).isActive = true
        loadLabel.centerXAnchor.constraint(equalTo: animationView.leftAnchor, constant: 75.dp).isActive = true
        gridLabel.centerXAnchor.constraint(equalTo: animationView.rightAnchor, constant: -75.dp).isActive = true
        
        pvLabel.topAnchor.constraint(equalTo: animationView.topAnchor, constant: 15.dp).isActive = true
        pvContentView.topAnchor.constraint(equalTo: animationView.topAnchor, constant: 50.dp).isActive = true
        loadLabel.bottomAnchor.constraint(equalTo: animationView.bottomAnchor, constant: -15.dp).isActive = true
        gridLabel.bottomAnchor.constraint(equalTo: animationView.bottomAnchor, constant: -10.dp).isActive = true
    }
}

