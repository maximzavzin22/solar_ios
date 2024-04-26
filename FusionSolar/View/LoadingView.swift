//
//  LoadingView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 20/07/23.
//

import UIKit
import Lottie

class LoadingView: UIView {
    
    let loadingBlackoutView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()
    
    let animationView: LottieAnimationView = {
        let view = LottieAnimationView.init(name: "loader")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.animationSpeed = 2.0
        view.loopMode = .loop
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(loadingBlackoutView)
        self.addConstraintsWithFormat("H:|[v0]|", views: loadingBlackoutView)
        self.addConstraintsWithFormat("V:|[v0]|", views: loadingBlackoutView)
        
        self.addSubview(animationView)
        self.addConstraintsWithFormat("H:[v0(\(175.dp))]", views: animationView)
        self.addConstraintsWithFormat("V:[v0(\(175.dp))]", views: animationView)
        animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        animationView.center = self.center
    }
    
    func startActivityIndicator() {
        animationView.play()
    }
    
    func stopActivityIndicator() {
        animationView.stop()
        self.isHidden = true
    }
    
    var blurEffectView: UIVisualEffectView?
    
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = self.bounds
        
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView!)
    }
    
}

