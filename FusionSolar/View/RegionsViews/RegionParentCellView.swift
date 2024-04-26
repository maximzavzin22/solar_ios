//
//  RegionParentCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 22/04/24.
//

import UIKit

class RegionParentCellView: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var regionsController: RegionsController?
    
    var region: Region? {
        didSet {
            if(region?.isOpen ?? false) {
                arrowImageView.transform = CGAffineTransformMakeRotation(0)
                collectionView.isHidden = false
                collectionView.reloadData()
            } else {
                arrowImageView.transform = CGAffineTransformMakeRotation(3 * Double.pi/2)
                collectionView.isHidden = true
            }
            checkBox.isActive = region?.isSelected ?? false
            titleLabel.text = region?.node_name ?? ""
        }
    }
    
    let valueContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "arrow_down")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(0, green: 0, blue: 0)
        label.font = .systemFont(ofSize: 14.dp)
        return label
    }()
    
    let checkBox: CheckBox = {
        let view = CheckBox()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        self.setupView()
        self.setupValueContentView()
        self.setupCollectionView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(valueContentView)
        self.addSubview(collectionView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: valueContentView)
        self.addConstraintsWithFormat("H:|-\(32.dp)-[v0]|", views: collectionView)
        
        self.addConstraintsWithFormat("V:|-\(8.dp)-[v0(\(20.dp))]", views: valueContentView)
        
        collectionView.topAnchor.constraint(equalTo: valueContentView.bottomAnchor, constant: 8.dp).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setupValueContentView() {
        valueContentView.addSubview(arrowImageView)
        valueContentView.addSubview(titleLabel)
        valueContentView.addSubview(checkBox)
        
        valueContentView.addConstraintsWithFormat("H:|-\(28.dp)-[v0(\(10.dp))]-\(14.dp)-[v1]-\(14.dp)-[v2(\(20.dp))]-\(28.dp)-|", views: arrowImageView, titleLabel, checkBox)
        
        valueContentView.addConstraintsWithFormat("V:[v0(\(8.dp))]", views: arrowImageView)
        valueContentView.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        valueContentView.addConstraintsWithFormat("V:[v0(\(20.dp))]", views: checkBox)
        
        arrowImageView.centerYAnchor.constraint(equalTo: valueContentView.centerYAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: valueContentView.centerYAnchor).isActive = true
        checkBox.centerYAnchor.constraint(equalTo: valueContentView.centerYAnchor).isActive = true
        
        let checkBoxTap = UITapGestureRecognizer(target: self, action: #selector(self.checkBoxPress))
        checkBox.isUserInteractionEnabled = true
        checkBox.addGestureRecognizer(checkBoxTap)
    }
    
    @objc func checkBoxPress() {
        self.region?.isSelected = !(self.region?.isSelected ?? false)
        if(self.region?.regions?.count ?? 0 > 0) {
            for regoin1 in self.region?.regions ?? [Region]() {
                regoin1.isSelected = self.region?.isSelected
                if(regoin1.regions?.count ?? 0 > 0) {
                    for regoin2 in regoin1.regions ?? [Region]() {
                        regoin2.isSelected = self.region?.isSelected
                        if(regoin2.regions?.count ?? 0 > 0) {
                            for regoin3 in regoin2.regions ?? [Region]() {
                                regoin3.isSelected = self.region?.isSelected
                            }
                        }
                    }
                }
            }
        }
        self.regionsController?.collectionView.reloadData()
    }
    
    //collectionView Setup
    func setupCollectionView() {
        collectionView.register(RegionParentCellView.self, forCellWithReuseIdentifier: "regionParentCellViewId")
        collectionView.register(RegionChildCellView.self, forCellWithReuseIdentifier: "regionChildCellViewId")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.region?.regions?.count ?? 0
        return count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        if let childRegion = self.region?.regions?[index] {
            if(childRegion.regions?.count ?? 0 > 0) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "regionParentCellViewId", for: indexPath) as! RegionParentCellView
                cell.region = childRegion
                cell.regionsController = self.regionsController
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "regionChildCellViewId", for: indexPath) as! RegionChildCellView
                cell.region = childRegion
                cell.regionsController = self.regionsController
                return cell
            }
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let index = indexPath.item
        var height: CGFloat = 0.0
        if let childRegion = self.region?.regions?[index] {
            if(childRegion.regions?.count ?? 0 > 0) {
                height = height + 36.dp
                if(childRegion.isOpen ?? false) {
                    for region1 in childRegion.regions ?? [Region]() {
                        height = height + 36.dp
                        if(region1.isOpen ?? false) {
                            for region2 in region1.regions ?? [Region]() {
                                height = height + 36.dp
                                if(region2.isOpen ?? false) {
                                    for _ in region2.regions ?? [Region]() {
                                        height = height + 36.dp
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                height = height + 36.dp
            }
        }
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.dp
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.dp
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        if let region = self.region?.regions?[index] {
            if(region.regions?.count ?? 0 > 0) {
                region.isOpen = !(region.isOpen ?? false)
                self.regionsController?.collectionView.reloadData()
            }
        }
    }
    //collectionView Setup end
}
