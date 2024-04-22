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
        self.homeController?.openCompanyInfoController()
    }
    
    @objc func aboutProfileRowViewPress() {
        self.homeController?.openAboutController()
    }
    
    @objc func settingProfileRowViewPress() {
        self.homeController?.openSettingsController()
    }
}

