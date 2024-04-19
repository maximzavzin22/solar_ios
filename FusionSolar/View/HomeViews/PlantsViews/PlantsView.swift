//
//  PlantsView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit

class PlantsView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    var homeView: HomeView?
    
    var status: String? {
        didSet {
            self.generateShowStations()
        }
    }
    
    var searchText: String? {
        didSet {
            self.generateShowStations()
        }
    }
    
    var fromDate: Date?
    var toDate: Date?
    var capacityMin: Double?
    var capacityMax: Double?
    
    var stations: [Station]? {
        didSet {
            self.statusNavigationView.stations = stations
            self.generateShowStations()
        }
    }
    
    var showStations: [Station]? {
        didSet {
            if let count = self.showStations?.count {
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
                filterButton.setImage(image, for: .normal)
            } else {
                let image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal)
                filterButton.setImage(image, for: .normal)
            }
            self.generateShowStations()
        }
    }
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var statusNavigationView: StatusNavigationView = {
        let view = StatusNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.plantsView = self
        return view
    }()
    
    let searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let plantsSearchView: PlantsSearchView = {
        let view = PlantsSearchView()
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
    
    let mapButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 24.dp
        let image = UIImage(named: "map")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
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
    
    func initKeyboard() {
        self.homeView?.homeController?.setupToolbar()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(topView)
        self.addSubview(emptyView)
        self.addSubview(collectionView)
        self.addSubview(mapButton)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topView)
        self.addConstraintsWithFormat("H:[v0(\(143.dp))]", views: emptyView)
        self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        self.addConstraintsWithFormat("H:[v0(\(48.dp))]-\(24.dp)-|", views: mapButton)
        
        self.addConstraintsWithFormat("V:|[v0(\(156.dp))][v1]|", views: topView, collectionView)
        self.addConstraintsWithFormat("V:[v0(\(154.dp))]", views: emptyView)
        self.addConstraintsWithFormat("V:[v0(\(48.dp))]-\(18.dp)-|", views: mapButton)
        
        emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        mapButton.addTarget(self, action: #selector(self.mapButtonPress), for: .touchUpInside)
    }
    
    @objc func mapButtonPress() {
        self.homeView?.showMapView(isMap: true)
    }
    
    func setupTopView() {
        topView.addSubview(statusNavigationView)
        topView.addSubview(searchView)
        
        topView.addConstraintsWithFormat("H:|-\(16.dp)-[v0]-\(16.dp)-|", views: statusNavigationView)
        topView.addConstraintsWithFormat("H:|-\(16.dp)-[v0]-\(16.dp)-|", views: searchView)
        
        topView.addConstraintsWithFormat("V:|-\(16.dp)-[v0(\(60.dp))]-\(16.dp)-[v1(\(48.dp))]", views: statusNavigationView, searchView)
        
        statusNavigationView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        searchView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
    }
    
    func setupSearchView() {
        searchView.addSubview(plantsSearchView)
        searchView.addSubview(filterButton)
        
        searchView.addConstraintsWithFormat("H:|[v0]-\(15.dp)-[v1(\(24.dp))]|", views: plantsSearchView, filterButton)
        
        searchView.addConstraintsWithFormat("V:|[v0]|", views: plantsSearchView)
        searchView.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: filterButton)
        
        filterButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        
        filterButton.addTarget(self, action: #selector(self.filterButtonPress), for: .touchUpInside)
        
        plantsSearchView.plantsView = self
    }
    
    @objc func filterButtonPress() {
        self.homeView?.homeController?.openPlantsFilterView()
    }
    
    func generateShowStations() {
        if let stations = self.stations {
            var showStations = [Station]()
            showStations = getStationByStatus(stations: stations)
            showStations = getStationsByText(stations: showStations)
            showStations = getStationByCapacity(stations: showStations)
            print("1cshowStations \(showStations.count)")
            showStations = getStationByDates(stations: showStations)
            print("2cshowStations \(showStations.count)")
            self.showStations = showStations
        }
    }
    
    func getStationByStatus(stations: [Station]) -> [Station] {
        var showStations = [Station]()
        let status = self.status ?? "all"
        if(status == "all") {
            showStations = stations
        } else {
            for station in stations {
                if(status == "normal") {
                    if(station.stationRealKpi?.real_health_state ?? 0 == 3) {
                        showStations.append(station)
                    }
                }
                if(status == "faulty") {
                    if(station.stationRealKpi?.real_health_state ?? 0 == 2) {
                        showStations.append(station)
                    }
                }
                if(status == "offline") {
                    if(station.stationRealKpi?.real_health_state ?? 0 == 1) {
                        showStations.append(station)
                    }
                }
            }
        }
        
        return showStations
    }
    
    func getStationsByText(stations: [Station]) -> [Station] {
        var showStations = [Station]()
        let searchText = self.searchText ?? ""
        if(searchText.count > 2) {
            for station in stations {
                if let plantName = station.plantName {
                    if(plantName.lowercased().contains(searchText.lowercased())) {
                        showStations.append(station)
                    }
                }
            }
        } else {
            showStations = stations
        }
        if(searchText == "") {
            showStations = stations
        }
        return showStations
    }
    
    func getStationByCapacity(stations: [Station]) -> [Station] {
        var showStations = stations
        if let capacityMin = self.capacityMin {
            if let capacityMax = self.capacityMax {
                if(capacityMin != 0.0 && capacityMax != 0.0) {
                    var newStationsList = [Station]()
                    for station in stations {
                        if let capacity = station.capacity {
                            if(capacityMin == 1000.0) {
                                if(capacity >= capacityMin) {
                                    newStationsList.append(station)
                                }
                            } else {
                                if(capacity >= capacityMin && capacity < capacityMax) {
                                    newStationsList.append(station)
                                }
                            }
                        }
                    }
                    showStations = newStationsList
                }
            }
        }
        return showStations
    }
    
    func getStationByDates(stations: [Station]) -> [Station] {
        var showStations = stations
        var newStationsList = [Station]()
        if(self.fromDate != nil && self.toDate != nil) {
            for station in stations {
                if let gridConnectionDate = station.gridConnectionDate {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    if let date = dateFormatter.date(from: gridConnectionDate) {
                        if(date >= self.fromDate! && date <= self.toDate!) {
                            newStationsList.append(station)
                        }
                    }
                }
            }
        } else {
            if let toDate = self.toDate {
                for station in stations {
                    if let gridConnectionDate = station.gridConnectionDate {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        if let date = dateFormatter.date(from: gridConnectionDate) {
                            if(date <= self.toDate!) {
                                newStationsList.append(station)
                            }
                        }
                    }
                }
            }
            if let fromFate = self.fromDate {
                for station in stations {
                    if let gridConnectionDate = station.gridConnectionDate {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        if let date = dateFormatter.date(from: gridConnectionDate) {
                            if(date >= self.fromDate!) {
                                newStationsList.append(station)
                            }
                        }
                    }
                }
            }
        }
        if(newStationsList.count > 0) {
            showStations = newStationsList
        }
        return showStations
    }
    
    //collectionView Setup
    func setupCollectionView() {
        print("setupCollectionView")
        collectionView.register(PlantCellView.self, forCellWithReuseIdentifier: "plantCellViewId")
        collectionView.contentInset = UIEdgeInsets(top: 16.dp, left: 0, bottom: 66.dp, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 16.dp, left: 0, bottom: 66.dp, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.showStations?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantCellViewId", for: indexPath) as! PlantCellView
        cell.station = self.showStations?[index]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 117.dp)
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
        if let station = self.showStations?[index] {
            self.homeView?.homeController?.openOverviewController(station: station)
        }
    }
    //collectionView Setup end
    
    func showLoadingView() {
        self.addSubview(loadingView)
        self.addConstraintsWithFormat("H:|[v0]|", views: loadingView)
        loadingView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        loadingView.isHidden = false
        loadingView.startActivityIndicator()
    }
    
    func hideLoadingView() {
        loadingView.stopActivityIndicator()
        loadingView.isHidden = true
    }
}

