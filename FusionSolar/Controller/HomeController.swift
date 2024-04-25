//
//  HomeController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 20/07/23.
//

import UIKit

class HomeController: UIViewController {
    
    static var selectedLanguage = "" //ru/uz-UZ/uz-Cyrl
    
    static var login = ""
    static var password = ""
    static var token = ""
    static var bspsession = ""
    
    static var profile: Profile?
    
    static var window: UIWindow?
    static var topPadding: CGFloat = 0.0
    
    var pageNo = 1
    var isLoadEnd = false
    
    var allStations = [Station]()
    
    static var orrientation = "portain"
    
    var stations: [Station]? {
        didSet {
            if let stations = self.stations {
                var alarms = [Alarm]()
                for station in stations {
                    let day_power = station.stationRealKpi?.day_power ?? 0.0
                    let capacity = station.capacity ?? 0.0
                    if(capacity > 0.0) {
                        station.attitude = day_power / capacity
                    }
                    for alarm in station.alarms ?? [Alarm]() {
                        alarm.plantAddress = station.plantAddress
                        alarm.latitude = station.latitude
                        alarm.longitude = station.longitude
                        alarms.append(alarm)
                    }
                    
                    self.alarms = alarms
                }
            }
            self.homeView.plantsView.stations = self.stations
            self.statisticPlantView.stations = self.stations
            
            
        }
    }
    
    var regions: [Region]?
    
    var alarms: [Alarm]?
    
    var currentPage: Int? {
        didSet {
            if let page = currentPage {
                if(page == 0) {
                    self.homeView.isHidden = false
                    self.maintenanceView.isHidden = true
                    self.statisticPlantView.isHidden = true
                    self.profileView.isHidden = true
                }
                if(page == 1) {
                    self.homeView.isHidden = true
                    self.maintenanceView.isHidden = false
                    self.statisticPlantView.isHidden = true
                    self.profileView.isHidden = true
                    self.maintenanceView.alarmsView.alarms = alarms
                }
                if(page == 2) {
                    self.homeView.isHidden = true
                    self.maintenanceView.isHidden = true
                    self.statisticPlantView.isHidden = false
                    self.statisticPlantView.getDataForGraph()
                    self.profileView.isHidden = true
                }
                if(page == 3) {
                    self.homeView.isHidden = true
                    self.maintenanceView.isHidden = true
                    self.statisticPlantView.isHidden = true
                    self.profileView.isHidden = false
                }
            }
        }
    }
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    lazy var homeView: HomeView = {
        let view = HomeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeController = self
        return view
    }()
    
    lazy var maintenanceView: MaintenanceView = {
        let view = MaintenanceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeController = self
        return view
    }()
    
    lazy var statisticPlantView: StatisticPlantView = {
        let view = StatisticPlantView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeController = self
        return view
    }()
    
