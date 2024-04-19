//
//  AlarmDetailController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 26/07/23.
//

import UIKit
import Lottie

class AlarmDetailController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    var alarm: Alarm? {
        didSet {
            self.alarmDetailBasicView.alarm = alarm
            self.causeAlarmDetailTextView.valueLabel.text = alarm?.alarmCause ?? ""
            self.suggestionsAlarmDetailTextView.valueLabel.text = alarm?.repairSuggestion ?? ""
        }
    }
    
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
        label.text = NSLocalizedString("alarm_details", comment: "")
        return label
    }()
    //
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    
    let alarmDetailBasicView: AlarmDetailBasicView = {
        let view = AlarmDetailBasicView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let causeAlarmDetailTextView: AlarmDetailTextView = {
        let view = AlarmDetailTextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("alarm_сause", comment: "")
        return view
    }()
    
    let suggestionsAlarmDetailTextView: AlarmDetailTextView = {
        let view = AlarmDetailTextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("suggestions", comment: "")
        return view
    }()
    
    lazy var alarmContactView: AlarmContactView = {
        let view = AlarmContactView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alarmDetailController = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupHeadeView()
        self.setupContentScrollView()
    }
    
    func setupView() {
        self.view.addSubview(headeView)
        self.view.addSubview(contentScrollView)
        
        self.view.addConstraintsWithFormat("H:|-\(8.dp)-[v0]-\(24.dp)-|", views: headeView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: contentScrollView)
        
        self.view.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: headeView)
        
        contentScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        headeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6.dp).isActive = true
        contentScrollView.topAnchor.constraint(equalTo: headeView.bottomAnchor, constant: 16.dp).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
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
    
    func setupContentScrollView() {
        contentScrollView.addSubview(alarmDetailBasicView)
        contentScrollView.addSubview(causeAlarmDetailTextView)
        contentScrollView.addSubview(suggestionsAlarmDetailTextView)
        contentScrollView.addSubview(alarmContactView)
        
        let screenWidth = UIScreen.main.bounds.width - 30
        contentScrollView.addConstraintsWithFormat("H:[v0(\(screenWidth))]", views: alarmDetailBasicView)
        contentScrollView.addConstraintsWithFormat("H:[v0(\(screenWidth))]", views: causeAlarmDetailTextView)
        contentScrollView.addConstraintsWithFormat("H:[v0(\(screenWidth))]", views: suggestionsAlarmDetailTextView)
        contentScrollView.addConstraintsWithFormat("H:[v0(\(screenWidth))]", views: alarmContactView)
        
        contentScrollView.addConstraintsWithFormat("V:[v0(\(173.dp))]", views: alarmContactView)
        
        let alarmName = self.alarm?.alarmName ?? ""
        let plantName = self.alarm?.stationName ?? ""
        let alarmDetailBasicViewHeight = 24.dp + self.getHeight(text: alarmName, font: UIFont.boldSystemFont(ofSize: 16.dp), width: 286.dp) + 24.dp + self.getHeight(text: plantName, font: UIFont.systemFont(ofSize: 14.dp), width: 180.dp) + 168.dp + 24.dp
        contentScrollView.addConstraintsWithFormat("V:[v0(\(alarmDetailBasicViewHeight))]", views: alarmDetailBasicView)
        
        let alarmCause = self.alarm?.alarmCause ?? ""
        let causeAlarmDetailTextViewHeight = 24.dp + 12.dp + 16.dp + self.getHeight(text: alarmCause, font: UIFont.systemFont(ofSize: 14.dp), width: 320.dp) + 24.dp
        contentScrollView.addConstraintsWithFormat("V:[v0(\(causeAlarmDetailTextViewHeight))]", views: causeAlarmDetailTextView)
        
        let repairSuggestion = self.alarm?.repairSuggestion ?? ""
        let suggestionsAlarmDetailTextViewHeight = 24.dp + 12.dp + 16.dp + self.getHeight(text: repairSuggestion, font: UIFont.systemFont(ofSize: 14.dp), width: 320.dp) + 24.dp
        contentScrollView.addConstraintsWithFormat("V:[v0(\(suggestionsAlarmDetailTextViewHeight))]", views: suggestionsAlarmDetailTextView)
        
        alarmDetailBasicView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        causeAlarmDetailTextView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        suggestionsAlarmDetailTextView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        alarmContactView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        
        alarmDetailBasicView.topAnchor.constraint(equalTo: contentScrollView.topAnchor).isActive = true
        causeAlarmDetailTextView.topAnchor.constraint(equalTo: alarmDetailBasicView.bottomAnchor, constant: 16.dp).isActive = true
        suggestionsAlarmDetailTextView.topAnchor.constraint(equalTo: causeAlarmDetailTextView.bottomAnchor, constant: 16.dp).isActive = true
        alarmContactView.topAnchor.constraint(equalTo: suggestionsAlarmDetailTextView.bottomAnchor, constant: 16.dp).isActive = true
         
        let scrollViewHeight = alarmDetailBasicViewHeight + 16.dp + causeAlarmDetailTextViewHeight + 16.dp + suggestionsAlarmDetailTextViewHeight + 16.dp + 173.dp + 24.dp
        self.contentScrollView.contentSize = CGSize(width: 390.dp, height: scrollViewHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    func getHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let dummySize = CGSize(width: width, height: 1000000.dp)
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let rect = descAttributedText(name: text, font: font).boundingRect(with: dummySize, options: options, context: nil)
        return rect.height
    }
    
    fileprivate func descAttributedText(name: String?, font: UIFont) -> NSAttributedString {
        let text = name
        let attrs:[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font: font]
        let normal = NSMutableAttributedString(string: text!, attributes:attrs)
        return normal
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
}


