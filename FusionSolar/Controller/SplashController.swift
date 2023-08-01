//
//  SplashController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 20/07/23.
//

import UIKit
import Lottie

class SplashController: UIViewController {
    
    static let currentVersion = "1.0.0"
    var isTimerEnd = false
    var isLoadEnd = false
    var isRightVersion = false
    
    let animationView: LottieAnimationView = {
        let view = LottieAnimationView.init(name: "solar_uzb")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.animationSpeed = 0.7
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 24.dp)
        label.textAlignment = .center
        label.text = "FusionSolar"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        label.textAlignment = .center
        label.text = NSLocalizedString("app_description", comment: "")
        return label
    }()
    
    let versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(136, green: 136, blue: 136)
        label.font = .boldSystemFont(ofSize: 18.dp)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(233, green: 237, blue: 246)
        
        HomeController.selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? ""
        if(HomeController.selectedLanguage != "") {
            self.setupLanguage()
        }
        
        self.setupView()
        self.initView()
        self.startTimer()
    }
    
    func setupView() {
        self.view.addSubview(animationView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(versionLabel)
        
        self.view.addConstraintsWithFormat("H:[v0(\(200.dp))]", views: animationView)
        self.view.addConstraintsWithFormat("H:[v0]", views: titleLabel)
        self.view.addConstraintsWithFormat("H:[v0]", views: descriptionLabel)
        self.view.addConstraintsWithFormat("H:[v0]", views: versionLabel)
        
        self.view.addConstraintsWithFormat("V:[v0(\(200.dp))]", views: animationView)
        self.view.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        self.view.addConstraintsWithFormat("V:[v0]", views: descriptionLabel)
        self.view.addConstraintsWithFormat("V:[v0]", views: versionLabel)
        
        animationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        versionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        animationView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 136.dp).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -126.dp).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -8.dp).isActive = true
        versionLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32.dp).isActive = true
        
        animationView.play()
    }
    
    func initView() {
        versionLabel.text = "v: \(SplashController.currentVersion)"
        
        HomeController.login = UserDefaults.standard.string(forKey: "login") ?? ""
        HomeController.password = UserDefaults.standard.string(forKey: "password") ?? ""
        
        if(HomeController.login != "" && HomeController.password != "") {
            self.fetchProfile()
        } else {
            self.isLoadEnd = true
        }
    }
    
    func setupLanguage() {
        var language = HomeController.selectedLanguage
        let defaults = UserDefaults.standard
        defaults.set (language, forKey: "AppleLanguage")
        defaults.synchronize ()
        Bundle.setLanguage (language)
    }
    
    func openController() {
        if(HomeController.selectedLanguage == "") {
            self.openLanguageController()
        } else {
            if(HomeController.profile == nil) {
                self.openSignInController()
            } else {
                self.openHomeController()
            }
        }
    }
    
    func openSignInController() {
        let signInController = SignInController()
        signInController.modalTransitionStyle = .crossDissolve
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: signInController)
    }
    
    func openLanguageController() {
        let languageController = LanguageController()
        languageController.modalTransitionStyle = .crossDissolve
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: languageController)
    }
    
    func openHomeController() {
        let homeController = HomeController()
        homeController.modalTransitionStyle = .crossDissolve
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: homeController)
    }
    
    //ApiService
    func fetchProfile() {
      //  self.openHomeController()
        ApiService.sharedInstance.fetchProfile() {
            (error: CustomError?, profile: Profile?) in
            if(error?.code ?? 0 == 0) {
                HomeController.profile = profile
                self.isLoadEnd = true
                if(self.isTimerEnd) {
                    self.openController()
                }
            } else {
                let defaults = UserDefaults.standard
                defaults.removeObject(forKey: "login")
                defaults.removeObject(forKey: "password")
                defaults.synchronize()
                self.isLoadEnd = true
                if(self.isTimerEnd) {
                    self.openController()
                }
            }
        }
    }
    //
    
    //Timer
    var timer: Timer?
    func startTimer() {
        print("startTimer")
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerEnd), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerEnd() {
        stopTimer()
        self.isTimerEnd = true
        print("timerEnd")
        if(self.isLoadEnd) {
            self.openController()
        }
    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    //
    
}
