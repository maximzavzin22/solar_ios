//
//  StatisticsPlantsView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 18/04/24.
//

import UIKit

class StatisticsPlantsView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var stations: [Station]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("current_plant_ranking", comment: "")
        label.font = .boldSystemFont(ofSize: 18.dp)
        label.textColor = .rgb(1, green: 6, blue: 10)
        return label
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
        self.layer.cornerRadius = 16.dp

        self.setupView()
        self.setupCollectionView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: titleLabel)
        self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        
        self.addConstraintsWithFormat("V:|-\(24.dp)-[v0]-\(16.dp)-[v1]|", views: titleLabel, collectionView)
    }
    
    //collectionView Setup
    func setupCollectionView() {
        collectionView.register(StatisticPlantCellView.self, forCellWithReuseIdentifier: "statisticPlantCellViewId")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stations?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statisticPlantCellViewId", for: indexPath) as! StatisticPlantCellView
        cell.index = index
        cell.station = self.stations?[index]
        if(index == (self.stations?.count ?? 0) - 1) {
            cell.seperateView.isHidden = true
        } else {
            cell.seperateView.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 54.dp)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.dp
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.dp
    }
    //collectionView Setup end
}
