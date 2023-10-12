//
//  MapCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 28/07/23.
//

import UIKit
import GoogleMaps
import MapKit
import Lottie

class MapCellView: UICollectionViewCell, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var homeView: HomeView?
    
    var markers: [GMSMarker]?
    
    let zoom: Float = 10.0
    
    var stations: [Station]? {
        didSet {
            var index = 0
            if let stations = self.stations {
                self.googleMapView.clear()
                self.markers?.removeAll()
                for station in stations {
                    let marker = GMSMarker()
                    marker.userData = ["index": index]
                    marker.appearAnimation = .pop
                    index = index + 1
                    var latitude = Double(station.latitude ?? "0.0")
                    var longitude = Double(station.longitude ?? "0.0")
                    marker.position = CLLocationCoordinate2D(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
                    marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
                    marker.map = googleMapView
                    var animationName = ""
                    if(station.status ?? 0 == 0) {
                        animationName = "locatin green"
                        normalCount = (normalCount ?? 0) + 1
                    }
                    if(station.status ?? 0 == 1) {
                        animationName = "locatin green"
                        normalCount = (normalCount ?? 0) + 1
                    }
                    if(station.status ?? 0 == 2) {
                        animationName = "locatin red"
                        faultyCount = (faultyCount ?? 0) + 1
                    }
                    if(station.status ?? 0 == 3) {
                        animationName = "locatin grey"
                        offlineCount = (offlineCount ?? 0) + 1
                    }
                    let pointAnimation = LottieAnimation.named(animationName)
                    var pointImageView = LottieAnimationView(frame: CGRect(x: 0, y: 0, width: 50.dp, height: 50.dp))
                    pointImageView.animation = pointAnimation
                    pointImageView.loopMode = .loop
                    pointImageView.play()
                    animatios.append(pointImageView)
                    let markerView = UIImageView()
                    marker.iconView = pointImageView

                    googleMapView.selectedMarker = marker
                    markers?.append(marker)
                }
                allCount = (normalCount ?? 0) + (faultyCount ?? 0) + (offlineCount ?? 0)
            }
        }
    }
    
    var animatios = [LottieAnimationView]()
    
    var locationManager = CLLocationManager()
    
    let geocoder = GMSGeocoder()
    
    var allCount: Int? {
        didSet {
            self.statisticsMapView.allValueLabel.text = "\(allCount ?? 0)"
        }
    }
    
    var normalCount: Int? {
        didSet {
            self.statisticsMapView.normalValueLabel.text = "\(normalCount ?? 0)"
        }
    }
    
    var faultyCount: Int? {
        didSet {
            self.statisticsMapView.faultyValueLabel.text = "\(faultyCount ?? 0)"
        }
    }
    
    var offlineCount: Int? {
        didSet {
            self.statisticsMapView.offlineValueLabel.text = "\(offlineCount ?? 0)"
        }
    }
    
    //topView
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let alarmStatisticsMapView: AlarmStatisticsMapView = {
        let view = AlarmStatisticsMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //
    
    let googleMapView: GMSMapView = {
        let view = GMSMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let statisticsMapView: StatisticsMapView = {
        let view = StatisticsMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 24.dp
        let image = UIImage(named: "ic_row")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(topView)
        topView.addSubview(alarmStatisticsMapView)
        self.addSubview(googleMapView)
        self.addSubview(statisticsMapView)
        self.addSubview(rowButton)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topView)
        topView.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: alarmStatisticsMapView)
        self.addConstraintsWithFormat("H:|[v0]|", views: googleMapView)
        self.addConstraintsWithFormat("H:[v0(\(72.dp))]-\(24.dp)-|", views: statisticsMapView)
        self.addConstraintsWithFormat("H:[v0(\(48.dp))]-\(24.dp)-|", views: rowButton)
        
        self.addConstraintsWithFormat("V:|[v0(\(92.dp))][v1]|", views: topView, googleMapView)
        self.addConstraintsWithFormat("V:[v0(\(236.dp))]", views: statisticsMapView)
        self.addConstraintsWithFormat("V:[v0(\(48.dp))]-\(18.dp)-|", views: rowButton)
        topView.addConstraintsWithFormat("V:[v0(\(60.dp))]-\(16.dp)-|", views: alarmStatisticsMapView)
        
        alarmStatisticsMapView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        
        statisticsMapView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 65.dp).isActive = true
        
        rowButton.addTarget(self, action: #selector(self.rowButtonPress), for: .touchUpInside)
    }
    
    @objc func rowButtonPress() {
        self.homeView?.showMap = false
    }
    
    func setupGoogleMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 41.3110278, longitude: 69.2843242, zoom: self.zoom)
        googleMapView.animate(to: camera)
        googleMapView.delegate = self
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                googleMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                print("Unable to find style.json")
            }
        }
        catch {
            print("One or more of the map styles failed to load. \(error)")
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedWhenInUse || status == CLAuthorizationStatus.authorizedAlways)
        {
            googleMapView.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: self.zoom)
        googleMapView.animate(to: camera)
        locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let dict = marker.userData as? [String:Int] {
            if let index = dict["index"] {
                if let station = self.stations?[index] {
                    print("select station \(station.plantName)")
                    var animationName = ""
                    if(station.status ?? 0 == 0) {
                        animationName = "locatin green tap"
                    }
                    if(station.status ?? 0 == 1) {
                        animationName = "locatin green tap"
                    }
                    if(station.status ?? 0 == 2) {
                        animationName = "locatin red tap"
                    }
                    if(station.status ?? 0 == 3) {
                        animationName = "locatin grey tap"
                    }
                    let pointAnimation = LottieAnimation.named(animationName)
                    self.animatios[index].animation = pointAnimation
                    self.animatios[index].loopMode = .playOnce
                    self.animatios[index].play { (finished) in
                        if(station.status ?? 0 == 0) {
                            animationName = "locatin green"
                        }
                        if(station.status ?? 0 == 1) {
                            animationName = "locatin green"
                        }
                        if(station.status ?? 0 == 2) {
                            animationName = "locatin red"
                        }
                        if(station.status ?? 0 == 3) {
                            animationName = "locatin grey"
                        }
                        let pointAnimation = LottieAnimation.named(animationName)
                        self.animatios[index].animation = pointAnimation
                        self.animatios[index].loopMode = .loop
                        self.animatios[index].play()
                    }
                    
                    self.homeView?.homeController?.openPlantMapInfoView(station: station)
                }
            }
        }
        return true
    }
}

