//
//  AlarmsCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit

class AlarmsCellView: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var maintenanceView: MaintenanceView?
    
    var alarms: [Alarm]? {
        didSet {
            if let count = self.alarms?.count {
                if(count > 0) {
                    emptyView.isHidden = true
                    collectionView.isHidden = false
                } else {
                    emptyView.isHidden = false
                    collectionView.isHidden = true
                }
            }
            self.initData()
            self.collectionView.reloadData()
        }
    }
    
    //topView
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let alarmsStatisticView: AlarmsStatisticView = {
        let view = AlarmsStatisticView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //searchView
    let searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let alarmSearchView: AlarmSearchView = {
        let view = AlarmSearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    //
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
        self.setupSearchView()
        self.setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func initKeyboard() {
        self.maintenanceView?.homeController?.setupToolbar()
    }
    
    func initData() {
        var criticalCount = 0
        var majorCount = 0
        var minorCount = 0
        var warningCount = 0
        if let alarms = self.alarms {
            for alarm in alarms {
                if let status = alarm.lev {
                    if(status == 1) {
                        criticalCount = criticalCount + 1
                    }
                    if(status == 2) {
                        majorCount = majorCount + 1
                    }
                    if(status == 3) {
                        minorCount = minorCount + 1
                    }
                    if(status == 4) {
                        warningCount = warningCount + 1
                    }
                }
            }
        }
        self.alarmsStatisticView.criticalCount = criticalCount
        self.alarmsStatisticView.majorCount = majorCount
        self.alarmsStatisticView.minorCount = minorCount
        self.alarmsStatisticView.warningCount = warningCount
        self.alarmsStatisticView.initData()
    }
    
    func setupView() {
        self.addSubview(topView)
        self.addSubview(emptyView)
        self.addSubview(collectionView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topView)
        self.addConstraintsWithFormat("H:[v0(\(143.dp))]", views: emptyView)
        self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        
        self.addConstraintsWithFormat("V:|[v0(\(219.dp))][v1]|", views: topView, collectionView)
        self.addConstraintsWithFormat("V:|[v0(\(219.dp))]", views: topView)
        self.addConstraintsWithFormat("V:[v0(\(154.dp))]", views: emptyView)
        
        emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupTopView() {
        topView.addSubview(alarmsStatisticView)
        topView.addSubview(searchView)
        
        topView.addConstraintsWithFormat("H:|[v0]|", views: alarmsStatisticView)
        topView.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(20.dp)-|", views: searchView)
        
        topView.addConstraintsWithFormat("V:|-\(16.dp)-[v0(\(100.dp))]-\(32.dp)-[v1(\(48.dp))]", views: alarmsStatisticView, searchView)
        
        alarmsStatisticView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        searchView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
    }
    
    func setupSearchView() {
        searchView.addSubview(alarmSearchView)
        searchView.addSubview(filterButton)
        
        searchView.addConstraintsWithFormat("H:|[v0]-\(15.dp)-[v1(\(24.dp))]|", views: alarmSearchView, filterButton)
        
        searchView.addConstraintsWithFormat("V:|[v0]|", views: alarmSearchView)
        searchView.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: filterButton)
        
        filterButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        
        filterButton.addTarget(self, action: #selector(self.filterButtonPress), for: .touchUpInside)
        
        alarmSearchView.alarmsCellView = self
    }
    
    @objc func filterButtonPress() {
        print("filterButtonPress")
    }
    
    //collectionView Setup
    func setupCollectionView() {
        print("setupCollectionView")
        collectionView.register(AlarmCellView.self, forCellWithReuseIdentifier: "alarmCellViewId")
        collectionView.contentInset = UIEdgeInsets(top: 16.dp, left: 0, bottom: 16.dp, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 16.dp, left: 0, bottom: 16.dp, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.alarms?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alarmCellViewId", for: indexPath) as! AlarmCellView
        cell.alarm = self.alarms?[index]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 231.dp)
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
        if let alarm = self.alarms?[index] {
            self.maintenanceView?.homeController?.openAlarmDetailController(alarm: alarm)
        }
        
    }
    //collectionView Setup end
    
    //ApiService
//    func fetchAlarmList() {
//        ApiService.sharedInstance.fetchAlarmList() {
//            (error: CustomError?, alarms: [Alarm]?) in
//            //self.hideLoadingView()
//            if(error?.code ?? 0 == 0) {
//                
//            } else {
//                //error
//            }
//        }
//    }
    //
    
    //fot test
    func generateAlarms() {
        var alarms = [Alarm]()
        
        var alarm1 = Alarm()
        alarm1.alarmCause = "An unrecoverable fault has occurred in the internal circuit of the device."
        alarm1.alarmId = 2064
        alarm1.alarmName = "The device is abnormal."
        alarm1.alarmType = 2
        alarm1.causeId = 5
        alarm1.devName = "Inverter-1"
        alarm1.devTypeId = 38
        alarm1.esnCode = "Inverter05"
        alarm1.lev = 1
        alarm1.raiseTime = 1667179861000
        alarm1.repairSuggestion = "Turn off the AC and DC switches, wait for 5 minutes, and then turn on the AC and DC switches. If the fault persists, contact your dealer or technical support."
        alarm1.stationCode = "NE=33554792"
        alarm1.stationName = "hzhStation02"
        alarm1.status = 1
        alarms.append(alarm1)
        
        var alarm2 = Alarm()
        alarm2.alarmCause = "An unrecoverable fault has occurred in the internal circuit of the device."
        alarm2.alarmId = 2064
        alarm2.alarmName = "Abnormal communication between management system and equipment"
        alarm2.alarmType = 2
        alarm2.causeId = 5
        alarm2.devName = "Inverter-1"
        alarm2.devTypeId = 38
        alarm2.esnCode = "Inverter05"
        alarm2.lev = 2
        alarm2.raiseTime = 1667179861000
        alarm2.repairSuggestion = "Scenario 1: device connection through a network cable.\n1,Check whether the network and cable connection of the router are normal.\n2,Check whether the router network can access the public network.\nScenario 2: device connection through WiFi.\n1,Check whether the network and cable connection of the router are normal.\n2,Check whether the router network can access the public network.\n\nScenario 3:device connection through a 4G network. Check whether the SIM card is inserted improperly or in arrears, ot its network is abnormal."
        alarm2.stationCode = "NE=33554792"
        alarm2.stationName = "hzhStation02"
        alarm2.status = 1
        alarms.append(alarm2)
        
        var alarm3 = Alarm()
        alarm3.alarmCause = "An unrecoverable fault has occurred in the internal circuit of the device."
        alarm3.alarmId = 2064
        alarm3.alarmName = "The device is abnormal."
        alarm3.alarmType = 2
        alarm3.causeId = 5
        alarm3.devName = "Inverter-1"
        alarm3.devTypeId = 38
        alarm3.esnCode = "Inverter05"
        alarm3.lev = 2
        alarm3.raiseTime = 1667179861000
        alarm3.repairSuggestion = "Turn off the AC and DC switches, wait for 5 minutes, and then turn on the AC and DC switches. If the fault persists, contact your dealer or technical support."
        alarm3.stationCode = "NE=33554792"
        alarm3.stationName = "hzhStation02"
        alarm3.status = 1
        alarms.append(alarm3)
        
        var alarm4 = Alarm()
        alarm4.alarmCause = "An unrecoverable fault has occurred in the internal circuit of the device."
        alarm4.alarmId = 2064
        alarm4.alarmName = "The device is abnormal."
        alarm4.alarmType = 2
        alarm4.causeId = 5
        alarm4.devName = "Inverter-1"
        alarm4.devTypeId = 38
        alarm4.esnCode = "Inverter05"
        alarm4.lev = 4
        alarm4.raiseTime = 1667179861000
        alarm4.repairSuggestion = "Turn off the AC and DC switches, wait for 5 minutes, and then turn on the AC and DC switches. If the fault persists, contact your dealer or technical support."
        alarm4.stationCode = "NE=33554792"
        alarm4.stationName = "hzhStation02"
        alarm4.status = 1
        alarms.append(alarm4)
        
        self.alarms = alarms
    }
    //
}

class AlarmSearchView: UIView {
    
    var alarmsCellView: AlarmsCellView?
    
    var isEditing: Bool? {
        didSet {
            if(isEditing ?? false) {
                clearButton.isHidden = false
            } else {
                clearButton.isHidden = true
            }
        }
    }
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 45.dp, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 52.dp, height: textField.frame.height))
        textField.rightView = rightPaddingView
        textField.rightViewMode = UITextField.ViewMode.always
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18.dp), .foregroundColor: UIColor.rgb(106, green: 106, blue: 106)]
        textField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("search_alarm", comment: ""), attributes: attrs)
        textField.textColor = .rgb(1, green: 6, blue: 10)
        textField.font = UIFont.systemFont(ofSize: 18.dp)
        textField.textAlignment = .left
        textField.backgroundColor = .rgb(245, green: 244, blue: 244)
        textField.layer.cornerRadius = 24.dp
        return textField
    }()
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_search")
        return imageView
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "delete")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(searchTextField)
        self.addSubview(searchImageView)
        self.addSubview(clearButton)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: searchTextField)
        self.addConstraintsWithFormat("H:|-\(17.dp)-[v0(\(20.dp))]", views: searchImageView)
        self.addConstraintsWithFormat("H:[v0(\(48.dp))]-\(2.dp)-|", views: clearButton)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: searchTextField)
        self.addConstraintsWithFormat("V:[v0(\(20.dp))]", views: searchImageView)
        self.addConstraintsWithFormat("V:|[v0]|", views: clearButton)
        
        searchImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        searchTextField.addTarget(self, action: #selector(searchTextFieldChaged), for: .allEditingEvents)
        clearButton.addTarget(self, action: #selector(self.clearButtonPress), for: .touchUpInside)
        
        clearButton.isHidden = true
    }
    
    @objc func searchTextFieldChaged() {
        print("searchTextFieldChaged")
        if let text = searchTextField.text {
            if(text != "") {
                self.isEditing = true
            }
        }
    }
    
    @objc func clearButtonPress() {
        print("clearButtonPress")
        self.searchTextField.text = ""
        self.isEditing = false
        self.alarmsCellView?.maintenanceView?.homeController?.doneButtonAction()
    }
}
