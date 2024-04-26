//
//  DevicesView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit

class DevicesView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    
    var topSafeArea: CGFloat = 0.0
    
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
    
    var isFilter: Bool? {
        didSet {
            if(isFilter ?? false) {
                let image = UIImage(named: "filter_active")?.withRenderingMode(.alwaysOriginal)
                searchDevicesView.filterButton.setImage(image, for: .normal)
            } else {
                let image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal)
                searchDevicesView.filterButton.setImage(image, for: .normal)
            }
        }
    }
    
    //topView
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(241, green: 243, blue: 245)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("devices", comment: "")
        label.font = .boldSystemFont(ofSize: 24.dp)
        label.textColor = .rgb(1, green: 6, blue: 10)
        return label
    }()
    
   let searchDevicesView: SearchDevicesView = {
        let view = SearchDevicesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //
    
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
    
    lazy var deviceTypeSearchView: DeviceTypeSearchView = {
        let view = DeviceTypeSearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.devicesView = self
        return view
    }()
    
    let loadingView: LoadingView = {
        let lV = LoadingView()
        lV.translatesAutoresizingMaskIntoConstraints = false
        return lV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupTopView()
        self.setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(topView)
        self.addSubview(emptyView)
        self.addSubview(collectionView)
        self.addSubview(deviceTypeSearchView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topView)
        self.addConstraintsWithFormat("H:[v0(\(143.dp))]", views: emptyView)
        self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        self.addConstraintsWithFormat("H:|-\(35.dp)-[v0(\(170.dp))]", views: deviceTypeSearchView)
        
        self.addConstraintsWithFormat("V:|[v0(\(125.dp + HomeController.topPadding))]", views: topView)
        self.addConstraintsWithFormat("V:[v0(\(154.dp))]", views: emptyView)
        self.addConstraintsWithFormat("V:[v0(\(97.dp))]", views: deviceTypeSearchView)
        
        deviceTypeSearchView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8.dp).isActive = true
        deviceTypeSearchView.isHidden = true
        collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func showDeviceTypeSearchView() {
        deviceTypeSearchView.isHidden = false
    }
    
    func setupTopView() {
        topView.addSubview(titleLabel)
        topView.addSubview(searchDevicesView)
        
        topView.addConstraintsWithFormat("H:|-\(25.dp)-[v0]", views: titleLabel)
        topView.addConstraintsWithFormat("H:[v0(\(344.dp))]", views: searchDevicesView)
        
        topView.addConstraintsWithFormat("V:|-\(16.dp + topSafeArea)-[v0]-\(16.dp)-[v1(\(48.dp))]", views: titleLabel, searchDevicesView)
        
        searchDevicesView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        
        searchDevicesView.typeValue = "name"
        searchDevicesView.devicesView = self
    }
    
    //collectionView Setup
    func setupCollectionView() {
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
        if(device?.devTypeId ?? 0 == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deviceInverterCellViewId", for: indexPath) as! DeviceInverterCellView
            cell.device = device
            cell.status = "running"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deviceCellViewId", for: indexPath) as! DeviceCellView
            cell.device = device
            cell.status = "offline"
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
    //collectionView Setup end
}




