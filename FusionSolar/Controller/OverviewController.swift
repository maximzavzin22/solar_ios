//
//  OverviewController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 27/07/23.
//

import UIKit

class OverviewController: UIViewController {
    
    var station: Station? {
        didSet {
            self.titleLabel.text = station?.plantName ?? ""
            
        }
    }
    
    var currentPage: Int? {
        didSet {
            if let value = currentPage {
                if(value == 0) {
                    overviewView.isHidden = false
                    stationStatisticsView.isHidden = true
                    stationLayotView.isHidden = true
                    stationDevicesView.isHidden = true
                }
                if(value == 1) {
                    overviewView.isHidden = true
                    stationStatisticsView.isHidden = false
                    stationLayotView.isHidden = true
                    stationDevicesView.isHidden = true
                }
                if(value == 2) {
                    overviewView.isHidden = true
                    stationStatisticsView.isHidden = true
                    stationLayotView.isHidden = false
                    stationDevicesView.isHidden = true
                }
                if(value == 3) {
                    overviewView.isHidden = true
                    stationStatisticsView.isHidden = true
                    stationLayotView.isHidden = true
                    stationDevicesView.isHidden = false
                    stationDevicesView.generateDevices()
                }
            }
        }
    }
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var menuBar: OverviewMenuBar = {
        let mb = OverviewMenuBar()
        mb.overviewController = self
        return mb
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
        let image = UIImage(named: "back")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        label.numberOfLines = 0
        return label
    }()
    //
    
    lazy var overviewView: OverviewView = {
        let view = OverviewView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.overviewController = self
        return view
    }()
    
    lazy var stationStatisticsView: StationStatisticsView = {
        let view = StationStatisticsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.overviewController = self
        return view
    }()
    
    lazy var stationLayotView: StationLayotView = {
        let view = StationLayotView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.overviewController = self
        return view
    }()
    
    lazy var stationDevicesView: StationDevicesView = {
        let view = StationDevicesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.overviewController = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupContentView()
        self.setupHeaderView()
    }
    
    func setupView() {
        self.view.addSubview(contentView)
        self.view.addSubview(menuBar)
        self.view.addSubview(headerView)
        
        self.view.addConstraintsWithFormat("H:|[v0]|", views: contentView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: headerView)
        
        self.view.addConstraintsWithFormat("V:[v0(\(66.dp))]", views: menuBar)
        self.view.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: headerView)
        
        contentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.menuBar.topAnchor).isActive = true
        menuBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6.dp).isActive = true
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
    
    func setupContentView() {
        contentView.addSubview(overviewView)
        contentView.addSubview(stationStatisticsView)
        contentView.addSubview(stationLayotView)
        contentView.addSubview(stationDevicesView)
        
        contentView.addConstraintsWithFormat("H:|[v0]|", views: overviewView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: stationStatisticsView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: stationLayotView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: stationDevicesView)
        
        contentView.addConstraintsWithFormat("V:|[v0]|", views: overviewView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: stationStatisticsView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: stationLayotView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: stationDevicesView)
        
        stationStatisticsView.isHidden = true
        stationLayotView.isHidden = true
        stationDevicesView.isHidden = true
        
        overviewView.generateKpi()
    }
    
    func openAlarmDetailController(alarm: Alarm) {
        let alarmDetailController = AlarmDetailController()
        alarmDetailController.modalPresentationStyle = .fullScreen
        alarmDetailController.alarm = alarm
        self.present(alarmDetailController, animated: true)
    }
}
