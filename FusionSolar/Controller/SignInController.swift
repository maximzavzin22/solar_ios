//
//  SignInController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 20/07/23.
//

import UIKit

class SignInController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    var isShowPassword = false
    
//    var unissoLogin: UnissoLogin? {
//        didSet {
//           // dump(unissoLogin)
//            self.fetchValidateUser(username: unissoLogin?.body?.username ?? "", password: unissoLogin?.body?.password ?? "", url: unissoLogin?.url ?? "")
//        }
//    }
//    
//    var validateCookie: ValidateCookie? {
//        didSet {
//            dump(validateCookie)
//            self.fetchLogin()
//        }
//    }
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 17.dp, height: textField.frame.height))
        textField.leftView = paddingView
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 17.dp, height: textField.frame.height))
        textField.rightView = rightPaddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.rightViewMode = UITextField.ViewMode.always
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16.dp), .foregroundColor: UIColor.rgb(179, green: 179, blue: 179)]
        textField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("sign_in_username", comment: ""), attributes: attrs)
        textField.textColor = .rgb(1, green: 6, blue: 10)
        textField.font = UIFont.systemFont(ofSize: 16.dp)
        textField.textAlignment = .left
        textField.backgroundColor = .rgb(255, green: 255, blue: 255)
        textField.layer.cornerRadius = 16.dp
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 17.dp, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 58.dp, height: textField.frame.height))
        textField.rightView = rightPaddingView
        textField.rightViewMode = UITextField.ViewMode.always
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16.dp), .foregroundColor: UIColor.rgb(179, green: 179, blue: 179)]
        textField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("sign_in_password", comment: ""), attributes: attrs)
        textField.textColor = .rgb(1, green: 6, blue: 10)
        textField.font = UIFont.systemFont(ofSize: 16.dp)
        textField.textAlignment = .left
        textField.backgroundColor = .rgb(255, green: 255, blue: 255)
        textField.layer.cornerRadius = 16.dp
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "eye off")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .rgb(39, green: 87, blue: 238)
        button.layer.cornerRadius = 23.dp
        button.setTitle(NSLocalizedString("log_in", comment: ""), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.dp)
        button.titleLabel?.textColor = .white
        button.tintColor = .white
        return button
    }()
    
    let errorView: SimpleErrorView = {
        let eV = SimpleErrorView()
        eV.translatesAutoresizingMaskIntoConstraints = false
        return eV
    }()

    let loadingView: LoadingView = {
        let lV = LoadingView()
        lV.translatesAutoresizingMaskIntoConstraints = false
        return lV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(233, green: 237, blue: 246)
        
        self.setupView()
        self.setupContentScrollView()
        self.setupToolbar()
        self.registerForKeyboardNotifications()
    }
    
    func setupView() {
        self.view.addSubview(contentScrollView)
        
        self.view.addConstraintsWithFormat("H:[v0(\(362.dp))]", views: contentScrollView)
        
        contentScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        contentScrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupContentScrollView() {
        self.contentScrollView.addSubview(logoImageView)
        self.contentScrollView.addSubview(usernameTextField)
        self.contentScrollView.addSubview(passwordTextField)
        self.contentScrollView.addSubview(eyeButton)
        self.contentScrollView.addSubview(loginButton)
        
        self.contentScrollView.addConstraintsWithFormat("H:[v0(\(120.dp))]", views: logoImageView)
        self.contentScrollView.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: usernameTextField)
        self.contentScrollView.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: passwordTextField)
        self.contentScrollView.addConstraintsWithFormat("H:[v0(\(58.dp))]|", views: eyeButton)
        self.contentScrollView.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: loginButton)
        
        self.contentScrollView.addConstraintsWithFormat("V:[v0(\(120.dp))]", views: logoImageView)
        self.contentScrollView.addConstraintsWithFormat("V:[v0(\(62.dp))]", views: usernameTextField)
        self.contentScrollView.addConstraintsWithFormat("V:[v0(\(62.dp))]", views: passwordTextField)
        self.contentScrollView.addConstraintsWithFormat("V:[v0(\(62.dp))]", views: eyeButton)
        self.contentScrollView.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: loginButton)
        
        logoImageView.centerXAnchor.constraint(equalTo: self.contentScrollView.centerXAnchor).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: self.contentScrollView.centerXAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.contentScrollView.centerXAnchor).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.contentScrollView.centerXAnchor).isActive = true
        eyeButton.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor).isActive = true
        
        logoImageView.topAnchor.constraint(equalTo: self.contentScrollView.topAnchor, constant: 106.dp).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 58.dp).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 14.dp).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 76.dp).isActive = true
        eyeButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor).isActive = true
        
        self.contentScrollView.contentSize = CGSize(width: 362.dp, height: 438.dp)
        
        loginButton.addTarget(self, action: #selector(self.loginButtonPress), for: .touchUpInside)
        eyeButton.addTarget(self, action: #selector(self.eyeButtonPress), for: .touchUpInside)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    @objc func loginButtonPress() {
        print("loginButtonPress")
        HomeController.login = self.usernameTextField.text ?? ""
        HomeController.password = self.passwordTextField.text ?? ""
        if(HomeController.login != "" && HomeController.password != "") {
            self.fetchAuth()
//            self.fetchProfile()
//            self.fetchPassword()
        }
    }
    
    @objc func eyeButtonPress() {
        isShowPassword = !isShowPassword
        if(isShowPassword) {
            passwordTextField.isSecureTextEntry = false
            let image = UIImage(named: "eye on")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            eyeButton.setImage(image, for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            let image = UIImage(named: "eye off")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            eyeButton.setImage(image, for: .normal)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        print("textFieldDidBeginEditing")
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        activeField = nil
    }
    
    func openHomeController() {
        let homeController = HomeController()
        homeController.modalTransitionStyle = .crossDissolve
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: homeController)
    }
    
    //ApiService
    func fetchAuth() {
        self.showLoadingView()
        ApiService.sharedInstance.fetchAuth(username: HomeController.login, password: HomeController.password) {
            (error: CustomError?, profile: Profile?) in
            if(error?.code ?? 0 == 0) {
                let defaults = UserDefaults.standard
                defaults.set (HomeController.login, forKey: "login")
                defaults.set (HomeController.password, forKey: "password")
                defaults.synchronize ()
                HomeController.profile = profile
                self.openHomeController()
            } else {
                self.hideLoadingView()
                self.showErrorView(title: error?.title ?? "", message: error?.message ?? "")
            }
        }
    }
    
//    func fetchProfile() {
//        self.showLoadingView()
//        ApiService.sharedInstance.fetchProfile() {
//            (error: CustomError?, profile: Profile?) in
//            if(error?.code ?? 0 == 0) {
//                let defaults = UserDefaults.standard
//                defaults.set (HomeController.login, forKey: "login")
//                defaults.set (HomeController.password, forKey: "password")
//                defaults.synchronize ()
//                self.openHomeController()
//            } else {
//                self.hideLoadingView()
//                self.showErrorView(title: error?.title ?? "", message: error?.message ?? "")
//            }
//        }
//    }
    
//    func fetchPassword() {
//        self.showLoadingView()
//        ApiService.sharedInstance.fetchPassword(username: HomeController.login, password: HomeController.password) {
//            (error: CustomError?, unissoLogin: UnissoLogin?) in
//           // self.hideLoadingView()
//            if(error?.code ?? 0 == 0) {
//                self.unissoLogin = unissoLogin
//            } else {
//                self.hideLoadingView()
//                self.showErrorView(title: error?.title ?? "", message: error?.message ?? "")
//            }
//        }
//    }
//    
//    func fetchValidateUser(username: String, password: String, url: String) {
//        self.showLoadingView()
//        ApiService.sharedInstance.fetchValidateUser(username: username, password: password, url: url) {
//            (error: CustomError?, validateCookie: ValidateCookie?) in
//           // self.hideLoadingView()
//            if(error?.code ?? 0 == 0) {
//                self.validateCookie = validateCookie
//            } else {
//                self.hideLoadingView()
//                self.showErrorView(title: error?.title ?? "", message: error?.message ?? "")
//            }
//        }
//    }
//    
//    func fetchLogin() {
//        if let validateCookie = self.validateCookie {
//       //     self.showLoadingView()
//            ApiService.sharedInstance.fetchLogin(validateCookie: validateCookie) {
//                (error: CustomError?, location: String?) in
//                //self.hideLoadingView()
//                if(error?.code ?? 0 == 0) {
//                    if(location != "") {
//                        self.fetchAuth(url: location ?? "")
//                    } else {
//                        self.hideLoadingView()
//                    }
//                } else {
//                    self.hideLoadingView()
//                    self.showErrorView(title: error?.title ?? "", message: error?.message ?? "")
//                }
//            }
//        }
//    }
//    
//    func fetchAuth(url: String) {
//        if let validateCookie = self.validateCookie {
//            //self.showLoadingView()
//            ApiService.sharedInstance.fetchAuth(url: url) {
//                (error: CustomError?, bspsession: String?) in
//                self.hideLoadingView()
//                if(error?.code ?? 0 == 0) {
//                    HomeController.bspsession = bspsession ?? ""
//                    self.openHomeController()
//                } else {
//                    self.hideLoadingView()
//                    self.showErrorView(title: error?.title ?? "", message: error?.message ?? "")
//                }
//            }
//        }
//    }
    //
    
    //Error and Loading views
    func showErrorView(title: String, message: String) {
        self.view.addSubview(errorView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: errorView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: errorView)
        errorView.isHidden = false
        errorView.title = title
        errorView.message = message
    }
    
    func showLoadingView() {
        self.view.addSubview(loadingView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: loadingView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: loadingView)
        loadingView.isHidden = false
        loadingView.startActivityIndicator()
    }
    
    func hideLoadingView() {
        loadingView.stopActivityIndicator()
        loadingView.isHidden = true
    }
    //
    
    //keyboard
    func setupToolbar() {
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30.dp))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: .done, target: self, action: #selector(self.doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        
        usernameTextField.inputAccessoryView = toolbar
        usernameTextField.delegate = self
        
        passwordTextField.inputAccessoryView = toolbar
        passwordTextField.delegate = self
    }
    
    @objc func doneButtonAction() {
        print("doneButtonAction")
        self.view.endEditing(true)
    }
    
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        print("registerForKeyboardNotifications")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        print("deregisterFromKeyboardNotifications")
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var activeField: UITextField?
    var keyboardHeight: CGFloat! = 0
    
    @objc func keyboardWasShown(notification: NSNotification){
        var info = notification.userInfo!
        let kbSize: CGSize = ((info[UIApplication.keyboardFrameEndUserInfoKey] as? CGRect)?.size)!
        print("kbSize = \(kbSize)")
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        contentScrollView.contentInset = contentInsets
        contentScrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize.height
        if(activeField != nil) {
            if !aRect.contains(activeField!.frame.origin) {
                self.contentScrollView.scrollRectToVisible(activeField!.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        print("keyboardWillBeHidden")
        let contentInsets: UIEdgeInsets = .zero
        self.contentScrollView.contentInset = contentInsets
        self.contentScrollView.scrollIndicatorInsets = contentInsets
    }
    //
}
