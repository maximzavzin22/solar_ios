//
//  MapView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 28/07/23.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils
import MapKit
import Lottie

class MapView: UIView, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var homeView: HomeView?
    
    var markers: [GMSMarker]?
    let zoom: Float = 10.0
    var locationManager = CLLocationManager()
    var clusterManager: GMUClusterManager!
    let geocoder = GMSGeocoder()
    var animatios = [LottieAnimationView]()
    
    var stations: [Station]? {
        didSet {
            print("start generate markers")
            var index = 0
            var normalCount = 0
            var faultyCount = 0
            var offlineCount = 0
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
                    var animationName = ""
                    if let real_health_state = station.stationRealKpi?.real_health_state {
                        if(real_health_state == 3) {
                            animationName = "locatin green"
                            normalCount = normalCount + 1
                        }
                        if(real_health_state == 2) {
                            animationName = "locatin red"
                            faultyCount = faultyCount + 1
                        }
                        if(real_health_state == 1) {
                            animationName = "locatin grey"
                            offlineCount = offlineCount + 1
                        }
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
                    clusterManager.add(marker)
                    
                }
                clusterManager.cluster()
                let allCount = normalCount + faultyCount + offlineCount
                self.statisticsMapView.allValueLabel.text = "\(allCount)"
                self.statisticsMapView.normalValueLabel.text = "\(normalCount)"
                self.statisticsMapView.faultyValueLabel.text = "\(faultyCount)"
                self.statisticsMapView.offlineValueLabel.text = "\(offlineCount)"
            }
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
        self.homeView?.showMapView(isMap: false)
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
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: googleMapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: googleMapView, algorithm: algorithm, renderer: renderer)
        clusterManager.setMapDelegate(self)
        
        self.stations = self.homeView?.homeController?.stations
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
                    if let real_health_state = station.stationRealKpi?.real_health_state {
                        if(real_health_state == 3) {
                            animationName = "locatin green tap"
                        }
                        if(real_health_state == 2) {
                            animationName = "locatin red tap"
                        }
                        if(real_health_state == 1) {
                            animationName = "locatin grey tap"
                        }
                        
                        let pointAnimation = LottieAnimation.named(animationName)
                        self.animatios[index].animation = pointAnimation
                        self.animatios[index].loopMode = .playOnce
                        self.animatios[index].play { (finished) in
                            if(real_health_state == 3) {
                                animationName = "locatin green"
                            }
                            if(real_health_state == 2) {
                                animationName = "locatin red"
                            }
                            if(real_health_state == 1) {
                                animationName = "locatin grey"
                            }
                            let pointAnimation = LottieAnimation.named(animationName)
                            self.animatios[index].animation = pointAnimation
                            self.animatios[index].loopMode = .loop
                            self.animatios[index].play()
                        }
                    }
                    
                    self.homeView?.homeController?.openPlantMapInfoView(station: station)
                }
            }
        }
        return true
    }
}




