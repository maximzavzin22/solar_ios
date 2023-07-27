//
//  StationDevicesView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 27/07/23.
//

import UIKit

class StationDevicesView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var overviewController: OverviewController?
    
    var devices: [Device]? {
        didSet {
            if let count = self.devices?.count {
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
        return self.devices?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let device = self.devices?[index]
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
        let devTypeId = self.devices?[index].devTypeId ?? 0
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
    
    func generateDevices() {
        var devices = [Device]()
        
        var device1 = Device()
        device1.id = -214543629611879
        device1.devName = "5fbfk4"
        device1.stationCode = "5D02E8B40AD342159AC8D8A2BCD4FAB5"
        device1.esnCode = "5fbfk4"
        device1.devTypeId = 1
        device1.softwareVersion = "V100R001PC666"
        device1.invType = "SUN2000-17KTL"
        device1.longitude = 0
        device1.latitude = 0
        devices.append(device1)
        
        var device2 = Device()
        device2.id = -214543629611879
        device2.devName = "5fbfk4"
        device2.stationCode = "5D02E8B40AD342159AC8D8A2BCD4FAB5"
        device2.esnCode = "5fbfk4"
        device2.devTypeId = 62
        device2.softwareVersion = "V100R001PC666"
        device2.invType = "SUN2000-17KTL"
        device2.longitude = 0
        device2.latitude = 0
        devices.append(device2)
        
        var device3 = Device()
        device3.id = -214543629611879
        device3.devName = "5fbfk4"
        device3.stationCode = "5D02E8B40AD342159AC8D8A2BCD4FAB5"
        device3.esnCode = "5fbfk4"
        device3.devTypeId = 1
        device3.softwareVersion = "V100R001PC666"
        device3.invType = "SUN2000-17KTL"
        device3.longitude = 0
        device3.latitude = 0
        devices.append(device3)
        
        self.devices = devices
    }
}

class StationDevicesNavigationView: UIView {
    
    var stationDevicesView: StationDevicesView?
    
    var selectePage: Int? {
        didSet {
            if((selectePage ?? 0) == 0) {
                allLabel.textColor = .rgb(39, green: 87, blue: 238)
                allSeperateView.isHidden = false

                inverterLabel.textColor = .rgb(106, green: 106, blue: 106)
                inverterSeperateView.isHidden = true
                
                dongleLabel.textColor = .rgb(106, green: 106, blue: 106)
                dongleSeperateView.isHidden = true
            }
            if((selectePage ?? 0) == 1) {
                inverterLabel.textColor = .rgb(39, green: 87, blue: 238)
                inverterSeperateView.isHidden = false

                allLabel.textColor = .rgb(106, green: 106, blue: 106)
                allSeperateView.isHidden = true
                
                dongleLabel.textColor = .rgb(106, green: 106, blue: 106)
                dongleSeperateView.isHidden = true
            }
            if((selectePage ?? 0) == 2) {
                dongleLabel.textColor = .rgb(39, green: 87, blue: 238)
                dongleSeperateView.isHidden = false

                inverterLabel.textColor = .rgb(106, green: 106, blue: 106)
                inverterSeperateView.isHidden = true
                
                allLabel.textColor = .rgb(106, green: 106, blue: 106)
                allSeperateView.isHidden = true
            }
        }
    }
    
    //allView
    var allViewWidth: CGFloat = 0.0
    let allView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let allLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.dp)
        label.text = NSLocalizedString("all", comment: "")
        label.textColor = .rgb(39, green: 87, blue: 238)
        return label
    }()
    
    let allSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(39, green: 87, blue: 238)
        return view
    }()
    //
    
    //inverterView
    var inverterViewWidth: CGFloat = 0.0
    let inverterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inverterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.dp)
        label.text = NSLocalizedString("inverter", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        return label
    }()
    
    let inverterSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(39, green: 87, blue: 238)
        return view
    }()
    //
    
    //dongleView
    var dongleViewWidth: CGFloat = 0.0
    let dongleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dongleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.dp)
        label.text = NSLocalizedString("dongle", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        return label
    }()
    
    let dongleSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(39, green: 87, blue: 238)
        return view
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupAllView()
        self.setupInverterView()
        self.setupDongleView()
        
        self.selectePage = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(allView)
        self.addSubview(inverterView)
        self.addSubview(dongleView)
        
        allViewWidth = self.getWidth(text: NSLocalizedString("all", comment: "")) + 5.dp
        inverterViewWidth = self.getWidth(text: NSLocalizedString("inverter", comment: "")) + 5.dp
        dongleViewWidth = self.getWidth(text: NSLocalizedString("dongle", comment: "")) + 5.dp
        
        print("allViewWidth \(allViewWidth)")
        print("inverterViewWidth \(inverterViewWidth)")
        print("dongleViewWidth \(dongleViewWidth)")
        
        self.addConstraintsWithFormat("H:[v0(\(allViewWidth))]", views: allView)
        self.addConstraintsWithFormat("H:[v0(\(inverterViewWidth))]", views: inverterView)
        self.addConstraintsWithFormat("H:[v0(\(dongleViewWidth))]", views: dongleView)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: allView)
        self.addConstraintsWithFormat("V:|[v0]|", views: inverterView)
        self.addConstraintsWithFormat("V:|[v0]|", views: dongleView)
        
        allView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        inverterView.leftAnchor.constraint(equalTo: allView.rightAnchor, constant: 26.dp).isActive = true
        dongleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        let allViewTap = UITapGestureRecognizer(target: self, action: #selector(self.allViewPress))
        allView.isUserInteractionEnabled = true
        allView.addGestureRecognizer(allViewTap)
        
        let inverterViewTap = UITapGestureRecognizer(target: self, action: #selector(self.inverterViewPress))
        inverterView.isUserInteractionEnabled = true
        inverterView.addGestureRecognizer(inverterViewTap)
        
        let dongleViewTap = UITapGestureRecognizer(target: self, action: #selector(self.dongleViewPress))
        dongleView.isUserInteractionEnabled = true
        dongleView.addGestureRecognizer(dongleViewTap)
    }
    
    @objc func allViewPress() {
        self.selectePage = 0
    }
    
    @objc func inverterViewPress() {
        self.selectePage = 1
    }
    
    @objc func dongleViewPress() {
        self.selectePage = 2
    }
    
    func setupAllView() {
        allView.addSubview(allLabel)
        allView.addSubview(allSeperateView)
        
        allView.addConstraintsWithFormat("H:|[v0]|", views: allLabel)
        allView.addConstraintsWithFormat("H:|[v0]|", views: allSeperateView)
        
        allView.addConstraintsWithFormat("V:|-\(10.dp)-[v0]-\(10.dp)-[v1(\(2.dp))]", views: allLabel, allSeperateView)
    }
    
    func setupInverterView() {
        inverterView.addSubview(inverterLabel)
        inverterView.addSubview(inverterSeperateView)
        
        inverterView.addConstraintsWithFormat("H:|[v0]|", views: inverterLabel)
        inverterView.addConstraintsWithFormat("H:|[v0]|", views: inverterSeperateView)
        
        inverterView.addConstraintsWithFormat("V:|-\(10.dp)-[v0]-\(10.dp)-[v1(\(2.dp))]", views: inverterLabel, inverterSeperateView)
    }
    
    func setupDongleView() {
        dongleView.addSubview(dongleLabel)
        dongleView.addSubview(dongleSeperateView)
        
        dongleView.addConstraintsWithFormat("H:|[v0]|", views: dongleLabel)
        dongleView.addConstraintsWithFormat("H:|[v0]|", views: dongleSeperateView)
        
        dongleView.addConstraintsWithFormat("V:|-\(10.dp)-[v0]-\(10.dp)-[v1(\(2.dp))]", views: dongleLabel, dongleSeperateView)
    }
    
    func getWidth(text: String) -> CGFloat {
        let dummySize = CGSize(width: 1000.dp, height: 21.dp)
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let rect = descAttributedText(name: text).boundingRect(with: dummySize, options: options, context: nil)
        return rect.width
    }
    
    fileprivate func descAttributedText(name: String?) -> NSAttributedString {
        let text = name
        let attrs:[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.dp)]
        let normal = NSMutableAttributedString(string: text!, attributes:attrs)
        return normal
    }
}
