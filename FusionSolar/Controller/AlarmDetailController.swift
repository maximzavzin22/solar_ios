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
        self.view.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: contentScrollView)
        
        self.view.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: headeView)
        
        contentScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        headeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6.dp).isActive = true
        contentScrollView.topAnchor.constraint(equalTo: headeView.bottomAnchor, constant: 16.dp).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setupHeadeView() {
        headeView.addSubview(backButton)
        headeView.addSubview(titleLabel)
        
        headeView.addConstraintsWithFormat("H:|[v0(\(46.dp))][v1]|", views: backButton, titleLabel)
        
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
        
        contentScrollView.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: alarmDetailBasicView)
        contentScrollView.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: causeAlarmDetailTextView)
        contentScrollView.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: suggestionsAlarmDetailTextView)
        
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
        
        alarmDetailBasicView.topAnchor.constraint(equalTo: contentScrollView.topAnchor).isActive = true
        causeAlarmDetailTextView.topAnchor.constraint(equalTo: alarmDetailBasicView.bottomAnchor, constant: 16.dp).isActive = true
        suggestionsAlarmDetailTextView.topAnchor.constraint(equalTo: causeAlarmDetailTextView.bottomAnchor, constant: 16.dp).isActive = true
         
        let scrollViewHeight = alarmDetailBasicViewHeight + 16.dp + causeAlarmDetailTextViewHeight + 16.dp + suggestionsAlarmDetailTextViewHeight
        self.contentScrollView.contentSize = CGSize(width: 360.dp, height: scrollViewHeight)
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
}

class AlarmDetailBasicView: UIView {
    
    var alarm: Alarm? {
        didSet {
            if let lev = alarm?.lev {
                if(lev == 1) {
                    animationView.animation = LottieAnimation.named("alarm pink")
                    severityValueLabel.text = NSLocalizedString("critical", comment: "")
                }
                if(lev == 2) {
                    animationView.animation = LottieAnimation.named("alarm orange")
                    severityValueLabel.text = NSLocalizedString("major", comment: "")
                }
                if(lev == 3) {
                    animationView.animation = LottieAnimation.named("alarm yellow")
                    severityValueLabel.text = NSLocalizedString("minor", comment: "")
                }
                if(lev == 4) {
                    animationView.animation = LottieAnimation.named("alarm warning")
                    severityValueLabel.text = NSLocalizedString("warning", comment: "")
                }
                animationView.play()
            }
            nameLabel.text = alarm?.alarmName ?? ""
            plantValueLabel.text = alarm?.stationName ?? ""
            statusValueLabel.text = NSLocalizedString("unacked", comment: "")
            idValueLabel.text = "\(alarm?.alarmId ?? 0)"
            causeIdValueLabel.text = "\(alarm?.causeId ?? 0)"
            devNameValueLabel.text = alarm?.devName ?? ""
            if let devTypeId = alarm?.devTypeId {
                if(devTypeId == 1) {
                    devTypeValueLabel.text = NSLocalizedString("inverter", comment: "")
                } else {
                    devTypeValueLabel.text = NSLocalizedString("dongle", comment: "")
                }
            }
            if let milliseconds = alarm?.raiseTime {
                let date = Date(milliseconds: milliseconds)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                dateValueLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
    let animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.animationSpeed = 0.7
        view.loopMode = .loop
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 16.dp)
        return label
    }()
    
    //textsContentView
    let textsContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let plantTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("alarm_plant_name", comment: "")
        return label
    }()
    
