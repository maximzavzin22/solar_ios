//
//  RegionsController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 19/04/24.
//

import UIKit

class RegionsController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    
    var regions: [Region]? {
        didSet {
            if(regions != nil) {
                var showRegions = [Region]()
                for region in regions! {
                    if(region.is_parent ?? false) {
                        var childRegions = [Region]()
                        for childRegion in regions! {
                            if(childRegion.parent_dn == region.element_dn) {
                                childRegions.append(childRegion)
                            }
                        }
                        region.regions = childRegions
                    }
                    if(region.parent_dn ?? "" == "/") {
                        region.isOpen = true
                        showRegions.append(region)
                    }
                }
                self.showRegions = showRegions
            }
        }
    }
    
    var showRegions: [Region]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    //headeView
    let headeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "back")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 24.dp)
        label.text = NSLocalizedString("select_plant", comment: "")
        return label
    }()
    //
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    //buttonsView
    let buttonsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .rgb(228, green: 228, blue: 228)
        button.setTitle(NSLocalizedString("reset", comment: ""), for: .normal)
        button.titleLabel?.textColor = .rgb(39, green: 87, blue: 238)
        button.titleLabel?.font = .systemFont(ofSize: 18.dp)
        button.tintColor = .rgb(39, green: 87, blue: 238)
        button.layer.cornerRadius = 21.dp
        return button
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .rgb(39, green: 87, blue: 238)
        button.setTitle(NSLocalizedString("confirm", comment: ""), for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18.dp)
        button.tintColor = .white
        button.layer.cornerRadius = 21.dp
        return button
    }()
    //
    
    let errorView: SimpleErrorView = {
        let eV = SimpleErrorView()
        eV.translatesAutoresizingMaskIntoConstraints = false
        return eV
    }()

    let loadingView: LoadingView = {
        let lV = LoadingView()
        lV.translatesAutoresizingMaskIntoConstraints = false
        return lV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupHeaderView()
        self.setupButtonsView()
        self.setupCollectionView()
        
        if(self.homeController?.regions == nil) {
            self.fetchRegions()
        } else {
            self.regions = self.homeController?.regions
        }
    }
    
    func setupView() {
        self.view.addSubview(headeView)
        self.view.addSubview(collectionView)
        self.view.addSubview(buttonsView)
        
        self.view.addConstraintsWithFormat("H:|-\(8.dp)-[v0]-\(24.dp)-|", views: headeView)
        self.view.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: collectionView)
        self.view.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: buttonsView)
        
        self.view.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: headeView)
        self.view.addConstraintsWithFormat("V:[v0(\(58.dp))]", views: buttonsView)
        
        headeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6.dp).isActive = true
        buttonsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: headeView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.buttonsView.topAnchor).isActive = true
    }
    
    func setupHeaderView() {
        headeView.addSubview(backButton)
        headeView.addSubview(titleLabel)
        
        headeView.addConstraintsWithFormat("H:|-\(8.dp)-[v0(\(46.dp))][v1]|", views: backButton, titleLabel)
        
        headeView.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: backButton)
        headeView.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        
        backButton.centerYAnchor.constraint(equalTo: headeView.centerYAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: headeView.centerYAnchor).isActive = true
        
        backButton.addTarget(self, action: #selector(self.backButtonPress), for: .touchUpInside)
    }
    
    @objc func backButtonPress() {
        self.dismiss(animated: true)
    }
    
    func setupButtonsView() {
        buttonsView.addSubview(resetButton)
        buttonsView.addSubview(confirmButton)
        
        buttonsView.addConstraintsWithFormat("V:[v0(\(42.dp))]", views: resetButton)
        buttonsView.addConstraintsWithFormat("V:[v0(\(42.dp))]", views: confirmButton)
        
        resetButton.leftAnchor.constraint(equalTo: buttonsView.leftAnchor).isActive = true
        resetButton.rightAnchor.constraint(equalTo: buttonsView.centerXAnchor, constant: -9.dp).isActive = true
        confirmButton.leftAnchor.constraint(equalTo: buttonsView.centerXAnchor, constant: 9.dp).isActive = true
        confirmButton.rightAnchor.constraint(equalTo: buttonsView.rightAnchor).isActive = true
        
        resetButton.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor).isActive = true
        confirmButton.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor).isActive = true
        
        resetButton.addTarget(self, action: #selector(self.resetButtonPress), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(self.confirmButtonPress), for: .touchUpInside)
    }
    
    @objc func resetButtonPress() {
        if let regions = self.regions {
            for region in regions {
                region.isSelected = false
                self.homeController?.homeView.plantsView.selectedRegions = nil
            }
        }
        self.backButtonPress()
    }
    
    @objc func confirmButtonPress() {
        if let regions = self.regions {
            var selectedRegions = [Region]()
            for region in regions {
                if(region.isSelected ?? false) {
                    selectedRegions.append(region)
                }
            }
            self.homeController?.homeView.plantsView.selectedRegions = selectedRegions
        }
        self.backButtonPress()
    }
    
    //collectionView Setup
    func setupCollectionView() {
        collectionView.register(RegionParentCellView.self, forCellWithReuseIdentifier: "regionParentCellViewId")
        collectionView.contentInset = UIEdgeInsets(top: 16.dp, left: 0, bottom: 66.dp, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 16.dp, left: 0, bottom: 66.dp, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.showRegions?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "regionParentCellViewId", for: indexPath) as! RegionParentCellView
        cell.region = self.showRegions?[index]
        cell.regionsController = self
        cell.layer.cornerRadius = 16.dp
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0.0
        for region1 in self.showRegions ?? [Region]() {
            height = height + 36.dp
            if(region1.isOpen ?? false) {
                for region2 in region1.regions ?? [Region]() {
                    height = height + 36.dp
                    if(region2.isOpen ?? false) {
                        for region3 in region2.regions ?? [Region]() {
                            height = height + 36.dp
                            if(region3.isOpen ?? false) {
                                for region4 in region3.regions ?? [Region]() {
                                    height = height + 36.dp
                                }
                            }
                        }
                    }
                }
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
        self.showRegions?[index].isOpen = !(self.showRegions?[index].isOpen ?? false)
        self.collectionView.reloadData()
    }
    //collectionView Setup end
    
    //ApiService
    func fetchRegions() {
        self.showLoadingView()
        ApiService.sharedInstance.fetchRegions() {
            (error: CustomError?, regions: [Region]?) in
            self.hideLoadingView()
            if(error?.code ?? 0 == 0) {
                self.regions = regions
                self.homeController?.regions = regions
            } else {
                //error
            }
        }
    }
    //
    
    //Error and Loading views
    func showErrorView(title: String, message: String) {
        self.view.addSubview(errorView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: errorView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: errorView)
        errorView.isHidden = false
        errorView.title = title
        errorView.message = message
    }
    
    func showLoadingView() {
        self.view.addSubview(loadingView)
        self.view.addConstraintsWithFormat("H:|[v0]|", views: loadingView)
        self.view.addConstraintsWithFormat("V:|[v0]|", views: loadingView)
        loadingView.isHidden = false
        loadingView.startActivityIndicator()
    }
    
    func hideLoadingView() {
        loadingView.stopActivityIndicator()
        loadingView.isHidden = true
    }
    //
}
