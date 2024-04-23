//
//  AboutController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 22/04/24.
//

import UIKit

class AboutController: UIViewController {
    
    //headeView
    let headeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "back")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 24.dp)
        label.text = NSLocalizedString("about", comment: "")
        return label
    }()
    //
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 18.dp)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupHeaderView()
        
        self.initView()
    }
    
    func initView() {
        valueLabel.text = "version: \(SplashController.currentVersion)\ndatabase: \(SplashController.databaseVersion)\n\nOOO \"SAB GAMES\"\nCopyright © 2023-2024\nAll rights reserved"
    }
    
    func setupView() {
        self.view.addSubview(headeView)
        self.view.addSubview(valueLabel)
        
        self.view.addConstraintsWithFormat("H:|-\(8.dp)-[v0]-\(24.dp)-|", views: headeView)
        self.view.addConstraintsWithFormat("H:[v0]", views: valueLabel)
        
        self.view.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: headeView)
        self.view.addConstraintsWithFormat("V:[v0]", views: valueLabel)
        
        valueLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        headeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6.dp).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func setupHeaderView() {
        headeView.addSubview(backButton)
        headeView.addSubview(titleLabel)
        
        headeView.addConstraintsWithFormat("H:|-\(8.dp)-[v0(\(46.dp))][v1]|", views: backButton, titleLabel)
        
        headeView.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: backButton)
        headeView.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        
        backButton.centerYAnchor.constraint(equalTo: headeView.centerYAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: headeView.centerYAnchor).isActive = true
        
        backButton.addTarget(self, action: #selector(self.backButtonPress), for: .touchUpInside)
    }
    
    @objc func backButtonPress() {
        self.dismiss(animated: true)
    }
}