    let plantValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let severityTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("alarm_severity", comment: "")
        return label
    }()
    
    let severityValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let statusTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("alarm_status", comment: "")
        return label
    }()
    
    let statusValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let idTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("alarm_id", comment: "")
        return label
    }()
    
    let idValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let causeIdTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("alarm_cause_id", comment: "")
        return label
    }()
    
    let causeIdValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let devNameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("alarm_device_name", comment: "")
        return label
    }()
    
    let devNameValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let devTypeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("alarm_device_type", comment: "")
        return label
    }()
    
    let devTypeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    
    let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = NSLocalizedString("alarm_occurrence_time", comment: "")
        return label
    }()
    
    let dateValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 14.dp)
        label.text = "-"
        return label
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp

        self.setupView()
        self.setupTextsContentView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(animationView)
        self.addSubview(nameLabel)
        self.addSubview(textsContentView)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0(\(24.dp))]-\(10.dp)-[v1]-\(20.dp)-|", views: animationView, nameLabel)
        self.addConstraintsWithFormat("H:[v0(\(320.dp))]", views: textsContentView)
        
        self.addConstraintsWithFormat("V:[v0(\(20.dp))]", views: animationView)
        self.addConstraintsWithFormat("V:|-\(24.dp)-[v0]-\(24.dp)-[v1]|", views: nameLabel, textsContentView)
        
        textsContentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        animationView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    }
    
    func setupTextsContentView() {
        textsContentView.addSubview(plantTitleLabel)
        textsContentView.addSubview(plantValueLabel)
        textsContentView.addSubview(severityTitleLabel)
        textsContentView.addSubview(severityValueLabel)
        textsContentView.addSubview(statusTitleLabel)
        textsContentView.addSubview(statusValueLabel)
        textsContentView.addSubview(idTitleLabel)
        textsContentView.addSubview(idValueLabel)
        textsContentView.addSubview(causeIdTitleLabel)
        textsContentView.addSubview(causeIdValueLabel)
        textsContentView.addSubview(devNameTitleLabel)
        textsContentView.addSubview(devNameValueLabel)
        textsContentView.addSubview(devTypeTitleLabel)
        textsContentView.addSubview(devTypeValueLabel)
        textsContentView.addSubview(dateTitleLabel)
        textsContentView.addSubview(dateValueLabel)
        
        
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: plantTitleLabel, plantValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: severityTitleLabel, severityValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: statusTitleLabel, statusValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: idTitleLabel, idValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: causeIdTitleLabel, causeIdValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: devNameTitleLabel, devNameValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: devTypeTitleLabel, devTypeValueLabel)
        textsContentView.addConstraintsWithFormat("H:|[v0(\(140.dp))]-\(8.dp)-[v1]|", views: dateTitleLabel, dateValueLabel)
        
        textsContentView.addConstraintsWithFormat("V:[v0]", views: plantTitleLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: plantValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: severityTitleLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: severityValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: statusTitleLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: statusValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: idTitleLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: idValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: causeIdTitleLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: causeIdValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: devNameTitleLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: devNameValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: devTypeTitleLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: devTypeValueLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: dateTitleLabel)
        textsContentView.addConstraintsWithFormat("V:[v0]", views: dateValueLabel)
        
        plantTitleLabel.topAnchor.constraint(equalTo: textsContentView.topAnchor).isActive = true
        plantValueLabel.topAnchor.constraint(equalTo: textsContentView.topAnchor).isActive = true
        severityTitleLabel.topAnchor.constraint(equalTo: plantValueLabel.bottomAnchor, constant: 8.dp).isActive = true
        severityValueLabel.topAnchor.constraint(equalTo: plantValueLabel.bottomAnchor, constant: 8.dp).isActive = true
        statusTitleLabel.topAnchor.constraint(equalTo: severityTitleLabel.bottomAnchor, constant: 8.dp).isActive = true
        statusValueLabel.topAnchor.constraint(equalTo: severityTitleLabel.bottomAnchor, constant: 8.dp).isActive = true
        idTitleLabel.topAnchor.constraint(equalTo: statusTitleLabel.bottomAnchor, constant: 8.dp).isActive = true
        idValueLabel.topAnchor.constraint(equalTo: statusTitleLabel.bottomAnchor, constant: 8.dp).isActive = true
        causeIdTitleLabel.topAnchor.constraint(equalTo: idTitleLabel.bottomAnchor, constant: 8.dp).isActive = true
        causeIdValueLabel.topAnchor.constraint(equalTo: idTitleLabel.bottomAnchor, constant: 8.dp).isActive = true
        devNameTitleLabel.topAnchor.constraint(equalTo: causeIdTitleLabel.bottomAnchor, constant: 8.dp).isActive = true
        devNameValueLabel.topAnchor.constraint(equalTo: causeIdTitleLabel.bottomAnchor, constant: 8.dp).isActive = true
        devTypeTitleLabel.topAnchor.constraint(equalTo: devNameTitleLabel.bottomAnchor, constant: 8.dp).isActive = true
        devTypeValueLabel.topAnchor.constraint(equalTo: devNameTitleLabel.bottomAnchor, constant: 8.dp).isActive = true
        dateTitleLabel.topAnchor.constraint(equalTo: devTypeTitleLabel.bottomAnchor, constant: 8.dp).isActive = true
        dateValueLabel.topAnchor.constraint(equalTo: devTypeTitleLabel.bottomAnchor, constant: 8.dp).isActive = true
    }
}

class AlarmDetailTextView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.dp)
        label.textColor = .rgb(1, green: 6, blue: 10)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.dp)
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp

        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(titleLabel)
        self.addSubview(valueLabel)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(20.dp)-|", views: titleLabel)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(20.dp)-|", views: valueLabel)
        
        self.addConstraintsWithFormat("V:|-\(24.dp)-[v0]-\(8.dp)-[v1]", views: titleLabel, valueLabel)
    }
}
