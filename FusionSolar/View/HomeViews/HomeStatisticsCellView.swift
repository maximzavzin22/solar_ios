//
//  HomeStatisticsCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit
import Lottie

class HomeStatisticsCellView: UICollectionViewCell {
    
    var homeView: HomeView?
    
    var height: CGFloat = 1
    
    var stations: [Station]? {
        didSet {
            var count = stations?.count ?? 0
            if(count > 5) {
                count = 5
            }
            height = CGFloat(count) * 70.dp + 21.dp + 24.dp + 16.dp
            plantsViewHeightConstraint?.constant = height
            self.setScrollViewHeight()
            self.layoutIfNeeded()
            self.plantsView.stations = stations
        }
    }
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        return scrollView
    }()
    
    //topView
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let topContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let powerHomeStatisticsTopView: HomeStatisticsTopView = {
        let view = HomeStatisticsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("current_power", comment: "")
        view.valueLabel.text = "0.00"
        view.parametrLabel.text = NSLocalizedString("kw", comment: "")
        return view
    }()
    
    let revenueHomeStatisticsTopView: HomeStatisticsTopView = {
        let view = HomeStatisticsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("revenue_today", comment: "")
        view.valueLabel.text = "0.00"
        view.parametrLabel.text = "$"
        return view
    }()
    
    let todayHomeStatisticsTopView: HomeStatisticsTopView = {
        let view = HomeStatisticsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("yield_today", comment: "")
        view.valueLabel.text = "0.00"
        view.parametrLabel.text = NSLocalizedString("kwh", comment: "")
        return view
    }()
    
    let totalHomeStatisticsTopView: HomeStatisticsTopView = {
        let view = HomeStatisticsTopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("total_yield", comment: "")
        view.valueLabel.text = "0.00"
        view.parametrLabel.text = NSLocalizedString("mwh", comment: "")
        return view
    }()
    //
    
    //graphView
    let graphView: GraphView = {
        let view = GraphView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //
    
    //plantsView
    var plantsViewHeightConstraint: NSLayoutConstraint?
    let plantsView: StatisticsPlantsView = {
        let view = StatisticsPlantsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //
    
    let environmentalView: EnvironmentalView = {
        let view = EnvironmentalView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .rgb(241, green: 243, blue: 245)

        self.setupView()
        self.setupTopView()
        
        self.fetchTopStations()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(contentScrollView)
        
        contentScrollView.addSubview(topView)
        contentScrollView.addSubview(graphView)
        contentScrollView.addSubview(plantsView)
        contentScrollView.addSubview(environmentalView)
        
        self.addConstraintsWithFormat("H:[v0(\(390.dp))]", views: contentScrollView)
        contentScrollView.addConstraintsWithFormat("H:[v0(\(390.dp))]", views: topView)
        contentScrollView.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: graphView)
        contentScrollView.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: plantsView)
        contentScrollView.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: environmentalView)
        
        contentScrollView.addConstraintsWithFormat("V:[v0(\(196.dp))]", views: topView)
        contentScrollView.addConstraintsWithFormat("V:[v0(\(434.dp))]", views: graphView)
        contentScrollView.addConstraintsWithFormat("V:[v0(\(218.dp))]", views: environmentalView)
        
        contentScrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        graphView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        plantsView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        environmentalView.centerXAnchor.constraint(equalTo: contentScrollView.centerXAnchor).isActive = true
        
        contentScrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        topView.topAnchor.constraint(equalTo: contentScrollView.topAnchor).isActive = true
        graphView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16.dp).isActive = true
        plantsView.topAnchor.constraint(equalTo: graphView.bottomAnchor, constant: 16.dp).isActive = true
        environmentalView.topAnchor.constraint(equalTo: plantsView.bottomAnchor, constant: 16.dp).isActive = true
        
        height = 24.dp + 24.dp + 21.dp
        plantsViewHeightConstraint = plantsView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: self.height)[0]
        plantsViewHeightConstraint?.isActive = true
        
        self.setScrollViewHeight()
        
        self.graphView.homeStatisticsCellView = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    func setScrollViewHeight() {
        let contentScrollViewHeight = 196.dp + 16.dp + 434.dp + 16.dp + height + 16.dp + 218.dp + 16.dp
        self.contentScrollView.contentSize = CGSize(width: 390.dp, height: contentScrollViewHeight)
    }
    
    func setupTopView() {
        topView.addSubview(topContentView)
        topContentView.addSubview(powerHomeStatisticsTopView)
        topContentView.addSubview(revenueHomeStatisticsTopView)
        topContentView.addSubview(todayHomeStatisticsTopView)
        topContentView.addSubview(totalHomeStatisticsTopView)
        
        topView.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: topContentView)
        topContentView.addConstraintsWithFormat("H:|[v0(\(175.dp))]-\(10.dp)-[v1(\(175.dp))]", views: powerHomeStatisticsTopView, todayHomeStatisticsTopView)
        topContentView.addConstraintsWithFormat("H:|[v0(\(175.dp))]-\(10.dp)-[v1(\(175.dp))]", views: revenueHomeStatisticsTopView, totalHomeStatisticsTopView)
        
        topView.addConstraintsWithFormat("V:|-\(24.dp)-[v0(\(156.dp))]", views: topContentView)
        topContentView.addConstraintsWithFormat("V:|[v0(\(73.dp))]-\(10.dp)-[v1(\(73.dp))]", views: powerHomeStatisticsTopView, revenueHomeStatisticsTopView)
        topContentView.addConstraintsWithFormat("V:|[v0(\(73.dp))]-\(10.dp)-[v1(\(73.dp))]", views: todayHomeStatisticsTopView, totalHomeStatisticsTopView)
        
        topContentView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
    }
    
    //ApiService
    func fetchTopStations() {
        ApiService.sharedInstance.fetchTopStations() {
            (error: CustomError?, stations: [Station]?) in
            if(error?.code ?? 0 == 0) {
                self.stations = stations
            } else {
                //error
            }
        }
    }
    //
}

