//
//  EnvironmentalCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 18/04/24.
//

import UIKit
import Lottie

class EnvironmentalCellView: UIView {
    
    var animatioName: String? {
        didSet {
            if let name = animatioName {
                animationView.animation = LottieAnimation.named(name)
                animationView.play()
            }
        }
    }
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(0, green: 0, blue: 0)
        label.font = .boldSystemFont(ofSize: 18.dp)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 10.dp)
        label.numberOfLines = 0
        return label
    }()
    
    let animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.animationSpeed = 0.7
        view.loopMode = .loop
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.cornerRadius = 16.dp
        self.layer.masksToBounds = true

        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(animationView)
        self.addSubview(valueLabel)
        self.addSubview(titleLabel)
        
        self.addConstraintsWithFormat("H:|-\(12.dp)-[v0]", views: valueLabel)
        self.addConstraintsWithFormat("H:|-\(12.dp)-[v0]-\(12.dp)-|", views: titleLabel)
        self.addConstraintsWithFormat("H:|[v0(\(100.dp))]|", views: animationView)
        
        self.addConstraintsWithFormat("V:|-\(16.dp)-[v0]-\(6.dp)-[v1]", views: valueLabel, titleLabel)
        self.addConstraintsWithFormat("V:[v0(\(100.dp))]|", views: animationView)
        
        animationView.play()
    }
}
