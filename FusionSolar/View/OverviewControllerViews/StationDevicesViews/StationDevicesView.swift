//
//  StationDevicesView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 27/07/23.
//

import UIKit

class StationDevicesView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var overviewController: OverviewController?
    
    var filter: String? {
        didSet {
            if let value = filter {
                if(value == "all") {
                    self.showDevices = devices
                } else {
                    var showDevices = [Device]()
                    if let devices = self.devices {
                        for device in devices {
                            if(device.devTypeId ?? 0 == 1) {
                                if(value == "inverter") {
                                    showDevices.append(device)
                                }
                            } else {
                                if(value == "dongle") {
                                    showDevices.append(device)
                                }
                            }
                        }
                    }
                    self.showDevices = showDevices
                }
            }
        }
    }
    
    var devices: [Device]? {
        didSet {
            self.showDevices = devices
        }
    }
    
    var showDevices: [Device]? {
        didSet {
            if let count = self.showDevices?.count {
                if(count > 0) {
                    emptyView.isHidden = true
                    collectionView.isHidden = false
                } else {
                    emptyView.isHidden = false
                    collectionView.isHidden = true
                }
            }
            self.collectionView.reloadData()
        }
    }
    
    lazy var navigationView: StationDevicesNavigationView = {
        let view = StationDevicesNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.stationDevicesView = self
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let emptyView: EmptyDataView = {
        let view = EmptyDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupCollectionView()
        
        self.navigationView.selectePage = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(navigationView)
        self.addSubview(emptyView)
        self.addSubview(collectionView)
        
        let width = navigationView.allViewWidth + 26.dp + navigationView.inverterViewWidth + 26.dp + navigationView.dongleViewWidth
        print("width \(width)")
        self.addConstraintsWithFormat("H:[v0(\(width))]", views: navigationView)
        self.addConstraintsWithFormat("H:[v0(\(143.dp))]", views: emptyView)
        self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        
        self.addConstraintsWithFormat("V:[v0(\(54.dp))]", views: navigationView)
        self.addConstraintsWithFormat("V:[v0(\(154.dp))]", views: emptyView)
        
        navigationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        navigationView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 70.dp).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 16.dp).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    //collectionView Setup
    func setupCollectionView() {
        print("setupCollectionView")
        collectionView.register(DeviceCellView.self, forCellWithReuseIdentifier: "deviceCellViewId")
        collectionView.register(DeviceInverterCellView.self, forCellWithReuseIdentifier: "deviceInverterCellViewId")
        collectionView.contentInset = UIEdgeInsets(top: 16.dp, left: 0, bottom: 16.dp, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 16.dp, left: 0, bottom: 16.dp, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.showDevices?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let device = self.showDevices?[index]
        var status = "running"
        if let alarms = self.overviewController?.station?.alarms {
            for alarm in alarms {
                if(alarm.devName ?? "" == device?.devName ?? "") {
                    status = "faulty"
                }
            }
        } else {
            if let statusValue = self.overviewController?.station?.stationRealKpi?.real_health_state {
                if(statusValue == 1) {
                    status = "offline"
                }
            }
        }
        
        if(device?.devTypeId ?? 0 == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deviceInverterCellViewId", for: indexPath) as! DeviceInverterCellView
            cell.device = device
            cell.status = status
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deviceCellViewId", for: indexPath) as! DeviceCellView
            cell.device = device
            cell.status = status
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let index = indexPath.item
        let devTypeId = self.showDevices?[index].devTypeId ?? 0
        if(devTypeId == 1) {
            return CGSize(width: collectionView.frame.width, height: 260.dp)
        } else {
            return CGSize(width: collectionView.frame.width, height: 202.dp)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.dp
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.dp
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Press")
        let index = indexPath.item
        
    }
    //collectionView Setup end
}


