//
//  EmptyDataView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit
import Lottie

class EmptyDataView: UIView {
    
//    let iconImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(named: "empty")
//        return imageView
//    }()
    
    let animationView: LottieAnimationView = {
        let view = LottieAnimationView.init(name: "empty")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.animationSpeed = 2.0
        view.loopMode = .loop
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("no_data", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 18.dp)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(animationView)
        self.addSubview(titleLabel)
        
        self.addConstraintsWithFormat("H:[v0(\(132.dp))]", views: animationView)
        self.addConstraintsWithFormat("H:[v0]", views: titleLabel)
        
        self.addConstraintsWithFormat("V:[v0(\(132.dp))]-\(2.dp)-[v1]", views: animationView, titleLabel)
        
        animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        animationView.animationSpeed = 0.3
        animationView.play()
    }
}
