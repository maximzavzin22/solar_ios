//
//  HomeView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit

class HomeView: UIView {
    
    var homeController: HomeController?
    
    var showMap: Bool? {
        didSet {
            
        }
    }
    
    let topWhiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var plantsView: PlantsView = {
        let view = PlantsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.homeView = self
        view.initKeyboard()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(topWhiteView)
        self.addSubview(plantsView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topWhiteView)
        self.addConstraintsWithFormat("H:|[v0]|", views: plantsView)
        
        self.addConstraintsWithFormat("V:|[v0(\(100.dp))]", views: topWhiteView)
        
        plantsView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        plantsView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
//
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let index = indexPath.item
//        if(index == 0) {
//            if(showMap ?? false) {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCellViewId", for: indexPath) as! MapCellView
//                self.mapCellView = cell
//                cell.homeView = self
//                cell.setupGoogleMap()
//                cell.stations = self.plantsCellView?.stations
//                return cell
//            } else {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantsCellViewId", for: indexPath) as! PlantsCellView
//                self.plantsCellView = cell
//                cell.homeView = self
//                cell.initKeyboard()
//                return cell
//            }
//        }
//        if(index == 1) {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeStatisticsCellViewId", for: indexPath) as! HomeStatisticsCellView
//            self.homeStatisticsCellView = cell
//            cell.homeView = self
//            return cell
//        }
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
//        return cell
//    }
    
}