class AlarmStatisticsMapView: UIView {
    
    //criticalView
    let criticalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let criticalValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(152, green: 152, blue: 152)
        label.font = .systemFont(ofSize: 20.dp)
        label.textAlignment = .center
        return label
    }()
    
    let criticalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("map_critical", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    let seperate1View: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "divider")
        return imageView
    }()
    
    //majorView
    let majorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let majorValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(152, green: 152, blue: 152)
        label.font = .systemFont(ofSize: 20.dp)
        label.textAlignment = .center
        return label
    }()
    
    let majorTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("map_major", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    let seperate2View: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "divider")
        return imageView
    }()
    
    //minorView
    let minorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let minorValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(152, green: 152, blue: 152)
        label.font = .systemFont(ofSize: 20.dp)
        label.textAlignment = .center
        return label
    }()
    
    let minorTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("map_minor", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    let seperate3View: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "divider")
        return imageView
    }()
    
    //warningView
    let warningView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let warningValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(152, green: 152, blue: 152)
        label.font = .systemFont(ofSize: 20.dp)
        label.textAlignment = .center
        return label
    }()
    
    let warningTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("map_warning", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupCriticalView()
        self.setupMajorView()
        self.setupMinorView()
        self.setupWarningView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(criticalView)
        self.addSubview(seperate1View)
        self.addSubview(majorView)
        self.addSubview(seperate2View)
        self.addSubview(minorView)
        self.addSubview(seperate3View)
        self.addSubview(warningView)
        
        self.addConstraintsWithFormat("H:|[v0(\(72.dp))][v1(\(21.dp))][v2(\(72.dp))][v3(\(21.dp))][v4(\(72.dp))][v5(\(21.dp))][v6(\(72.dp))]", views: criticalView, seperate1View, majorView, seperate2View, minorView, seperate3View, warningView)
        
        self.addConstraintsWithFormat("V:[v0(\(60.dp))]", views: criticalView)
        self.addConstraintsWithFormat("V:[v0(\(41.dp))]", views: seperate1View)
        self.addConstraintsWithFormat("V:[v0(\(60.dp))]", views: majorView)
        self.addConstraintsWithFormat("V:[v0(\(41.dp))]", views: seperate2View)
        self.addConstraintsWithFormat("V:[v0(\(60.dp))]", views: minorView)
        self.addConstraintsWithFormat("V:[v0(\(41.dp))]", views: seperate3View)
        self.addConstraintsWithFormat("V:[v0(\(60.dp))]", views: warningView)
        
        criticalView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        seperate1View.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        majorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        seperate2View.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        minorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        seperate3View.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        warningView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupCriticalView() {
        criticalView.addSubview(criticalValueLabel)
        criticalView.addSubview(criticalTitleLabel)
        
        criticalView.addConstraintsWithFormat("H:|[v0]|", views: criticalValueLabel)
        criticalView.addConstraintsWithFormat("H:|[v0]|", views: criticalTitleLabel)
        
        criticalView.addConstraintsWithFormat("V:|-\(12.dp)-[v0]-\(2.dp)-[v1]", views: criticalValueLabel, criticalTitleLabel)
    }
    
    func setupMajorView() {
        majorView.addSubview(majorValueLabel)
        majorView.addSubview(majorTitleLabel)
        
        majorView.addConstraintsWithFormat("H:|[v0]|", views: majorValueLabel)
        majorView.addConstraintsWithFormat("H:|[v0]|", views: majorTitleLabel)
        
        majorView.addConstraintsWithFormat("V:|-\(12.dp)-[v0]-\(2.dp)-[v1]", views: majorValueLabel, majorTitleLabel)
    }
    
    func setupMinorView() {
        minorView.addSubview(minorValueLabel)
        minorView.addSubview(minorTitleLabel)
        
        minorView.addConstraintsWithFormat("H:|[v0]|", views: minorValueLabel)
        minorView.addConstraintsWithFormat("H:|[v0]|", views: minorTitleLabel)
        
        minorView.addConstraintsWithFormat("V:|-\(12.dp)-[v0]-\(2.dp)-[v1]", views: minorValueLabel, minorTitleLabel)
    }
    
    func setupWarningView() {
        warningView.addSubview(warningValueLabel)
        warningView.addSubview(warningTitleLabel)
        
        warningView.addConstraintsWithFormat("H:|[v0]|", views: warningValueLabel)
        warningView.addConstraintsWithFormat("H:|[v0]|", views: warningTitleLabel)
        
        warningView.addConstraintsWithFormat("V:|-\(12.dp)-[v0]-\(2.dp)-[v1]", views: warningValueLabel, warningTitleLabel)
    }
}

