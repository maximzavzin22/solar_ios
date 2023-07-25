//
//  LanguageController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit

class LanguageController: UIViewController {
    
    let titleLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 24.dp)
        label.text = NSLocalizedString("language_title", comment: "")
        return label
    }()
    
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
        button.isEnabled = false
        button.tintColor = .white
        button.alpha = 0.4
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(233, green: 237, blue: 246)
        
        self.setupView()
        self.setupContenView()
    }
    
    func setupView() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(contenView)
        self.view.addSubview(chooseButton)
        
        self.view.addConstraintsWithFormat("H:|-\(24.dp)-[v0]", views: titleLabel)
        self.view.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: contenView)
        self.view.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: chooseButton)
        
        self.view.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        self.view.addConstraintsWithFormat("V:[v0(\(288.dp))]", views: contenView)
        self.view.addConstraintsWithFormat("V:[v0(\(50.dp))]", views: chooseButton)
        
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 17.dp).isActive = true
        contenView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32.dp).isActive = true
        chooseButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -17.dp).isActive = true
        
        chooseButton.addTarget(self, action: #selector(self.chooseButtonPress), for: .touchUpInside)
    }
    
    @objc func chooseButtonPress() {
        UserDefaults.standard.set(HomeController.selectedLanguage, forKey: "selectedLanguage")
        if(HomeController.selectedLanguage != "") {
            self.setupLanguage()
        }
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
        self.activeButton()
        HomeController.selectedLanguage = "uz-UZ"
        chooseButton.setTitle("", for: .normal)
        titleLabel.text = ""
    }
    
    @objc func uzCyrlLanguageViewPress() {
        self.unSelectAll()
        uzCyrlLanguageView.isSelect = true
        self.activeButton()
        HomeController.selectedLanguage = "uz-Cyrl"
        chooseButton.setTitle("", for: .normal)
        titleLabel.text = ""
    }
    
    @objc func ruLanguageViewPress() {
        self.unSelectAll()
        ruLanguageView.isSelect = true
        self.activeButton()
        HomeController.selectedLanguage = "ru-RU"
        chooseButton.setTitle("Выбрать", for: .normal)
        titleLabel.text = "Язык"
    }
    
    @objc func enLanguageViewPress() {
        self.unSelectAll()
        enLanguageView.isSelect = true
        self.activeButton()
        HomeController.selectedLanguage = "en"
        chooseButton.setTitle("Choose", for: .normal)
        titleLabel.text = "Language"
    }
    
    func unSelectAll() {
        uzLanguageView.isSelect = false
        uzCyrlLanguageView.isSelect = false
        ruLanguageView.isSelect = false
        enLanguageView.isSelect = false
    }
    
    func activeButton() {
        chooseButton.alpha = 1
        chooseButton.isEnabled = true
    }
    
    func setupLanguage() {
        var language = HomeController.selectedLanguage
        let defaults = UserDefaults.standard
        defaults.set (language, forKey: "AppleLanguage")
        defaults.synchronize ()
        Bundle.setLanguage (language)
        
        self.openController()
    }
    
    func openController() {
        if(HomeController.profile == nil) {
            self.openSignInController()
        } else {
            self.openHomeController()
        }
    }
    
    func openSignInController() {
        let signInController = SignInController()
        signInController.modalTransitionStyle = .crossDissolve
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: signInController)
    }
    
    func openHomeController() {
        let homeController = HomeController()
        homeController.modalTransitionStyle = .crossDissolve
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: homeController)
    }
}

class LanguageView: UIView {
    
    var isSelect: Bool? {
        didSet {
            if(isSelect ?? false) {
                self.layer.borderWidth = 1.dp
                self.layer.borderColor = UIColor.rgb(39, green: 87, blue: 238).cgColor
            } else {
                self.layer.borderWidth = 0.dp
            }
        }
    }
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 18.dp)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp
        
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        
        self.addConstraintsWithFormat("H:|-\(24.dp)-[v0(\(32.dp))]-\(12.dp)-[v1]", views: iconImageView, titleLabel)
        
        self.addConstraintsWithFormat("V:[v0(\(32.dp))]", views: iconImageView)
        self.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
