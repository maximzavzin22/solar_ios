//
//  HomeView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit

class HomeView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    var plantsCellView: PlantsCellView?
    var mapCellView: MapCellView?
    var homeStatisticsCellView: HomeStatisticsCellView?
    
    var showMap: Bool? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    let topWhiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let navigationView: HomeNavigationView = {
        let view = HomeNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(topWhiteView)
        self.addSubview(navigationView)
        self.addSubview(collectionView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topWhiteView)
        self.addConstraintsWithFormat("H:|[v0]|", views: navigationView)
        self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        
        self.addConstraintsWithFormat("V:|[v0(\(100.dp))]", views: topWhiteView)
        self.addConstraintsWithFormat("V:[v0(\(61.dp))]", views: navigationView)
        
        navigationView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        navigationView.homeView = self
        navigationView.selectePage = 0
    }
    
    //collectionView Setup
    func setupCollectionView() {
        print("setupCollectionView")
        collectionView.register(PlantsCellView.self, forCellWithReuseIdentifier: "plantsCellViewId")
        collectionView.register(MapCellView.self, forCellWithReuseIdentifier: "mapCellViewId")
        collectionView.register(HomeStatisticsCellView.self, forCellWithReuseIdentifier: "homeStatisticsCellViewId")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        //self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        if(index == 0) {
            if(showMap ?? false) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCellViewId", for: indexPath) as! MapCellView
                self.mapCellView = cell
                cell.homeView = self
                cell.setupGoogleMap()
                cell.stations = self.plantsCellView?.stations
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantsCellViewId", for: indexPath) as! PlantsCellView
                self.plantsCellView = cell
                cell.homeView = self
                cell.initKeyboard()
                return cell
            }
        }
        if(index == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeStatisticsCellViewId", for: indexPath) as! HomeStatisticsCellView
            self.homeStatisticsCellView = cell
            cell.homeView = self
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat? = collectionView.frame.height
        return CGSize(width: self.frame.width, height: height!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       // let index = Int(targetContentOffset.pointee.x / view.frame.width)
        print("scrollViewWillBeginDragging \(index)")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / self.frame.width)
        print("scrollViewWillEndDragging \(index)")
    }
    
    func scrollToMenuIndex() {
        let indexPath = IndexPath(item: (self.navigationView.selectePage ?? 0), section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.collectionView.setNeedsLayout()
    }
    //
}