class StatisticsMapView: UIView {
    
    //allView
    let allView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let allValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(101, green: 101, blue: 101)
        label.font = .systemFont(ofSize: 18.dp)
        label.textAlignment = .center
        return label
    }()
    
    let allTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("all", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    //normalView
    let normalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let normalValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(101, green: 101, blue: 101)
        label.font = .systemFont(ofSize: 18.dp)
        label.textAlignment = .center
        return label
    }()
    
    let normalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("normal", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    //faultyView
    let faultyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let faultyValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(101, green: 101, blue: 101)
        label.font = .systemFont(ofSize: 18.dp)
        label.textAlignment = .center
        return label
    }()
    
    let faultyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("faulty", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    //offlineView
    let offlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let offlineValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(101, green: 101, blue: 101)
        label.font = .systemFont(ofSize: 18.dp)
        label.textAlignment = .center
        return label
    }()
    
    let offlineTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("offline", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp
        
        self.setupView()
        self.setupAllView()
        self.setupNormalView()
        self.setupFaultyView()
        self.setupOfflineView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(allView)
        self.addSubview(normalView)
        self.addSubview(faultyView)
        self.addSubview(offlineView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: allView)
        self.addConstraintsWithFormat("H:|[v0]|", views: normalView)
        self.addConstraintsWithFormat("H:|[v0]|", views: faultyView)
        self.addConstraintsWithFormat("H:|[v0]|", views: offlineView)
        
        self.addConstraintsWithFormat("V:|-\(8.dp)-[v0(\(55.dp))][v1(\(55.dp))][v2(\(55.dp))][v3(\(55.dp))]", views: allView, normalView, faultyView, offlineView)
    }
    
    func setupAllView() {
        allView.addSubview(allValueLabel)
        allView.addSubview(allTitleLabel)
        
        allView.addConstraintsWithFormat("H:|[v0]|", views: allValueLabel)
        allView.addConstraintsWithFormat("H:|[v0]|", views: allTitleLabel)
        
        allView.addConstraintsWithFormat("V:|-\(8.dp)-[v0]-\(2.dp)-[v1]", views: allValueLabel, allTitleLabel)
    }
    
    func setupNormalView() {
        normalView.addSubview(normalValueLabel)
        normalView.addSubview(normalTitleLabel)
        
        normalView.addConstraintsWithFormat("H:|[v0]|", views: normalValueLabel)
        normalView.addConstraintsWithFormat("H:|[v0]|", views: normalTitleLabel)
        
        normalView.addConstraintsWithFormat("V:|-\(8.dp)-[v0]-\(2.dp)-[v1]", views: normalValueLabel, normalTitleLabel)
    }
    
    func setupFaultyView() {
        faultyView.addSubview(faultyValueLabel)
        faultyView.addSubview(faultyTitleLabel)
        
        faultyView.addConstraintsWithFormat("H:|[v0]|", views: faultyValueLabel)
        faultyView.addConstraintsWithFormat("H:|[v0]|", views: faultyTitleLabel)
        
        faultyView.addConstraintsWithFormat("V:|-\(8.dp)-[v0]-\(2.dp)-[v1]", views: faultyValueLabel, faultyTitleLabel)
    }
    
    func setupOfflineView() {
        offlineView.addSubview(offlineValueLabel)
        offlineView.addSubview(offlineTitleLabel)
        
        offlineView.addConstraintsWithFormat("H:|[v0]|", views: offlineValueLabel)
        offlineView.addConstraintsWithFormat("H:|[v0]|", views: offlineTitleLabel)
        
        offlineView.addConstraintsWithFormat("V:|-\(8.dp)-[v0]-\(2.dp)-[v1]", views: offlineValueLabel, offlineTitleLabel)
    }
}
