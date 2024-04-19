//
//  OverviewMenuBar.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 27/07/23.
//

import UIKit

class OverviewMenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var overviewController: OverviewController?
    
    let menuCellId = "menuCellId"
    
    let defoultImageName = ["overview_icon","statistics_icon","devices_icon"]
    let activeImageName = ["overview_icon_active","statistics_icon_active","devices_icon_active"]
    let titles = [NSLocalizedString("overview", comment: ""), NSLocalizedString("statistics", comment: ""), NSLocalizedString("devices", comment: "")]
    let defoultColor = UIColor.rgb(106, green: 106, blue: 106)
    let activeColor = UIColor.rgb(39, green: 87, blue: 238)
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let bottomWhiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(241, green: 243, blue: 245)
        return view
    }()
    
    var selectedIndehPath: Int? = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuCellId)
        
        self.addSubview(collectionView)
        self.addSubview(bottomWhiteView)
        self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        self.addConstraintsWithFormat("H:|[v0]|", views: bottomWhiteView)
        self.addConstraintsWithFormat("V:|-\(16.dp)-[v0(\(50.dp))]", views: collectionView)
        self.addConstraintsWithFormat("V:[v0(\(110.dp))]", views: bottomWhiteView)
        
        bottomWhiteView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0.dp).isActive = true
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        selectedIndehPath = index
        self.collectionView.reloadData()
        self.overviewController?.currentPage = index
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let index = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! MenuCell
        if(selectedIndehPath == index) {
            cell.image = self.activeImageName[index]
            cell.titleItemLabel.textColor = self.activeColor
        } else {
            cell.image = self.defoultImageName[index]
            cell.titleItemLabel.textColor = self.defoultColor
        }
        cell.titleItemLabel.text = self.titles[index]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

