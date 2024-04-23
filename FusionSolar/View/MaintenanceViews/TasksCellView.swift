//
//  TasksCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit

class TasksCellView: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var maintenanceView: MaintenanceView?
    var inspectionTasksCellView: InspectionTasksCellView?
    var eliminationTasksCellView: EliminationTasksCellView?
    
    lazy var tasksNavigationView: TasksNavigationView = {
        let view = TasksNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tasksCellView = self
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
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(tasksNavigationView)
        self.addSubview(collectionView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: tasksNavigationView)
        self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        
        self.addConstraintsWithFormat("V:|[v0(\(68.dp))][v1]|", views: tasksNavigationView, collectionView)
        
        tasksNavigationView.selectePage = 0
    }
    
    //collectionView Setup
    func setupCollectionView() {
        print("setupCollectionView")
        collectionView.register(InspectionTasksCellView.self, forCellWithReuseIdentifier: "inspectionTasksCellViewId")
        collectionView.register(EliminationTasksCellView.self, forCellWithReuseIdentifier: "eliminationTasksCellViewId")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView.isPagingEnabled = true
//        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        if(index == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "inspectionTasksCellViewId", for: indexPath) as! InspectionTasksCellView
            self.inspectionTasksCellView = cell
            cell.tasksCellView = self
            return cell
        }
        if(index == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eliminationTasksCellViewId", for: indexPath) as! EliminationTasksCellView
            self.eliminationTasksCellView = cell
            cell.tasksCellView = self
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
        self.tasksNavigationView.selectePage = index
    }
    
    func scrollToMenuIndex() {
        let indexPath = IndexPath(item: (self.tasksNavigationView.selectePage ?? 0), section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.collectionView.setNeedsLayout()
    }
    //
}
