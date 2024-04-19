//
//  MaintenanceView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit

class MaintenanceView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    var alarmsCellView: AlarmsCellView?
    
    let topWhiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
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
        self.addSubview(collectionView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topWhiteView)
        self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        
        self.addConstraintsWithFormat("V:|[v0(\(100.dp))]", views: topWhiteView)

        collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    //collectionView Setup
    func setupCollectionView() {
        print("setupCollectionView")
        collectionView.register(AlarmsCellView.self, forCellWithReuseIdentifier: "alarmsCellViewId")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        if(index == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alarmsCellViewId", for: indexPath) as! AlarmsCellView
            self.alarmsCellView = cell
            cell.maintenanceView = self
            cell.initKeyboard()
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
    //
    
    
}