    lazy var profileView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeController = self
        return view
    }()
    
    let errorView: SimpleErrorView = {
        let eV = SimpleErrorView()
        eV.translatesAutoresizingMaskIntoConstraints = false
        return eV
    }()

    let loadingView: LoadingView = {
        let lV = LoadingView()
        lV.translatesAutoresizingMaskIntoConstraints = false
        return lV
    }()
    
    lazy var plantsFilterView: PlantsFilterView = {
        let view = PlantsFilterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeController = self
        return view
    }()
    
    lazy var deviceFilterView: DeviceFilterView = {
        let view = DeviceFilterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeController = self
        return view
    }()
    
    lazy var datePickerView: DatePickerView = {
        let view = DatePickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeController = self
        return view
    }()
    
    lazy var monthPickerView: MonthPickerView = {
        let view = MonthPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeController = self
        return view
    }()
    
    lazy var yearPickerView: YearPickerView = {
        let view = YearPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeController = self
        return view
    }()
    
    lazy var plantMapInfoView: PlantMapInfoView = {
        let view = PlantMapInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeController = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        HomeController.window = UIApplication.shared.keyWindow
        HomeController.topPadding = HomeController.window?.safeAreaInsets.top ?? 0.0
        
        self.view.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupContentView()
        
        self.showLoadingView()
        self.fetchStations()
        
        self.setupToolbar()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
//
//        if(size.width > self.view.frame.size.width){
//            print("Landscape")
//            //self.setupView()
//            HomeController.orrientation = "landscape"
//            self.view.layoutIfNeeded()
//            self.homeView.collectionView.reloadData()
////            self.homeView.collectionView.collectionViewLayout.invalidateLayout()
//        }
//        else{
//            print("Portrait")
//            HomeController.orrientation = "portrait"
//           // self.setupView()
//            self.view.layoutIfNeeded()
//            self.homeView.collectionView.reloadData()
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.maintenanceView.collectionView.collectionViewLayout.invalidateLayout()
        self.menuBar.collectionView.collectionViewLayout.invalidateLayout()
        //self.devicesView.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setupView() {
        self.view.addSubview(contentView)
        self.view.addSubview(menuBar)
        self.view.addSubview(plantsFilterView)
        self.view.addSubview(deviceFilterView)
        self.view.addSubview(datePickerView)
        self.view.addSubview(monthPickerView)
        self.view.addSubview(yearPickerView)
        self.view.addSubview(plantMapInfoView)
        
        self.view.addConstraintsWithFormat("H:|[v0]|", views: contentView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: plantsFilterView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: deviceFilterView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: datePickerView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: monthPickerView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: yearPickerView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: plantMapInfoView)
        
        self.view.addConstraintsWithFormat("V:[v0(\(66.dp))]", views: menuBar)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: plantsFilterView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: deviceFilterView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: datePickerView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: monthPickerView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: yearPickerView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: plantMapInfoView)
        
        contentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.menuBar.topAnchor).isActive = true
        menuBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        plantsFilterView.isHidden = true
        deviceFilterView.isHidden = true
        datePickerView.isHidden = true
        monthPickerView.isHidden = true
        yearPickerView.isHidden = true
        plantMapInfoView.isHidden = true
    }
    
    func setupContentView() {
        contentView.addSubview(homeView)
        contentView.addSubview(maintenanceView)
        contentView.addSubview(statisticPlantView)
        contentView.addSubview(profileView)

        contentView.addConstraintsWithFormat("H:|[v0]|", views: homeView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: maintenanceView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: statisticPlantView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: profileView)

        contentView.addConstraintsWithFormat("V:|[v0]|", views: homeView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: maintenanceView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: statisticPlantView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: profileView)

        maintenanceView.isHidden = true
        statisticPlantView.isHidden = true
        profileView.isHidden = true
    }
    
    func openPlantsFilterView() {
        self.plantsFilterView.isHidden = false
        self.plantsFilterView.showAnimaton()
    }
    
    func openDeviceFilterView() {
        self.deviceFilterView.isHidden = false
        self.deviceFilterView.showAnimaton()
    }
    
    func openPlantMapInfoView(station: Station) {
        self.plantMapInfoView.isHidden = false
        self.plantMapInfoView.station = station
        self.plantMapInfoView.showAnimaton()
    }
    
    func openDatePickerView(selectedDate: Date, graphView: GraphView) {
        self.datePickerView.selectedDate = selectedDate
        self.datePickerView.graphView = graphView
        self.datePickerView.isHidden = false
        self.datePickerView.showAnimaton()
    }
    
    func openMonthPickerView(selectedDate: Date, graphView: GraphView) {
        self.monthPickerView.selectedDate = selectedDate
        self.monthPickerView.graphView = graphView
        self.monthPickerView.isHidden = false
        self.monthPickerView.showAnimaton()
    }
    
    func openYearPickerView(selectedDate: Date, graphView: GraphView) {
        self.yearPickerView.selectedDate = selectedDate
        self.yearPickerView.graphView = graphView
        self.yearPickerView.isHidden = false
        self.yearPickerView.showAnimaton()
    }
    
    func openSettingsController() {
        let settingsController = SettingsController()
        settingsController.modalPresentationStyle = .fullScreen
        self.present(settingsController, animated: true)
    }
    
    func openAlarmDetailController(alarm: Alarm) {
        let alarmDetailController = AlarmDetailController()
        alarmDetailController.modalPresentationStyle = .fullScreen
        alarmDetailController.alarm = alarm
        self.present(alarmDetailController, animated: true)
    }
    
    func openOverviewController(station: Station) {
        let pverviewController = OverviewController()
        pverviewController.modalPresentationStyle = .fullScreen
        pverviewController.station = station
        self.present(pverviewController, animated: true)
    }
    
    func openRegionsController() {
        let regionsController = RegionsController()
        regionsController.modalPresentationStyle = .fullScreen
        regionsController.homeController = self
        self.present(regionsController, animated: true)
    }
    
    func openCompanyInfoController() {
        let companyInfoController = CompanyInfoController()
        companyInfoController.modalPresentationStyle = .fullScreen
        self.present(companyInfoController, animated: true)
    }
    
    func openAboutController() {
        let aboutController = AboutController()
        aboutController.modalPresentationStyle = .fullScreen
        self.present(aboutController, animated: true)
    }
    
    //ApiService
    func fetchStations() {
        if(!isLoadEnd) {
            self.showLoadingView()
            ApiService.sharedInstance.fetchStations(pageNo: self.pageNo) {
                (error: CustomError?, stations: [Station]?) in
                self.hideLoadingView()
                if(error?.code ?? 0 == 0) {
                    self.isLoadEnd = true
                    self.stations = stations
                } else {
                    //error
                }
            }
        }
    }
    
    func fetchHourKpi(collectTime: Int64) {
        self.showLoadingView()
        ApiService.sharedInstance.fetchHourKpi(collectTime: collectTime) {
            (error: CustomError?, detailRealKpis: [DetailRealKpi]?) in
            self.hideLoadingView()
            if(error?.code ?? 0 == 0) {
                self.statisticPlantView.detailRealKpis = detailRealKpis
            } else {
                //error
            }
        }
    }
