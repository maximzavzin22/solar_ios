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
    
    static var profile: Profile?
    
    var currentPage: Int? {
        didSet {
            if let page = currentPage {
                if(page == 0) {
                    self.homeView.isHidden = false
                    self.maintenanceView.isHidden = true
                    self.devicesView.isHidden = true
                    self.profileView.isHidden = true
                }
                if(page == 1) {
                    self.homeView.isHidden = true
                    self.maintenanceView.isHidden = false
                    self.devicesView.isHidden = true
                    self.profileView.isHidden = true
                    self.maintenanceView.alarmsCellView?.alarmsStatisticView.setupChartView()
                }
                if(page == 2) {
                    self.homeView.isHidden = true
                    self.maintenanceView.isHidden = true
                    self.devicesView.isHidden = false
                    self.profileView.isHidden = true
                }
                if(page == 3) {
                    self.homeView.isHidden = true
                    self.maintenanceView.isHidden = true
                    self.devicesView.isHidden = true
                    self.profileView.isHidden = false
                }
            }
        }
    }
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    lazy var devicesView: DevicesView = {
        let view = DevicesView()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupContentView()
        
        //self.setupToolbar()
    }
    
    func setupView() {
        self.view.addSubview(contentView)
        self.view.addSubview(menuBar)
        self.view.addSubview(plantsFilterView)
        self.view.addSubview(datePickerView)
        self.view.addSubview(monthPickerView)
        self.view.addSubview(yearPickerView)
        
        self.view.addConstraintsWithFormat("H:|[v0]|", views: contentView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: plantsFilterView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: datePickerView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: monthPickerView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: yearPickerView)
        
        self.view.addConstraintsWithFormat("V:[v0(\(66.dp))]", views: menuBar)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: plantsFilterView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: datePickerView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: monthPickerView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: yearPickerView)
        
        contentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.menuBar.topAnchor).isActive = true
        menuBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        plantsFilterView.isHidden = true
        datePickerView.isHidden = true
        monthPickerView.isHidden = true
        yearPickerView.isHidden = true
    }
    
    func setupContentView() {
        contentView.addSubview(homeView)
        contentView.addSubview(maintenanceView)
        contentView.addSubview(devicesView)
        contentView.addSubview(profileView)
        
        contentView.addConstraintsWithFormat("H:|[v0]|", views: homeView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: maintenanceView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: devicesView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: profileView)
        
        contentView.addConstraintsWithFormat("V:|[v0]|", views: homeView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: maintenanceView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: devicesView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: profileView)
        
        maintenanceView.isHidden = true
        devicesView.isHidden = true
        profileView.isHidden = true
    }
    
    func openPlantsFilterView() {
        self.plantsFilterView.isHidden = false
        self.plantsFilterView.showAnimaton()
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
        
        homeView.plantsCellView?.plantsSearchView.searchTextField.inputAccessoryView = toolbar
        maintenanceView.alarmsCellView?.alarmSearchView.searchTextField.inputAccessoryView = toolbar
//        homeView.inputAccessoryView = toolbar
//        usernameTextField.delegate = self
//
//        passwordTextField.inputAccessoryView = toolbar
//        passwordTextField.delegate = self
    }
    
    @objc func doneButtonAction() {
        print("doneButtonAction")
        self.view.endEditing(true)
    }
    //
}
