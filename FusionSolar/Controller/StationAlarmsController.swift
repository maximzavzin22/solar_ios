//
//  StationAlarmsController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 23/04/24.
//

import UIKit

class StationAlarmsController: UIViewController {
    
    var alarms: [Alarm]? {
        didSet {
            alarmsView.alarms = alarms
        }
    }
    
    let whiteTopView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
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
        label.text = NSLocalizedString("alarms", comment: "")
        return label
    }()
    //
    
    lazy var alarmsView: AlarmsView = {
        let view = AlarmsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.stationAlarmsController = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupHeaderView()
        
        self.setupToolbar()
    }
    
    func setupView() {
        self.view.addSubview(whiteTopView)
        self.view.addSubview(headeView)
        self.view.addSubview(alarmsView)
        
        self.view.addConstraintsWithFormat("H:|[v0]|", views: whiteTopView)
        self.view.addConstraintsWithFormat("H:|-\(8.dp)-[v0]-\(24.dp)-|", views: headeView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: alarmsView)
        
        self.view.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: headeView)
        
        headeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6.dp).isActive = true
        whiteTopView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        whiteTopView.bottomAnchor.constraint(equalTo: headeView.bottomAnchor).isActive = true
        alarmsView.topAnchor.constraint(equalTo: headeView.bottomAnchor).isActive = true
        alarmsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
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
    
    func openAlarmDetailController(alarm: Alarm) {
        let alarmDetailController = AlarmDetailController()
        alarmDetailController.modalPresentationStyle = .fullScreen
        alarmDetailController.alarm = alarm
        self.present(alarmDetailController, animated: true)
    }
    
    //keyboard
    func setupToolbar() {
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30.dp))
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: .done, target: self, action: #selector(self.doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()

        self.alarmsView.alarmSearchView.searchTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    //
}
