//
//  MenuBar.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    
    let menuCellId = "menuCellId"
    
    let defoultImageName = ["home_icon","maintenance_icon","statistics_icon","profile_icon"]
    let activeImageName = ["home_icon_active","maintenance_icon_active","statistics_icon_active","profile_icon_active"]
    let titles = [NSLocalizedString("objects", comment: ""), NSLocalizedString("maintenance", comment: ""), NSLocalizedString("statistics", comment: ""), NSLocalizedString("me", comment: "")]
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
        self.homeController?.currentPage = index
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let index = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! MenuCell
        cell.index = index
        if(selectedIndehPath == index) {
            cell.isActive = true
            cell.endImage = self.defoultImageName[index]
            cell.image = self.activeImageName[index]
            cell.titleItemLabel.textColor = self.activeColor
           // cell.changeView()
           // cell.changeView(startImageName: self.defoultImageName[index], endImageName: self.activeImageName[index], color: self.activeColor)
        } else {
            cell.isActive = false
            cell.endImage = self.activeImageName[index]
            cell.image = self.defoultImageName[index]
            cell.titleItemLabel.textColor = self.defoultColor
           // cell.changeView(startImageName: self.activeImageName[index],endImageName: self.defoultImageName[index], color: self.activeColor)
        }
        cell.titleItemLabel.text = self.titles[index]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: 50.dp)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class MenuCell: UICollectionViewCell {
    
    var isActive: Bool?
    var index: Int?
    var endImage: String?
    
    var image: String? {
        didSet {
            menuItemImageView.image = UIImage(named: image ?? "")
//            self.changeView()
        }
    }
    
    lazy var menuItemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.rgb(175, green:  185, blue:  191)
        return imageView
    }()
    
    let titleItemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12.dp)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
      //  self.changeView()
    }
    
    func setupView() {
        self.addSubview(menuItemImageView)
        self.addSubview(titleItemLabel)
        
        self.addConstraintsWithFormat("H:[v0(\(24.dp))]", views: menuItemImageView)
        self.addConstraintsWithFormat("H:[v0]", views: titleItemLabel)
        
        self.addConstraintsWithFormat("V:|[v0(\(24.dp))]-\(6.dp)-[v1]", views: menuItemImageView, titleItemLabel)
        
        menuItemImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleItemLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeView() {
//        print("changeView \(index) \(endImage) \(image)")
        self.menuItemImageView.image = UIImage(named: endImage ?? "")
        if let imageName = self.image {
            if(isActive ?? false) {
                UIView.transition(with: self.menuItemImageView,
                                         duration: 1.0,
                                  options: .transitionCrossDissolve,
                                         animations: {
                    self.menuItemImageView.image = UIImage(named: imageName)
                       }, completion: nil)
            } else {
                self.menuItemImageView.image = UIImage(named: imageName)
            }
        }
    }
    
//    func changeView() {
//        let expandTransform:CGAffineTransform = CGAffineTransformMakeScale(1.15, 1.15)
//        UIView.transition(with: self.menuItemImageView,
//        duration:0.2,
//                          options: UIView.AnimationOptions.transitionCrossDissolve,
//        animations: {
//           // self.menuItemImageView.image = UIImage(named: self.image ?? "")
//          self.menuItemImageView.transform = expandTransform
//        },
//        completion: {(finished: Bool) in
//            UIView.animate(withDuration: 0.5,
//            delay:0.0,
//            usingSpringWithDamping:0.40,
//            initialSpringVelocity:0.2,
//                           options:UIView.AnimationOptions.curveEaseOut,
//            animations: {
//              self.menuItemImageView.transform = CGAffineTransformInvert(expandTransform)
//            }, completion:nil)
//      })
//    }
}
