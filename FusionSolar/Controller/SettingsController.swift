//
//  SettingsController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 26/07/23.
//

import UIKit

class SettingsController: UIViewController {
    
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
        label.text = NSLocalizedString("settings", comment: "")
        return label
    }()
    //
    
    let languageSettingRowView: SettingRowView = {
        let view = SettingRowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("language_title", comment: "")
        view.valueLabel.text = ""
        return view
    }()
    
    let securitySettingRowView: SettingRowView = {
        let view = SettingRowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("account_security", comment: "")
        view.valueLabel.text = ""
        return view
    }()
    
    let deletionSettingRowView: SettingRowView = {
        let view = SettingRowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("account_deletion", comment: "")
        view.valueLabel.text = ""
        return view
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .rgb(228, green: 228, blue: 228)
        button.layer.cornerRadius = 21.dp
        button.setTitle("\(NSLocalizedString("log_out", comment: ""))", for: .normal)
        button.titleLabel?.textColor = .rgb(196, green: 72, blue: 82)
        button.titleLabel?.font = .systemFont(ofSize: 18.dp)
        button.tintColor = .rgb(196, green: 72, blue: 82)
        return button
    }()
    
    lazy var logoutQuestionView: LogoutQuestionView = {
        let view = LogoutQuestionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.settingsController = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupHeadeView()
        self.initView()
    }
    
    func initView() {
        if(HomeController.selectedLanguage == "ru-RU") {
            languageSettingRowView.valueLabel.text = "Русский"
        }
        if(HomeController.selectedLanguage == "uz-UZ") {
            languageSettingRowView.valueLabel.text = "O’zbek"
        }
        if(HomeController.selectedLanguage == "uz-Cyrl") {
            languageSettingRowView.valueLabel.text = "Ўзбекча"
        }
        if(HomeController.selectedLanguage == "en") { 
            languageSettingRowView.valueLabel.text = "English"
        }
    }
    
    func setupView() {
        self.view.addSubview(headeView)
        self.view.addSubview(languageSettingRowView)
        self.view.addSubview(securitySettingRowView)
        self.view.addSubview(deletionSettingRowView)
        self.view.addSubview(logoutButton)
        self.view.addSubview(logoutQuestionView)
        
        self.view.addConstraintsWithFormat("H:|-\(8.dp)-[v0]-\(24.dp)-|", views: headeView)
        self.view.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: languageSettingRowView)
        self.view.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: securitySettingRowView)
        self.view.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: deletionSettingRowView)
        self.view.addConstraintsWithFormat("H:|-\(75.dp)-[v0]-\(75.dp)-|", views: logoutButton)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: logoutQuestionView)
        
        self.view.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: headeView)
        self.view.addConstraintsWithFormat("V:[v0(\(56.dp))]", views: languageSettingRowView)
        self.view.addConstraintsWithFormat("V:[v0(\(56.dp))]", views: securitySettingRowView)
        self.view.addConstraintsWithFormat("V:[v0(\(56.dp))]", views: deletionSettingRowView)
        self.view.addConstraintsWithFormat("V:[v0(\(42.dp))]", views: logoutButton)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: logoutQuestionView)
        
        languageSettingRowView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        securitySettingRowView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        deletionSettingRowView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        headeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6.dp).isActive = true
        languageSettingRowView.topAnchor.constraint(equalTo: headeView.bottomAnchor, constant: 16.dp).isActive = true
        securitySettingRowView.topAnchor.constraint(equalTo: languageSettingRowView.bottomAnchor, constant: 16.dp).isActive = true
        deletionSettingRowView.topAnchor.constraint(equalTo: securitySettingRowView.bottomAnchor, constant: 16.dp).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16.dp).isActive = true
        
        let languageSettingRowViewTap = UITapGestureRecognizer(target: self, action: #selector(self.languageSettingRowViewPress))
        languageSettingRowView.isUserInteractionEnabled = true
        languageSettingRowView.addGestureRecognizer(languageSettingRowViewTap)
        
        let securitySettingRowViewTap = UITapGestureRecognizer(target: self, action: #selector(self.securitySettingRowViewPress))
        securitySettingRowView.isUserInteractionEnabled = true
        securitySettingRowView.addGestureRecognizer(securitySettingRowViewTap)
        
        let deletionSettingRowViewTap = UITapGestureRecognizer(target: self, action: #selector(self.deletionSettingRowViewPress))
        deletionSettingRowView.isUserInteractionEnabled = true
        deletionSettingRowView.addGestureRecognizer(deletionSettingRowViewTap)
        
        logoutButton.addTarget(self, action: #selector(self.logoutButtonPress), for: .touchUpInside)
        
        logoutQuestionView.isHidden = true
        
        securitySettingRowView.isHidden = true
        deletionSettingRowView.isHidden = true
    }
    
    @objc func languageSettingRowViewPress() {
        self.openChangeLanguageController()
    }
    
    @objc func securitySettingRowViewPress() {
        print("securitySettingRowViewPress")
    }
    
    @objc func deletionSettingRowViewPress() {
        print("deletionSettingRowViewPress")
    }
    
    @objc func logoutButtonPress() {
        logoutQuestionView.isHidden = false
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
    
    func openChangeLanguageController() {
        let changeLanguageController = ChangeLanguageController()
        changeLanguageController.modalPresentationStyle = .fullScreen
        self.present(changeLanguageController, animated: true)
    }
    
    func logOut() {
        HomeController.login = ""
        HomeController.password = ""
        HomeController.token = ""
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "login")
        defaults.removeObject(forKey: "password")
        defaults.synchronize()
        let signInController = SignInController()
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: signInController)
    }
}

class SettingRowView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(157, green: 157, blue: 157)
        label.font = .systemFont(ofSize: 16.dp)
        label.textAlignment = .right
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "arrow")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(titleLabel)
        self.addSubview(valueLabel)
        self.addSubview(arrowImageView)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0][v1(\(100.dp))]-\(10.dp)-[v2(\(10.dp))]-\(20.dp)-|", views: titleLabel, valueLabel, arrowImageView)
        
        self.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        self.addConstraintsWithFormat("V:[v0]", views: valueLabel)
        self.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: arrowImageView)
        
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
