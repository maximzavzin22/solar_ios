//
//  ProfileView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit

class ProfileView: UIView {
    
    var homeController: HomeController?
    
    let profileInfoView: ProfileInfoView = {
        let view = ProfileInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16.dp
        return view
    }()
    
    let companyProfileRowView: ProfileRowView = {
        let view = ProfileRowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.iconImageView.image = UIImage(named: "info_icon")
        view.titleLabel.text = NSLocalizedString("company_info", comment: "")
        return view
    }()
    
    let aboutProfileRowView: ProfileRowView = {
        let view = ProfileRowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.iconImageView.image = UIImage(named: "about_icon")
        view.titleLabel.text = NSLocalizedString("about", comment: "")
        view.seperateView.isHidden = true
        return view
    }()
    
    let settingProfileRowView: ProfileRowFonView = {
        let view = ProfileRowFonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.iconImageView.image = UIImage(named: "tabler_settings")
        view.titleLabel.text = NSLocalizedString("settings", comment: "")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(profileInfoView)
        self.addSubview(borderView)
        borderView.addSubview(companyProfileRowView)
        borderView.addSubview(aboutProfileRowView)
        self.addSubview(settingProfileRowView)
        
        self.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: profileInfoView)
        self.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: borderView)
        borderView.addConstraintsWithFormat("H:|[v0]|", views: companyProfileRowView)
        borderView.addConstraintsWithFormat("H:|[v0]|", views: aboutProfileRowView)
        self.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: settingProfileRowView)
        
        self.addConstraintsWithFormat("V:[v0(\(72.dp))]", views: profileInfoView)
        self.addConstraintsWithFormat("V:[v0(\(112.dp))]", views: borderView)
        borderView.addConstraintsWithFormat("V:|[v0(\(56.dp))][v1(\(56.dp))]", views: companyProfileRowView, aboutProfileRowView)
        self.addConstraintsWithFormat("V:[v0(\(56.dp))]", views: settingProfileRowView)
        
        profileInfoView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        borderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        settingProfileRowView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        profileInfoView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 24.dp).isActive = true
        borderView.topAnchor.constraint(equalTo: self.profileInfoView.bottomAnchor, constant: 24.dp).isActive = true
        settingProfileRowView.topAnchor.constraint(equalTo: self.borderView.bottomAnchor, constant: 16.dp).isActive = true
        
        let companyProfileRowViewTap = UITapGestureRecognizer(target: self, action: #selector(self.companyProfileRowViewPress))
        companyProfileRowView.isUserInteractionEnabled = true
        companyProfileRowView.addGestureRecognizer(companyProfileRowViewTap)
        
        let aboutProfileRowViewTap = UITapGestureRecognizer(target: self, action: #selector(self.aboutProfileRowViewPress))
        aboutProfileRowView.isUserInteractionEnabled = true
        aboutProfileRowView.addGestureRecognizer(aboutProfileRowViewTap)
        
        let settingProfileRowViewTap = UITapGestureRecognizer(target: self, action: #selector(self.settingProfileRowViewPress))
        settingProfileRowView.isUserInteractionEnabled = true
        settingProfileRowView.addGestureRecognizer(settingProfileRowViewTap)
    }
    
    @objc func companyProfileRowViewPress() {
        print("companyProfileRowViewPress")
    }
    
    @objc func aboutProfileRowViewPress() {
        print("aboutProfileRowViewPress")
    }
    
    @objc func settingProfileRowViewPress() {
        print("settingProfileRowViewPress")
        self.homeController?.openSettingsController()
    }
}

class ProfileInfoView: UIView {
    
    var profile: Profile? {
        didSet {
            
        }
    }
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "avatar")
        return imageView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 24.dp)
        label.text = HomeController.login
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = "test@gmail.com"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(iconImageView)
        self.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        
        self.addConstraintsWithFormat("H:|-\(17.dp)-[v0(\(72.dp))]-\(16.dp)-[v1]|", views: iconImageView, contentView)
        contentView.addConstraintsWithFormat("H:|[v0]", views: nameLabel)
        contentView.addConstraintsWithFormat("H:|[v0]", views: emailLabel)
        
        self.addConstraintsWithFormat("V:[v0(\(72.dp))]", views: iconImageView)
        self.addConstraintsWithFormat("V:[v0(\(54.dp))]", views: contentView)
        contentView.addConstraintsWithFormat("V:|[v0]-\(6.dp)-[v1]", views: nameLabel, emailLabel)
        
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

class ProfileRowView: UIView {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "arrow")
        return imageView
    }()
    
    let seperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(226, green: 226, blue: 226)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        self.addSubview(arrowImageView)
        self.addSubview(seperateView)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0(\(24.dp))]-\(12.dp)-[v1][v2(\(10.dp))]-\(20.dp)-|", views: iconImageView, titleLabel, arrowImageView)
        self.addConstraintsWithFormat("H:|-\(56.dp)-[v0]-\(20.dp)-|", views: seperateView)
        
        self.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: iconImageView)
        self.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        self.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: arrowImageView)
        self.addConstraintsWithFormat("V:[v0(\(1.dp))]|", views: seperateView)
        
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

class ProfileRowFonView: UIView {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
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
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        self.addSubview(arrowImageView)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0(\(24.dp))]-\(12.dp)-[v1][v2(\(10.dp))]-\(20.dp)-|", views: iconImageView, titleLabel, arrowImageView)
        
        self.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: iconImageView)
        self.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        self.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: arrowImageView)
        
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
