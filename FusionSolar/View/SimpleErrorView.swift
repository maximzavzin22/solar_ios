//
//  SimpleErrorView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 20/07/23.
//

import UIKit

class SimpleErrorView: UIView {
    
    var isNeedUpdate = false
    
    var title: String? {
        didSet {
            if(title ?? "" == "") {
                title = NSLocalizedString("error", comment: "")
            }
            titleLabel.text = title
        }
    }
    
    var message: String? {
        didSet {
            if(message ?? "" == "") {
                message = NSLocalizedString("error_description", comment: "")
            }
            messageLabel.text = message
        }
    }
    
    let blackoutView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12.dp
        view.layer.masksToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .blackTextColor()
        label.textAlignment = .center
        label.text = NSLocalizedString("error", comment: "")
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .blackTextColor()
        label.textAlignment = .center
        label.text = NSLocalizedString("error_description", comment: "")
        label.font = .systemFont(ofSize: 13.dp)
        return label
    }()
    
    let seperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        return view
    }()
    
    let okButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.textColor = .rgb(0, green: 122, blue: 255)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16.dp)
        button.tintColor = .rgb(0, green: 122, blue: 255)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupBorderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(blackoutView)
        self.addBlurEffect()
        self.addSubview(borderView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: blackoutView)
        self.addConstraintsWithFormat("H:[v0(\(270.dp))]", views: borderView)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: blackoutView)
        self.addConstraintsWithFormat("V:[v0(\(132.dp))]", views: borderView)
        
        borderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        borderView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupBorderView() {
        self.borderView.addSubview(titleLabel)
        self.borderView.addSubview(messageLabel)
        self.borderView.addSubview(seperateView)
        self.borderView.addSubview(okButton)
        
        self.borderView.addConstraintsWithFormat("H:|-\(16.dp)-[v0]-\(16.dp)-|", views: titleLabel)
        self.borderView.addConstraintsWithFormat("H:|-\(16.dp)-[v0]-\(16.dp)-|", views: messageLabel)
        self.borderView.addConstraintsWithFormat("H:|[v0]|", views: seperateView)
        self.borderView.addConstraintsWithFormat("H:|[v0]|", views: okButton)
        
        self.borderView.addConstraintsWithFormat("V:|-\(17.dp)-[v0][v1(\(48.dp))]", views: titleLabel, messageLabel)
        self.borderView.addConstraintsWithFormat("V:[v0(\(1.dp))][v1(\(44.dp))]|", views: seperateView, okButton)
        
        okButton.addTarget(self, action: #selector(okButtonPress), for: .touchUpInside)
    }
    
    @objc func okButtonPress() {
        self.isHidden = true
    }
    
    var blurEffectView: UIVisualEffectView?
    
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = self.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView!)
    }
}
