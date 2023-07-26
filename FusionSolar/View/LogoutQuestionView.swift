//
//  LogoutQuestionView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 26/07/23.
//

import UIKit

class LogoutQuestionView: UIView {
    
    var settingsController: SettingsController?
    
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
        view.layer.cornerRadius = 16.dp
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.textAlignment = .center
        label.text = NSLocalizedString("log_out_question", comment: "")
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    //buttonsView
    let buttonsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        button.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        button.titleLabel?.textColor = .rgb(39, green: 87, blue: 238)
        button.titleLabel?.font = .systemFont(ofSize: 18.dp)
        button.tintColor = .rgb(39, green: 87, blue: 238)
        button.layer.cornerRadius = 21.dp
        return button
    }()
    
    let seperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(204, green: 204, blue: 204)
        return view
    }()
    
    let exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        button.setTitle(NSLocalizedString("exit", comment: ""), for: .normal)
        button.titleLabel?.textColor = .rgb(196, green: 72, blue: 82)
        button.titleLabel?.font = .systemFont(ofSize: 18.dp)
        button.tintColor = .rgb(196, green: 72, blue: 82)
        button.layer.cornerRadius = 21.dp
        return button
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupBorderView()
        self.setupButtonsView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(blackoutView)
        self.addBlurEffect()
        self.addSubview(borderView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: blackoutView)
        self.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: borderView)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: blackoutView)
        self.addConstraintsWithFormat("V:[v0(\(134.dp))]", views: borderView)
        
        borderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        borderView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupBorderView() {
        borderView.addSubview(messageLabel)
        borderView.addSubview(buttonsView)
        
        borderView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: messageLabel)
        borderView.addConstraintsWithFormat("H:[v0(\(342.dp))]", views: buttonsView)
        
        borderView.addConstraintsWithFormat("V:|-\(24.dp)-[v0]", views: messageLabel)
        borderView.addConstraintsWithFormat("V:[v0(\(42.dp))]-\(24.dp)-|", views: buttonsView)
        
        buttonsView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
    }
    
    func setupButtonsView() {
        buttonsView.addSubview(cancelButton)
        buttonsView.addSubview(seperateView)
        buttonsView.addSubview(exitButton)
        
        buttonsView.addConstraintsWithFormat("H:|[v0(\(162.dp))]-\(8.5.dp)-[v1(\(1.dp))]-\(8.5.dp)-[v2(\(162.dp))]", views: cancelButton, seperateView, exitButton)
        
        buttonsView.addConstraintsWithFormat("V:|[v0]|", views: cancelButton)
        buttonsView.addConstraintsWithFormat("V:|[v0]|", views: exitButton)
        buttonsView.addConstraintsWithFormat("V:[v0(\(18.dp))]", views: seperateView)
        
        seperateView.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor).isActive = true
        
        cancelButton.addTarget(self, action: #selector(self.cancelButtonPress), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(self.exitButtonPress), for: .touchUpInside)
    }
    
    @objc func cancelButtonPress() {
        print("cancelButtonPress")
        self.isHidden = true
    }
    
    @objc func exitButtonPress() {
        print("exitButtonPress")
        self.settingsController?.logOut()
        self.isHidden = true
    }
    
    var blurEffectView: UIVisualEffectView?
    
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = self.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView!)
    }
}
