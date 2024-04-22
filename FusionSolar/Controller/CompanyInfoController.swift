//
//  CompanyInfoController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 22/04/24.
//

import UIKit

class CompanyInfoController: UIViewController {
    
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
        label.text = NSLocalizedString("company_info", comment: "")
        return label
    }()
    //
    
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16.dp
        return view
    }()
    
    let companyNameBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("company_name", comment: "")
        return view
    }()
    
    let contactMethodBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("contact_method", comment: "")
        return view
    }()
    
    let addressBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("address", comment: "")
        return view
    }()
    
    let websiteBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("website", comment: "")
        return view
    }()
    
    let recordNumberBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("record_number", comment: "")
        view.seperateView.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupHeaderView()
        self.setupBorderView()
        
        self.initView()
    }
    
    func initView() {
        companyNameBasicInfoSmallView.valueLabel.text = HomeController.profile?.company_name ?? ""
        contactMethodBasicInfoSmallView.valueLabel.text = "--"
        addressBasicInfoSmallView.valueLabel.text = "--"
        websiteBasicInfoSmallView.valueLabel.text = "--"
        recordNumberBasicInfoSmallView.valueLabel.text = "--"
    }
    
    func setupView() {
        self.view.addSubview(headeView)
        self.view.addSubview(borderView)
        
        self.view.addConstraintsWithFormat("H:|-\(8.dp)-[v0]-\(24.dp)-|", views: headeView)
        self.view.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: borderView)
        
        self.view.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: headeView)
        self.view.addConstraintsWithFormat("V:[v0(\(275.dp))]", views: borderView)
        
        borderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        headeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6.dp).isActive = true
        borderView.topAnchor.constraint(equalTo: headeView.bottomAnchor, constant: 24.dp).isActive = true
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
    
    func setupBorderView() {
        borderView.addSubview(companyNameBasicInfoSmallView)
        borderView.addSubview(contactMethodBasicInfoSmallView)
        borderView.addSubview(addressBasicInfoSmallView)
        borderView.addSubview(websiteBasicInfoSmallView)
        borderView.addSubview(recordNumberBasicInfoSmallView)
        
        borderView.addConstraintsWithFormat("H:|[v0]|", views: companyNameBasicInfoSmallView)
        borderView.addConstraintsWithFormat("H:|[v0]|", views: contactMethodBasicInfoSmallView)
        borderView.addConstraintsWithFormat("H:|[v0]|", views: addressBasicInfoSmallView)
        borderView.addConstraintsWithFormat("H:|[v0]|", views: websiteBasicInfoSmallView)
        borderView.addConstraintsWithFormat("H:|[v0]|", views: recordNumberBasicInfoSmallView)
        
        borderView.addConstraintsWithFormat("V:|-\(16.dp)-[v0(\(48.dp))][v1(\(48.dp))][v2(\(48.dp))][v3(\(48.dp))][v4(\(48.dp))]", views: companyNameBasicInfoSmallView, contactMethodBasicInfoSmallView, addressBasicInfoSmallView, websiteBasicInfoSmallView, recordNumberBasicInfoSmallView)
    }
}
