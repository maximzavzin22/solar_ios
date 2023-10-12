//
//  PlantsCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit

class PlantsCellView: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    var homeView: HomeView?
    
    var pageNo = 1
    
    var allCount: Int? {
        didSet {
            allPlantsTopView.valueLabel.text = "\(allCount ?? 0)"
        }
    }
    
    var normalCount: Int? {
        didSet {
            normalPlantsTopView.valueLabel.text = "\(normalCount ?? 0)"
        }
    }
    
    var faultyCount: Int? {
        didSet {
            faultyPlantsTopView.valueLabel.text = "\(faultyCount ?? 0)"
        }
    }
    
    var offlineCount: Int? {
        didSet {
            offlinePlantsTopView.valueLabel.text = "\(offlineCount ?? 0)"
        }
    }
    
    var filter: String? {
        didSet {
            if let value = filter {
                if(value == "all") {
                    self.showStations = stations
                } else {
                    var showStations = [Station]()
                    if let stations = self.stations {
                        for station in stations {
                            if(value == "normal") {
                                if(station.status ?? 0 == 1) {
                                    showStations.append(station)
                                }
                            }
                            if(value == "faulty") {
                                if(station.status ?? 0 == 2) {
                                    showStations.append(station)
                                }
                            }
                            if(value == "offline") {
                                if(station.status ?? 0 == 3) {
                                    showStations.append(station)
                                }
                            }
                        }
                    }
                    self.showStations = showStations
                }
                
            }
        }
    }
    
    var showStations: [Station]? {
        didSet {
            if let count = self.stations?.count {
                if(count > 0) {
                    emptyView.isHidden = true
                    collectionView.isHidden = false
                } else {
                    emptyView.isHidden = false
                    collectionView.isHidden = true
                }
            }
            self.collectionView.reloadData()
        }
    }
    
    var isLoadEnd = false
    var stations: [Station]? {
        didSet {
            self.showStations = stations
            self.allCount = self.stations?.count ?? 0
            if let stations = self.stations {
                var normalCount = 0
                var faultyCount = 0
                var offlineCount = 0
                for station in stations {
                    if let status = station.status {
                        if(status == 1) {
                            normalCount = (normalCount ?? 0) + 1
                        }
                        if(status == 2) {
                            faultyCount = (faultyCount ?? 0) + 1
                        }
                        if(status == 3) {
                            offlineCount = (offlineCount ?? 0) + 1
                        }
                    }
                }
                self.normalCount = normalCount
                self.faultyCount = faultyCount
                self.offlineCount = offlineCount
            }
        }
    }
    
    var isFilter: Bool? {
        didSet {
            if(isFilter ?? false) {
                print("isFilter true")
                let image = UIImage(named: "filter_active")?.withRenderingMode(.alwaysOriginal)
                filterButton.setImage(image, for: .normal)
            } else {
                print("isFilter false")
                let image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal)
                filterButton.setImage(image, for: .normal)
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
    
    //plantsTopView
    let plantsTopView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let allPlantsTopView: PlantsTopView = {
        let view = PlantsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelect = true
        view.titleLabel.text = NSLocalizedString("all", comment: "")
        view.valueLabel.text = "0"
        view.valueLabel.textColor = .rgb(0, green: 0, blue: 0)
        return view
    }()
    
    let normalPlantsTopView: PlantsTopView = {
        let view = PlantsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelect = false
        view.titleLabel.text = NSLocalizedString("normal", comment: "")
        view.valueLabel.text = "0"
        view.valueLabel.textColor = .rgb(84, green: 164, blue: 110)
        return view
    }()
    
    let faultyPlantsTopView: PlantsTopView = {
        let view = PlantsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelect = false
        view.titleLabel.text = NSLocalizedString("faulty", comment: "")
        view.valueLabel.text = "0"
        view.valueLabel.textColor = .rgb(224, green: 69, blue: 76)
        return view
    }()
    
    let offlinePlantsTopView: PlantsTopView = {
        let view = PlantsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelect = false
        view.titleLabel.text = NSLocalizedString("offline", comment: "")
        view.valueLabel.text = "0"
        view.valueLabel.textColor = .rgb(106, green: 106, blue: 106)
        return view
    }()
    //
    
    //searchView
    let searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let plantsSearchView: PlantsSearchView = {
        let view = PlantsSearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    //
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
    
    let emptyView: EmptyDataView = {
        let view = EmptyDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mapButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 24.dp
        let image = UIImage(named: "map")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let loadingView: LoadingView = {
        let lV = LoadingView()
        lV.translatesAutoresizingMaskIntoConstraints = false
        return lV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .rgb(241, green: 243, blue: 245)

        self.setupView()
        self.setupTopView()
        self.setupPlantsTopView()
        self.setupSearchView()
        self.setupCollectionView()
        
      //  self.fetchStations()
    }
    
    func initKeyboard() {
        self.homeView?.homeController?.setupToolbar()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(topView)
        self.addSubview(emptyView)
        self.addSubview(collectionView)
        self.addSubview(mapButton)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topView)
        self.addConstraintsWithFormat("H:[v0(\(143.dp))]", views: emptyView)
        self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        self.addConstraintsWithFormat("H:[v0(\(48.dp))]-\(24.dp)-|", views: mapButton)
        
        self.addConstraintsWithFormat("V:|[v0(\(156.dp))][v1]|", views: topView, collectionView)
        self.addConstraintsWithFormat("V:[v0(\(154.dp))]", views: emptyView)
        self.addConstraintsWithFormat("V:[v0(\(48.dp))]-\(18.dp)-|", views: mapButton)
        
        emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        mapButton.addTarget(self, action: #selector(self.mapButtonPress), for: .touchUpInside)
    }
    
    @objc func mapButtonPress() {
        self.homeView?.showMap = true
    }
    
    func setupTopView() {
        topView.addSubview(plantsTopView)
        topView.addSubview(searchView)
        
        topView.addConstraintsWithFormat("H:[v0(\(359.dp))]", views: plantsTopView)
        topView.addConstraintsWithFormat("H:[v0(\(359.dp))]", views: searchView)
        
        topView.addConstraintsWithFormat("V:|-\(16.dp)-[v0(\(60.dp))]-\(16.dp)-[v1(\(48.dp))]", views: plantsTopView, searchView)
        
        plantsTopView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        searchView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
    }
    
    func setupPlantsTopView() {
        plantsTopView.addSubview(allPlantsTopView)
        plantsTopView.addSubview(normalPlantsTopView)
        plantsTopView.addSubview(faultyPlantsTopView)
        plantsTopView.addSubview(offlinePlantsTopView)
        
        plantsTopView.addConstraintsWithFormat("H:|[v0(\(86.dp))]-\(5.dp)-[v1(\(86.dp))]-\(5.dp)-[v2(\(86.dp))]-\(5.dp)-[v3(\(86.dp))]", views: allPlantsTopView, normalPlantsTopView, faultyPlantsTopView, offlinePlantsTopView)
        
        plantsTopView.addConstraintsWithFormat("V:|[v0]|", views: allPlantsTopView)
        plantsTopView.addConstraintsWithFormat("V:|[v0]|", views: normalPlantsTopView)
        plantsTopView.addConstraintsWithFormat("V:|[v0]|", views: faultyPlantsTopView)
        plantsTopView.addConstraintsWithFormat("V:|[v0]|", views: offlinePlantsTopView)
        
        let allPlantsTopViewTap = UITapGestureRecognizer(target: self, action: #selector(self.allPlantsTopViewPress))
        allPlantsTopView.isUserInteractionEnabled = true
        allPlantsTopView.addGestureRecognizer(allPlantsTopViewTap)
        
        let normalPlantsTopViewTap = UITapGestureRecognizer(target: self, action: #selector(self.normalPlantsTopViewPress))
        normalPlantsTopView.isUserInteractionEnabled = true
        normalPlantsTopView.addGestureRecognizer(normalPlantsTopViewTap)
        
        let faultyPlantsTopViewTap = UITapGestureRecognizer(target: self, action: #selector(self.faultyPlantsTopViewPress))
        faultyPlantsTopView.isUserInteractionEnabled = true
        faultyPlantsTopView.addGestureRecognizer(faultyPlantsTopViewTap)
        
        let offlinePlantsTopViewTap = UITapGestureRecognizer(target: self, action: #selector(self.offlinePlantsTopViewPress))
        offlinePlantsTopView.isUserInteractionEnabled = true
        offlinePlantsTopView.addGestureRecognizer(offlinePlantsTopViewTap)
    }
    
    @objc func allPlantsTopViewPress() {
        self.disactiveAll()
        allPlantsTopView.isSelect = true
        self.filter = "all"
    }
    
    @objc func normalPlantsTopViewPress() {
        self.disactiveAll()
        normalPlantsTopView.isSelect = true
        self.filter = "normal"
    }
    
    @objc func faultyPlantsTopViewPress() {
        self.disactiveAll()
        faultyPlantsTopView.isSelect = true
        self.filter = "faulty"
    }
    
    @objc func offlinePlantsTopViewPress() {
        self.disactiveAll()
        offlinePlantsTopView.isSelect = true
        self.filter = "offline"
    }
    
    func disactiveAll() {
        allPlantsTopView.isSelect = false
        normalPlantsTopView.isSelect = false
        faultyPlantsTopView.isSelect = false
        offlinePlantsTopView.isSelect = false
    }
    
    func setupSearchView() {
        searchView.addSubview(plantsSearchView)
        searchView.addSubview(filterButton)
        
        searchView.addConstraintsWithFormat("H:|[v0(\(321.dp))]-\(15.dp)-[v1(\(24.dp))]", views: plantsSearchView, filterButton)
        
        searchView.addConstraintsWithFormat("V:|[v0]|", views: plantsSearchView)
        searchView.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: filterButton)
        
        filterButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        
        filterButton.addTarget(self, action: #selector(self.filterButtonPress), for: .touchUpInside)
        
        plantsSearchView.plantsCellView = self
    }
    
    @objc func filterButtonPress() {
        print("filterButtonPress")
        self.homeView?.homeController?.openPlantsFilterView()
    }
    
    //collectionView Setup
    func setupCollectionView() {
        print("setupCollectionView")
        collectionView.register(PlantCellView.self, forCellWithReuseIdentifier: "plantCellViewId")
        collectionView.contentInset = UIEdgeInsets(top: 16.dp, left: 0, bottom: 66.dp, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 16.dp, left: 0, bottom: 66.dp, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.showStations?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "plantCellViewId", for: indexPath) as! PlantCellView
        cell.station = self.showStations?[index]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 117.dp)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.dp
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.dp
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Press")
        let index = indexPath.item
        if let station = self.showStations?[index] {
            self.homeView?.homeController?.openOverviewController(station: station)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var index = indexPath.item
        if(showStations?.count ?? 0 > 0 && index > 0) {
            if (index == (showStations?.count ?? 0) - 1 ) { //it's your last cell
                if(!isLoadEnd) {
                //    self.fetchStations()
                }
            }
        }
        
    }
    //collectionView Setup end
    
    //ApiService
    func fetchStations() {
//        self.generateData()
        self.showLoadingView()
        ApiService.sharedInstance.fetchStations(pageNo: self.pageNo) {
            (error: CustomError?, stations: [Station]?) in
            self.hideLoadingView()
            if(error?.code ?? 0 == 0) {
                if(self.stations == nil) {
                    self.stations = stations
                } else {
                    if let newStations = stations {
                        self.stations?.append(contentsOf: newStations)
                    }
                }
                if(stations?.count ?? 0 == 0) {
                    self.isLoadEnd = true
                }
                self.pageNo = self.pageNo + 1
                dump(stations)
            } else {
                //error
            }
        }
    }
    //
    
    func showLoadingView() {
        self.addSubview(loadingView)
        self.addConstraintsWithFormat("H:|[v0]|", views: loadingView)
        loadingView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        loadingView.isHidden = false
        loadingView.startActivityIndicator()
    }
    
    func hideLoadingView() {
        loadingView.stopActivityIndicator()
        loadingView.isHidden = true
    }
    
    //for test
    func generateData() {
        var stations = [Station]()
        
        var station1 = Station()
        station1.capacity = 0.0
        station1.contactMethod = "zavmax92@gmail.com"
        station1.contactPerson = ""
        station1.gridConnectionDate = "2023-07-18T14:06:27+05:00"
        station1.latitude = "41.3281172"
        station1.longitude = "69.2953415"
        station1.plantAddress = "42 O\'zbekiston Ovozi ko\'chasi, Узбекистан"
        station1.plantCode = "NE=33695851"
        station1.plantName = "Фарғона Вилоят перинатал маркази 100"
        station1.status = 1
        stations.append(station1)
        
        var station2 = Station()
        station2.capacity = 0.0
        station2.contactMethod = "zavmax92@gmail.com"
        station2.contactPerson = "Max"
        station2.gridConnectionDate = "2023-07-18T14:06:27+05:00"
        station2.latitude = "41.2937107"
        station2.longitude = "69.3561711"
        station2.plantAddress = "42 O\'zbekiston Ovozi ko\'chasi, Узбекистан"
        station2.plantCode = "NE=33696229"
        station2.plantName = "Жиззах вилояти юқумли касалликлар шифохонаси 50"
        station2.status = 1
        stations.append(station2)
        
        var station3 = Station()
        station3.capacity = 0.0
        station3.contactMethod = "zavmax92@gmail.com"
        station3.contactPerson = "Max"
        station3.gridConnectionDate = "2023-07-18T14:06:27+05:00"
        station3.latitude = "41.3562168"
        station3.longitude = "69.37427"
        station3.plantAddress = "42 O\'zbekiston Ovozi ko\'chasi, Узбекистан"
        station3.plantCode = "NE=33696229"
        station3.plantName = "Жиззах вилояти юқумли касалликлар шифохонаси 50"
        station3.status = 2
        stations.append(station3)
        
        var station4 = Station()
        station4.capacity = 0.0
        station4.contactMethod = "zavmax92@gmail.com"
        station4.contactPerson = "Max"
        station4.gridConnectionDate = "2023-07-18T14:06:27+05:00"
        station4.latitude = "41.3854563"
        station4.longitude = "69.2520689"
        station4.plantAddress = "42 O\'zbekiston Ovozi ko\'chasi, Узбекистан"
        station4.plantCode = "NE=33696229"
        station4.plantName = "Жиззах вилояти юқумли касалликлар шифохонаси 50"
        station4.status = 3
        stations.append(station4)
        
        self.stations = stations
    }
    //
}

class PlantsTopView: UIView {
    
    var isSelect: Bool? {
        didSet {
            if(isSelect ?? false) {
                self.backgroundColor = .rgb(239, green: 244, blue: 254)
                self.layer.borderColor = UIColor.rgb(101, green: 142, blue: 245).cgColor
                self.layer.borderWidth = 1.dp
            } else {
                self.backgroundColor = .rgb(245, green: 244, blue: 244)
                self.layer.borderWidth = 0.dp
            }
        }
    }
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20.dp)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 12.dp)
        label.textColor = .rgb(106, green: 106, blue: 106)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .rgb(245, green: 244, blue: 244)
        self.layer.cornerRadius = 16.dp
        
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(valueLabel)
        self.addSubview(titleLabel)
        
        self.addConstraintsWithFormat("H:[v0]", views: valueLabel)
        self.addConstraintsWithFormat("H:[v0]", views: titleLabel)
        
        self.addConstraintsWithFormat("V:|-\(10.dp)-[v0]", views: valueLabel)
        self.addConstraintsWithFormat("V:[v0]-\(10.dp)-|", views: titleLabel)
        
        valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}

class PlantsSearchView: UIView {
    
    var plantsCellView: PlantsCellView?
    
    var isEditing: Bool? {
        didSet {
            if(isEditing ?? false) {
                clearButton.isHidden = false
                groupFilterButton.isHidden = true
            } else {
                clearButton.isHidden = true
                groupFilterButton.isHidden = false
            }
        }
    }
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 45.dp, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 52.dp, height: textField.frame.height))
        textField.rightView = rightPaddingView
        textField.rightViewMode = UITextField.ViewMode.always
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18.dp), .foregroundColor: UIColor.rgb(106, green: 106, blue: 106)]
        textField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("platns_search", comment: ""), attributes: attrs)
        textField.textColor = .rgb(1, green: 6, blue: 10)
        textField.font = UIFont.systemFont(ofSize: 18.dp)
        textField.textAlignment = .left
        textField.backgroundColor = .rgb(245, green: 244, blue: 244)
        textField.layer.cornerRadius = 24.dp
        return textField
    }()
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_search")
        return imageView
    }()
    
    let groupFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "btn")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "delete")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(searchTextField)
        self.addSubview(searchImageView)
        self.addSubview(groupFilterButton)
        self.addSubview(clearButton)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: searchTextField)
        self.addConstraintsWithFormat("H:|-\(17.dp)-[v0(\(20.dp))]", views: searchImageView)
        self.addConstraintsWithFormat("H:[v0(\(48.dp))]-\(2.dp)-|", views: groupFilterButton)
        self.addConstraintsWithFormat("H:[v0(\(48.dp))]-\(2.dp)-|", views: clearButton)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: searchTextField)
        self.addConstraintsWithFormat("V:[v0(\(20.dp))]", views: searchImageView)
        self.addConstraintsWithFormat("V:|[v0]|", views: groupFilterButton)
        self.addConstraintsWithFormat("V:|[v0]|", views: clearButton)
        
        searchImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        searchTextField.addTarget(self, action: #selector(searchTextFieldChaged), for: .allEditingEvents)
        groupFilterButton.addTarget(self, action: #selector(self.groupFilterButtonPress), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(self.clearButtonPress), for: .touchUpInside)
        
        clearButton.isHidden = true
    }
    
    @objc func searchTextFieldChaged() {
        print("searchTextFieldChaged")
        if let text = searchTextField.text {
            if(text != "") {
                self.isEditing = true
            }
        }
    }
    
    @objc func groupFilterButtonPress() {
        print("groupFilterButtonPress")
    }
    
    @objc func clearButtonPress() {
        print("clearButtonPress")
        self.searchTextField.text = ""
        self.isEditing = false
        self.plantsCellView?.homeView?.homeController?.doneButtonAction()
    }
}