//
//    func fetchStations(stationCodes: String) {
//       // self.showLoadingView()
//        ApiService.sharedInstance.fetchStationRealKpi(stationCodes: stationCodes) {
//            (error: CustomError?, realKpis: [StationRealKpi]?) in
//          //  self.hideLoadingView()
//            if(error?.code ?? 0 == 0) {
//                if(realKpis?.count ?? 0 > 0) {
//                    self.realKpis = realKpis
//                }
//                self.compliteAllRequests()
//            } else {
//                //error
//            }
//        }
//    }
//    
//    func fetchAlarmList(stationCodes: String) {
//      //  self.showLoadingView()
//        ApiService.sharedInstance.fetchAlarmList(stationCodes: stationCodes) {
//            (error: CustomError?, alarms: [Alarm]?) in
//         //   self.hideLoadingView()
//            if(error?.code ?? 0 == 0) {
//                self.alarms = alarms
//            } else {
//                //error
//            }
//        }
//    }
    //
    
    //Error and Loading views
    func showErrorView(title: String, message: String) {
        self.view.addSubview(errorView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: errorView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: errorView)
        errorView.isHidden = false
        errorView.title = title
        errorView.message = message
    }
    
    func showLoadingView() {
        self.view.addSubview(loadingView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: loadingView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: loadingView)
        loadingView.isHidden = false
        loadingView.startActivityIndicator()
    }
    
    func hideLoadingView() {
        loadingView.stopActivityIndicator()
        loadingView.isHidden = true
    }
    //
    
    //keyboard
    func setupToolbar() {
        print("setupToolbar")
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30.dp))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: .done, target: self, action: #selector(self.doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        
        homeView.plantsView.plantsSearchView.searchTextField.inputAccessoryView = toolbar
        maintenanceView.alarmsView.alarmSearchView.searchTextField.inputAccessoryView = toolbar
//        devicesView.searchDevicesView.devicesSearchView.searchTextField.inputAccessoryView = toolbar
//        maintenanceView.tasksCellView?.inspectionTasksCellView?.searchView.searchTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        print("doneButtonAction")
        self.view.endEditing(true)
    }
    //
    
    static func powerConvert(value: Double?) -> String {
        var result = ""
        if let thisValue = value {
            if(thisValue < 1000) {
                result = "\(thisValue.rounded(toPlaces: 3)) \(NSLocalizedString("kwp", comment: ""))"
            } else {
                result = "\((thisValue/1000.0).rounded(toPlaces: 3)) \(NSLocalizedString("mwp", comment: ""))"
            }
        } else {
            result = "--\(NSLocalizedString("kwp", comment: ""))"
        }
        return result
    }
    
    static func amountEnergyConvert(value: Double?) -> String {
        var result = ""
        if let thisValue = value {
            if(thisValue < 1000) {
                result = "\(thisValue.rounded(toPlaces: 2)) \(NSLocalizedString("kwh", comment: ""))"
            } else {
                result = "\((thisValue/1000.0).rounded(toPlaces: 2)) \(NSLocalizedString("mwh", comment: ""))"
            }
        } else {
            result = "--\(NSLocalizedString("kwh", comment: ""))"
        }
        return result
    }
}
