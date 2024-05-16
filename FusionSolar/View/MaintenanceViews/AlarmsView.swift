//
//  AlarmsView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit

class AlarmsView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var maintenanceView: MaintenanceView?
    var stationAlarmsController: StationAlarmsController?
    
    var searchText: String? {
        didSet {
            self.generateShowAlarms()
        }
    }
    
    var status: Int? {
        didSet {
            self.generateShowAlarms()
        }
    }
    
    var alarms: [Alarm]? {
        didSet {
            self.initData()
            self.generateShowAlarms()
        }
    }
    
    var showAlarms: [Alarm]? {
        didSet {
//            dump(showAlarms)
            if let count = self.showAlarms?.count {
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
    
    //topView
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var alarmsStatisticView: AlarmsStatisticView = {
        let view = AlarmsStatisticView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alarmsView = self
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
        searchView.addConstraintsWithFormat("H:|[v0]|", views: alarmSearchView)
        searchView.addConstraintsWithFormat("V:|[v0]|", views: alarmSearchView)
        alarmSearchView.alarmsView = self
    }
    
    func generateShowAlarms() {
        if let alarms = self.alarms {
            var showAlarms = [Alarm]()
            showAlarms = getAlarmsByStatus(alarms: alarms)
            showAlarms = getAlarmsByText(alarms: showAlarms)
            self.showAlarms = showAlarms
        }
    }
    
    func getAlarmsByStatus(alarms: [Alarm]) -> [Alarm] {
        var showAlarms = [Alarm]()
        let status = self.status ?? 0
        if(status == 0) {
            showAlarms = alarms
        } else {
            for alarm in alarms {
                if(alarm.lev == status) {
                    showAlarms.append(alarm)
                }
            }
        }
        return showAlarms
    }
    
    func getAlarmsByText(alarms: [Alarm]) -> [Alarm] {
        var showAlarms = [Alarm]()
        let searchText = self.searchText ?? ""
        if(searchText.count > 2) {
            for alarm in alarms {
                if let alarmId = alarm.alarmId {
                    let localizationName = NSLocalizedString("alarm_name_\(alarmId)", value: alarm.alarmName ?? "", comment: "")
                    if(localizationName.lowercased().contains(searchText.lowercased())) {
                        showAlarms.append(alarm)
                    }
                }
            }
        } else {
            showAlarms = alarms
        }
        if(searchText == "") {
            showAlarms = alarms
        }
        return showAlarms
    }
    
    //collectionView Setup
    func setupCollectionView() {
        print("setupCollectionView")
        collectionView.register(AlarmCellView.self, forCellWithReuseIdentifier: "alarmCellViewId")
        collectionView.contentInset = UIEdgeInsets(top: 16.dp, left: 0, bottom: 16.dp, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 16.dp, left: 0, bottom: 16.dp, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.showAlarms?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alarmCellViewId", for: indexPath) as! AlarmCellView
        cell.alarm = self.showAlarms?[index]
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
        let index = indexPath.item
        if let alarm = self.showAlarms?[index] {
            self.maintenanceView?.homeController?.openAlarmDetailController(alarm: alarm)
            self.stationAlarmsController?.openAlarmDetailController(alarm: alarm)
        }
        
    }
    //collectionView Setup end
}


