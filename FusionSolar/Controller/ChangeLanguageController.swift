//
//  ChangeLanguageController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 26/07/23.
//

import UIKit

class ChangeLanguageController: UIViewController {
    
    var isChangeLanguage = false
    var selectedLanguage = ""
    
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
        label.text = NSLocalizedString("language_title", comment: "")
        return label
    }()
    //
    
    let contenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let uzLanguageView: LanguageView = {
        let view = LanguageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.iconImageView.image = UIImage(named: "uz_lat")
        view.titleLabel.text = "O’zbek"
        return view
    }()
    
    let uzCyrlLanguageView: LanguageView = {
        let view = LanguageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.iconImageView.image = UIImage(named: "uz_cyrl")
        view.titleLabel.text = "Ўзбекча"
        return view
    }()
    
    let ruLanguageView: LanguageView = {
        let view = LanguageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.iconImageView.image = UIImage(named: "ru")
        view.titleLabel.text = "Русский"
        return view
    }()
    
    let enLanguageView: LanguageView = {
        let view = LanguageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.iconImageView.image = UIImage(named: "en")
        view.titleLabel.text = "English"
        return view
    }()
    
    let chooseButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .rgb(39, green: 87, blue: 238)
        button.layer.cornerRadius = 25.dp
        button.setTitle(NSLocalizedString("choose", comment: ""), for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18.dp)
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupHeadeView()
        self.setupContenView()
        self.initView()
    }
    
    func initView() {
        self.selectedLanguage = HomeController.selectedLanguage
        if(HomeController.selectedLanguage == "ru-RU") {
            ruLanguageView.isSelect = true
        }
        if(HomeController.selectedLanguage == "uz-UZ") {
            uzLanguageView.isSelect = true
        }
        if(HomeController.selectedLanguage == "uz-Cyrl") {
            uzCyrlLanguageView.isSelect = true
        }
        if(HomeController.selectedLanguage == "en") {
            enLanguageView.isSelect = true
        }
    }
    
    func setupView() {
        self.view.addSubview(headeView)
        self.view.addSubview(contenView)
        self.view.addSubview(chooseButton)
        
        self.view.addConstraintsWithFormat("H:|-\(8.dp)-[v0]-\(24.dp)-|", views: headeView)
        self.view.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: contenView)
        self.view.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: chooseButton)
        
        self.view.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: headeView)
        self.view.addConstraintsWithFormat("V:[v0(\(288.dp))]", views: contenView)
        self.view.addConstraintsWithFormat("V:[v0(\(50.dp))]", views: chooseButton)
        
        headeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6.dp).isActive = true
        contenView.topAnchor.constraint(equalTo: headeView.bottomAnchor, constant: 32.dp).isActive = true
        chooseButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -17.dp).isActive = true
        
        chooseButton.addTarget(self, action: #selector(self.chooseButtonPress), for: .touchUpInside)
    }
    
    @objc func chooseButtonPress() {
        if(HomeController.selectedLanguage != self.selectedLanguage) {
            HomeController.selectedLanguage = self.selectedLanguage
            isChangeLanguage = true
            UserDefaults.standard.set(HomeController.selectedLanguage, forKey: "selectedLanguage")
            if(HomeController.selectedLanguage != "") {
                self.setupLanguage()
            }
        } else {
            self.backButtonPress()
        }
    }
    
    func setupHeadeView() {
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
    
    func setupContenView() {
        contenView.addSubview(uzLanguageView)
        contenView.addSubview(uzCyrlLanguageView)
        contenView.addSubview(ruLanguageView)
        contenView.addSubview(enLanguageView)
        
        contenView.addConstraintsWithFormat("H:|[v0]|", views: uzLanguageView)
        contenView.addConstraintsWithFormat("H:|[v0]|", views: uzCyrlLanguageView)
        contenView.addConstraintsWithFormat("H:|[v0]|", views: ruLanguageView)
        contenView.addConstraintsWithFormat("H:|[v0]|", views: enLanguageView)
        
        contenView.addConstraintsWithFormat("V:|[v0(\(60.dp))]-\(16.dp)-[v1(\(60.dp))]-\(16.dp)-[v2(\(60.dp))]-\(16.dp)-[v3(\(60.dp))]", views: uzLanguageView, uzCyrlLanguageView, ruLanguageView, enLanguageView)
        
        let tapUzLanguageView = UITapGestureRecognizer(target: self, action: #selector(self.uzLanguageViewPress))
        uzLanguageView.isUserInteractionEnabled = true
        uzLanguageView.addGestureRecognizer(tapUzLanguageView)
        
        let tapUzCyrlLanguageView = UITapGestureRecognizer(target: self, action: #selector(self.uzCyrlLanguageViewPress))
        uzCyrlLanguageView.isUserInteractionEnabled = true
        uzCyrlLanguageView.addGestureRecognizer(tapUzCyrlLanguageView)
        
        let tapRuLanguageView = UITapGestureRecognizer(target: self, action: #selector(self.ruLanguageViewPress))
        ruLanguageView.isUserInteractionEnabled = true
        ruLanguageView.addGestureRecognizer(tapRuLanguageView)
        
        let tapEnLanguageView = UITapGestureRecognizer(target: self, action: #selector(self.enLanguageViewPress))
        enLanguageView.isUserInteractionEnabled = true
        enLanguageView.addGestureRecognizer(tapEnLanguageView)
    }
    
    @objc func uzLanguageViewPress() {
        self.unSelectAll()
        uzLanguageView.isSelect = true
        self.selectedLanguage = "uz-UZ"
//        chooseButton.setTitle("", for: .normal)
    }
    
    @objc func uzCyrlLanguageViewPress() {
        self.unSelectAll()
        uzCyrlLanguageView.isSelect = true
        self.selectedLanguage = "uz-Cyrl"
//        chooseButton.setTitle("", for: .normal)
    }
    
    @objc func ruLanguageViewPress() {
        self.unSelectAll()
        ruLanguageView.isSelect = true
        self.selectedLanguage = "ru-RU"
//        chooseButton.setTitle("Выбрать", for: .normal)
    }
    
    @objc func enLanguageViewPress() {
        self.unSelectAll()
        enLanguageView.isSelect = true
        self.selectedLanguage = "en"
//        chooseButton.setTitle("Choose", for: .normal)
    }
    
    func unSelectAll() {
        uzLanguageView.isSelect = false
        uzCyrlLanguageView.isSelect = false
        ruLanguageView.isSelect = false
        enLanguageView.isSelect = false
    }
    
    func setupLanguage() {
        var language = HomeController.selectedLanguage
        let defaults = UserDefaults.standard
        defaults.set (language, forKey: "AppleLanguage")
        defaults.synchronize ()
        Bundle.setLanguage (language)
        
        if(self.isChangeLanguage) {
            let splashController = SplashController()
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: splashController)
        } else {
            self.backButtonPress()
        }
    }
}
