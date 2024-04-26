//
//  BasicInfoController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 27/07/23.
//

import UIKit

class BasicInfoController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    var station: Station? {
        didSet {
            self.titleLabel.text = station?.plantName ?? ""
            self.addressBasicInfoAddressView.valueLabel.text = station?.plantAddress ?? ""
            self.personBasicInfoSmallView.valueLabel.text = station?.contactPerson ?? ""
            self.methodBasicInfoSmallView.valueLabel.text = station?.contactMethod ?? ""
            self.countryBasicInfoSmallView.valueLabel.text = "Uzbekistan"
            self.providerBasicInfoSmallView.valueLabel.text = ""
            self.capacityBasicInfoSmallView.valueLabel.text = "\((station?.capacity ?? 0.0).rounded(toPlaces: 2))"
            self.chargingBasicInfoSmallView.valueLabel.text = "No"
           
            if let gridConnectionDate = station?.gridConnectionDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                if let date = dateFormatter.date(from: gridConnectionDate) {
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    self.connectionBasicInfoSmallView.valueLabel.text = "\(dateFormatter.string(from: date))"
                    self.startBasicInfoSmallView.valueLabel.text = "\(dateFormatter.string(from: date))"
                }
            }
        }
    }
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "main_image")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let whiteTopView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.4
        return view
    }()
    
    //headerView
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "back_white")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16.dp)
        label.numberOfLines = 0
        return label
    }()
    //
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.bounces = false
        return scrollView
    }()
    
    let emptyBlockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(241, green: 243, blue: 245)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 32.dp
        return view
    }()
    
    //topView
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let countryBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("country_region", comment: "")
        return view
    }()
    
    let providerBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("service_provider", comment: "")
        return view
    }()
    
    let typeBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("plant_type", comment: "")
        return view
    }()
    
    let chargingBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("charging_only_plant", comment: "")
        return view
    }()
    
    let capacityBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("total_string_capacity", comment: "")
        return view
    }()
    
    let connectionBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("grid_connection_date", comment: "")
        return view
    }()
    
    let startBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("start_date_of_safe_running", comment: "")
        view.seperateView.isHidden = true
        return view
    }()
    //
    
    //center1View
    let center1View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let addressBasicInfoAddressView: BasicInfoAddressView = {
        let view = BasicInfoAddressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("basic_plant_address", comment: "")
        return view
    }()
    
    let timeZoneBasicInfoLargeView: BasicInfoLargeView = {
        let view = BasicInfoLargeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("plant_time_zone", comment: "")
        view.seperateView.isHidden = true
        return view
    }()
    //
    
    //center2View
    let center2View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let personBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("contact_person", comment: "")
        return view
    }()
    
    let methodBasicInfoSmallView: BasicInfoSmallView = {
        let view = BasicInfoSmallView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("contact_method", comment: "")
        view.seperateView.isHidden = true
        return view
    }()
    //
    
    //bottomView
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let plantOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = NSLocalizedString("plant_overview", comment: "")
        return label
    }()
    
    let grayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(241, green: 243, blue: 245)
        view.layer.cornerRadius = 5.dp
        return view
    }()
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupHeaderView()
        self.setupContentScrollView()
        self.setupContentView()
        self.setupTopView()
        self.setupCenter1View()
        self.setupCenter2View()
        self.setupBottomView()
    }
    
    func setupView() {
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(whiteTopView)
        self.view.addSubview(headerView)
        self.view.addSubview(contentScrollView)
        
        self.view.addConstraintsWithFormat("H:|[v0]|", views: backgroundImageView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: whiteTopView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: headerView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: contentScrollView)
        
        self.view.addConstraintsWithFormat("V:|[v0(\(399.dp))]", views: backgroundImageView)
        self.view.addConstraintsWithFormat("V:|[v0(\(70.dp + HomeController.topPadding))]", views: whiteTopView)
        self.view.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: headerView)
        
        contentScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6.dp).isActive = true
        contentScrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16.dp).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setupHeaderView() {
        headerView.addSubview(backButton)
        headerView.addSubview(titleLabel)
        
        headerView.addConstraintsWithFormat("H:|-\(11.dp)-[v0(\(46.dp))][v1]-\(20.dp)-|", views: backButton, titleLabel)
        
        headerView.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: backButton)
        headerView.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        
        backButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        backButton.addTarget(self, action: #selector(self.backButtonPress), for: .touchUpInside)
    }
    
    @objc func backButtonPress() {
        self.dismiss(animated: true)
    }
    
    func setupContentScrollView() {
        contentScrollView.addSubview(emptyBlockView)
        contentScrollView.addSubview(contentView)

        let screenWidth = UIScreen.main.bounds.width
        
        contentScrollView.addConstraintsWithFormat("H:[v0(\(screenWidth))]", views: emptyBlockView)
        contentScrollView.addConstraintsWithFormat("H:[v0(\(screenWidth))]", views: contentView)

        contentScrollView.addConstraintsWithFormat("V:[v0(\(190.dp))]", views: emptyBlockView)
        contentScrollView.addConstraintsWithFormat("V:[v0(\(1572.dp))]", views: contentView)
        
        emptyBlockView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        
        emptyBlockView.topAnchor.constraint(equalTo: contentScrollView.topAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: emptyBlockView.bottomAnchor).isActive = true

        let scrollViewHeight = 190.dp + 972.dp
        self.contentScrollView.contentSize = CGSize(width: screenWidth, height: scrollViewHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    func setupContentView() {
        contentView.addSubview(topView)
        contentView.addSubview(center1View)
        contentView.addSubview(center2View)
        contentView.addSubview(bottomView)
        
        contentView.addConstraintsWithFormat("H:|[v0]|", views: topView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: center1View)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: center2View)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: bottomView)
        
        contentView.addConstraintsWithFormat("V:|[v0(\(466.dp))]-\(12.dp)-[v1(\(166.dp))]-\(12.dp)-[v2(\(130.dp))]-\(12.dp)-[v3(\(1093.dp))]", views: topView, center1View, center2View, bottomView)
    }
    
    func setupTopView() {
        topView.addSubview(countryBasicInfoSmallView)
        topView.addSubview(providerBasicInfoSmallView)
        topView.addSubview(typeBasicInfoSmallView)
        topView.addSubview(chargingBasicInfoSmallView)
        topView.addSubview(capacityBasicInfoSmallView)
        topView.addSubview(connectionBasicInfoSmallView)
        topView.addSubview(startBasicInfoSmallView)
        
        topView.addConstraintsWithFormat("H:|[v0]|", views: countryBasicInfoSmallView)
        topView.addConstraintsWithFormat("H:|[v0]|", views: providerBasicInfoSmallView)
        topView.addConstraintsWithFormat("H:|[v0]|", views: typeBasicInfoSmallView)
        topView.addConstraintsWithFormat("H:|[v0]|", views: chargingBasicInfoSmallView)
        topView.addConstraintsWithFormat("H:|[v0]|", views: capacityBasicInfoSmallView)
        topView.addConstraintsWithFormat("H:|[v0]|", views: connectionBasicInfoSmallView)
        topView.addConstraintsWithFormat("H:|[v0]|", views: startBasicInfoSmallView)
        
        topView.addConstraintsWithFormat("V:|-\(11.dp)-[v0(\(65.dp))][v1(\(65.dp))][v2(\(65.dp))][v3(\(65.dp))][v4(\(65.dp))][v5(\(65.dp))][v6(\(65.dp))]", views: countryBasicInfoSmallView, providerBasicInfoSmallView, typeBasicInfoSmallView, chargingBasicInfoSmallView, capacityBasicInfoSmallView, connectionBasicInfoSmallView, startBasicInfoSmallView)
    }
    
    func setupCenter1View() {
        center1View.addSubview(addressBasicInfoAddressView)
        center1View.addSubview(timeZoneBasicInfoLargeView)
        
        center1View.addConstraintsWithFormat("H:|[v0]|", views: addressBasicInfoAddressView)
        center1View.addConstraintsWithFormat("H:|[v0]|", views: timeZoneBasicInfoLargeView)
        
        center1View.addConstraintsWithFormat("V:|[v0(\(83.dp))][v1(\(83.dp))]", views: addressBasicInfoAddressView, timeZoneBasicInfoLargeView)
        
        addressBasicInfoAddressView.directionButton.addTarget(self, action: #selector(self.directionButtonPress), for: .touchUpInside)
    }
    
    @objc func directionButtonPress() {
        self.openApp(appName: "", longitude: 41.3158263, latitude: 69.2758336)
    }
    
    func openApp(appName:String, longitude: Double, latitude: Double) {
           let appScheme = "yandexnavi://"
           let appUrl = URL(string: appScheme)
           if UIApplication.shared.canOpenURL(appUrl! as URL)
           {
               let url = "yandexnavi://build_route_on_map?lat_to=\(latitude)&lon_to=\(longitude)"
               UIApplication.shared.openURL(URL(string:url)!)
           } else {
               print("App not installed")
               let url = "http://maps.apple.com/maps?daddr=\(latitude),\(longitude)"
               UIApplication.shared.openURL(URL(string:url)!)
           }
    }
    
    func setupCenter2View() {
        center2View.addSubview(personBasicInfoSmallView)
        center2View.addSubview(methodBasicInfoSmallView)
        
        center2View.addConstraintsWithFormat("H:|[v0]|", views: personBasicInfoSmallView)
        center2View.addConstraintsWithFormat("H:|[v0]|", views: methodBasicInfoSmallView)
        
        center2View.addConstraintsWithFormat("V:|[v0(\(65.dp))][v1(\(65.dp))]", views: personBasicInfoSmallView, methodBasicInfoSmallView)
    }
    
    func setupBottomView() {
        bottomView.addSubview(plantOverviewLabel)
        bottomView.addSubview(grayView)
        
        bottomView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]", views: plantOverviewLabel)
        bottomView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: grayView)
        
        bottomView.addConstraintsWithFormat("V:|-\(26.dp)-[v0]-\(17.dp)-[v1(\(93.dp))]", views: plantOverviewLabel, grayView)
    }
}

