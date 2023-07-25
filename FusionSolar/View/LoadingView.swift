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
    
//    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(loadingBlackoutView)
       // self.addBlurEffect()
        self.addConstraintsWithFormat("H:|[v0]|", views: loadingBlackoutView)
        self.addConstraintsWithFormat("V:|[v0]|", views: loadingBlackoutView)
        
//        self.addSubview(activityIndicator)
//        self.addConstraintsWithFormat("H:[v0]", views: activityIndicator)
//        self.addConstraintsWithFormat("V:[v0]", views: activityIndicator)
//        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        activityIndicator.center = self.center
        
        self.addSubview(animationView)
        self.addConstraintsWithFormat("H:[v0(\(175.dp))]", views: animationView)
        self.addConstraintsWithFormat("V:[v0(\(175.dp))]", views: animationView)
        animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        animationView.center = self.center
    }
    
    func startActivityIndicator() {
        print("startActivityIndicator")
        animationView.play()
//        self.activityIndicator.isHidden = false
//        activityIndicator.center = self.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
//       // activityIndicator.style = UIActivityIndicatorView.Style.gray
//
//        //self.addSubview(activityIndicator)
//        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        animationView.stop()
//        activityIndicator.stopAnimating()
        self.isHidden = true
    }
    
    var blurEffectView: UIVisualEffectView?
    
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = self.bounds
        
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView!)
    }
    
}