class HomeStatisticsTopView: UIView {
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 20.dp)
        return label
    }()
    
    let parametrLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .boldSystemFont(ofSize: 18.dp)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .rgb(245, green: 244, blue: 244)
        self.layer.cornerRadius = 16.dp

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(valueLabel)
        self.addSubview(parametrLabel)
        self.addSubview(titleLabel)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(4.dp)-[v1]", views: valueLabel, parametrLabel)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: titleLabel)
        
        self.addConstraintsWithFormat("V:|-\(16.dp)-[v0]-\(4.dp)-[v1]", views: valueLabel, titleLabel)
        self.addConstraintsWithFormat("V:[v0]", views: parametrLabel)
        
        parametrLabel.bottomAnchor.constraint(equalTo: valueLabel.bottomAnchor).isActive = true
    }
}

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
        print("setupCollectionView")
        collectionView.register(StatisticPlantCellView.self, forCellWithReuseIdentifier: "statisticPlantCellViewId")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = self.stations?.count ?? 0
        if(count > 5) {
            count = 5
        }
        return count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statisticPlantCellViewId", for: indexPath) as! StatisticPlantCellView
        cell.index = index
        cell.station = self.stations?[index]
        if(index == (self.stations?.count ?? 0) - 1) {
            cell.seperateView.isHidden = true//true
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Press")
        let index = indexPath.item
    }
    //collectionView Setup end
}

class EnvironmentalView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("environmental_benefits", comment: "")
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 18.dp)
        return label
    }()
    
    //contentView
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coalEnvironmentalCellView: EnvironmentalCellView = {
        let view = EnvironmentalCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.valueLabel.text = "0.00 \(NSLocalizedString("t", comment: ""))"
        view.titleLabel.text = NSLocalizedString("standard_coal_saved", comment: "")
        view.backgroundColor = .rgb(208, green: 232, blue: 255)
        view.iconImageView.image = UIImage(named: "image_1")
        view.animatioName = "stroyka"
        return view
    }()
    
    let co2EnvironmentalCellView: EnvironmentalCellView = {
        let view = EnvironmentalCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.valueLabel.text = "0.00 \(NSLocalizedString("t", comment: ""))"
        view.titleLabel.text = NSLocalizedString("co2_reduced", comment: "")
        view.backgroundColor = .rgb(255, green: 236, blue: 217)
        view.iconImageView.image = UIImage(named: "image_2")
        view.animatioName = "zavod"
        return view
    }()
    
    let treesEnvironmentalCellView: EnvironmentalCellView = {
        let view = EnvironmentalCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.valueLabel.text = "0"
        view.titleLabel.text = NSLocalizedString("equivalent_trees_planted", comment: "")
        view.backgroundColor = .rgb(198, green: 255, blue: 218)
        view.iconImageView.image = UIImage(named: "image_3")
        view.animatioName = "ELKI 2"
        return view
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp

        self.setupView()
        self.setupContentView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
 
    func setupView() {
        self.addSubview(titleLabel)
        self.addSubview(contentView)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: titleLabel)
        self.addConstraintsWithFormat("H:[v0(\(320.dp))]", views: contentView)
        
        self.addConstraintsWithFormat("V:|-\(24.dp)-[v0]-\(19.dp)-[v1(\(130.dp))]", views: titleLabel, contentView)
        
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func setupContentView() {
        contentView.addSubview(coalEnvironmentalCellView)
        contentView.addSubview(co2EnvironmentalCellView)
        contentView.addSubview(treesEnvironmentalCellView)
        
        contentView.addConstraintsWithFormat("H:|[v0(\(100.dp))]-\(10.dp)-[v1(\(100.dp))]-\(10.dp)-[v2(\(100.dp))]", views: coalEnvironmentalCellView, co2EnvironmentalCellView, treesEnvironmentalCellView)
        
        contentView.addConstraintsWithFormat("V:|[v0]|", views: coalEnvironmentalCellView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: co2EnvironmentalCellView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: treesEnvironmentalCellView)
    }
}

class EnvironmentalCellView: UIView {
    
    var animatioName: String? {
        didSet {
            if let name = animatioName {
                animationView.animation = LottieAnimation.named(name)
                animationView.play()
            }
        }
    }
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(0, green: 0, blue: 0)
        label.font = .boldSystemFont(ofSize: 18.dp)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.numberOfLines = 0
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let animationView: LottieAnimationView = {
        let view = LottieAnimationView()//LottieAnimationView.init(name: "ELKI 2")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.animationSpeed = 0.7
        view.loopMode = .loop
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.cornerRadius = 16.dp
        self.layer.masksToBounds = true

        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
//        self.addSubview(iconImageView)
        self.addSubview(animationView)
        self.addSubview(valueLabel)
        self.addSubview(titleLabel)
        
        self.addConstraintsWithFormat("H:|-\(12.dp)-[v0]", views: valueLabel)
        self.addConstraintsWithFormat("H:|-\(12.dp)-[v0]-\(12.dp)-|", views: titleLabel)
//        self.addConstraintsWithFormat("H:|[v0]|", views: iconImageView)
        self.addConstraintsWithFormat("H:|[v0(\(100.dp))]|", views: animationView)
        
        self.addConstraintsWithFormat("V:|-\(16.dp)-[v0]-\(6.dp)-[v1]", views: valueLabel, titleLabel)
//        self.addConstraintsWithFormat("V:[v0(\(100.dp))]|", views: iconImageView)
        self.addConstraintsWithFormat("V:[v0(\(100.dp))]|", views: animationView)
        
        animationView.play()
    }
}
 
