//
//  OverviewView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 27/07/23.
//

import UIKit
import Lottie

class OverviewView: UIView {
    
    var overviewController: OverviewController?
    
    var station: Station? {
        didSet {
            
        }
    }
    
    var alarm: Alarm? {
        didSet {
            self.statusView.alarm = alarm
        }
    }
    
    var realKpi: StationRealKpi? {
        didSet {
            if(realKpi != nil) {
                emptyView.isHidden = true
                animationView.isHidden = false
                pvLabel.isHidden = false
                pvContentView.isHidden = false
                loadLabel.isHidden = false
                gridLabel.isHidden = false
                if let real_health_state = realKpi?.real_health_state {
                    statusView.status = real_health_state
                    if(real_health_state == 1) {
                        animationView.animation = LottieAnimation.named("3 shara off")
                        self.pvValueLabel.textColor = .white
                        self.pvIconImageView.image = UIImage(named: "ic_pv_white")
                    }
                    if(real_health_state == 2) {
                        animationView.animation = LottieAnimation.named("3 shara faulty")
                        self.pvValueLabel.textColor = .rgb(1, green: 6, blue: 10)
                        self.pvIconImageView.image = UIImage(named: "ic_pv")
                    }
                    if(real_health_state == 3) {
                        animationView.animation = LottieAnimation.named("3 shara")
                        self.pvValueLabel.textColor = .rgb(1, green: 6, blue: 10)
                        self.pvIconImageView.image = UIImage(named: "ic_pv")
                    }
                    animationView.play()
                }
                self.pvValueLabel.text = "\(realKpi?.day_power ?? 0.0)\n\(NSLocalizedString("kw", comment: ""))"
                self.yieldValueOverviewView.valueLabel.text = "\(realKpi?.day_power ?? 0.00)"
                self.revenueValueOverviewView.valueLabel.text = "\(realKpi?.day_income ?? 0.00)"
                self.initBigValueOverviewView()
            } else {
                emptyView.isHidden = false
                animationView.isHidden = true
                pvLabel.isHidden = true
                pvContentView.isHidden = true
                loadLabel.isHidden = true
                gridLabel.isHidden = true
            }
        }
    }
    
    var weather: Weather? {
        didSet {
            self.weatherView.weather = weather
        }
    }
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "overlay")
        return imageView
    }()
    
    //topView
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let weatherView: WeatherView = {
        let view = WeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let plantDetailButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let image = UIImage(named: "btn_arrow")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitle(NSLocalizedString("plant_details", comment: ""), for: .normal)
        button.titleLabel?.textColor = .rgb(106, green: 106, blue: 106)
        button.titleLabel?.font = .systemFont(ofSize: 16.dp)
        button.tintColor = .rgb(106, green: 106, blue: 106)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 7.dp, bottom: 0, right: -7.dp)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -7.dp, bottom: 0, right: 7.dp)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 7.dp, bottom: 0, right: 7.dp)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    //
    
    lazy var statusView: StatusOverviewView = {
        let view = StatusOverviewView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.overviewView = self
        return view
    }()
    
    let emptyView: EmptyDataView = {
        let view = EmptyDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //animationView
    let animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.animationSpeed = 1.0
        view.loopMode = .loop
        return view
    }()
    
    let pvLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("pv", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let loadLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("load", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let gridLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("grid", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    //pvContentView
    let pvContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
       // view.backgroundColor = .green
        return view
    }()
    
    let pvIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_pv")
        return imageView
    }()
    
    let pvValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 12.dp)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    //
    //
    
    //bottomView
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let yieldValueOverviewView: ValueOverviewView = {
        let view = ValueOverviewView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.iconImageView.image = UIImage(named: "stat_1")
        view.nameLabel.text = NSLocalizedString("overview_yield_today", comment: "")
        view.parametrLabel.text = NSLocalizedString("kwh", comment: "")
        view.valueLabel.text = "0.00"
        return view
    }()
    
    let revenueValueOverviewView: ValueOverviewView = {
        let view = ValueOverviewView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.iconImageView.image = UIImage(named: "stat_2")
        view.nameLabel.text = NSLocalizedString("overview_revenue_today", comment: "")
        view.parametrLabel.text = NSLocalizedString("$", comment: "")
        view.valueLabel.text = "0.00"
        return view
    }()
    
    let bigValueOverviewView: BigValueOverviewView = {
        let view = BigValueOverviewView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //
    
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
        self.setupAnimationView()
        self.setupBottomView()
        self.initBigValueOverviewView()
        
        emptyView.isHidden = false
        animationView.isHidden = true
        pvLabel.isHidden = true
        pvContentView.isHidden = true
        loadLabel.isHidden = true
        gridLabel.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(backgroundImageView)
        self.addSubview(topView)
        self.addSubview(statusView)
        self.addSubview(emptyView)
        self.addSubview(animationView)
        self.addSubview(bottomView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: backgroundImageView)
        self.addConstraintsWithFormat("H:|[v0]|", views: topView)
        self.addConstraintsWithFormat("H:|[v0]|", views: statusView)
        self.addConstraintsWithFormat("H:[v0(\(143.dp))]", views: emptyView)
        self.addConstraintsWithFormat("H:[v0(\(390.dp))]", views: animationView)
        self.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: bottomView)
        
        self.addConstraintsWithFormat("V:|[v0(\(734.dp))]", views: backgroundImageView)
        self.addConstraintsWithFormat("V:[v0(\(44.dp))]", views: topView)
        self.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: statusView)
        self.addConstraintsWithFormat("V:[v0(\(154.dp))]", views: emptyView)
        self.addConstraintsWithFormat("V:[v0(\(390.dp))]", views: animationView)
        self.addConstraintsWithFormat("V:[v0(\(148.dp))]|", views: bottomView)
        
        emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bottomView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        topView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 55.dp).isActive = true
        statusView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 4.dp).isActive = true
        emptyView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 4.dp).isActive = true
    }
    
    func setupTopView() {
        topView.addSubview(weatherView)
        topView.addSubview(plantDetailButton)
        
        topView.addConstraintsWithFormat("H:|-\(24.dp)-[v0(\(150.dp))]", views: weatherView)
        topView.addConstraintsWithFormat("H:[v0]-\(24.dp)-|", views: plantDetailButton)
        
        topView.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: weatherView)
        topView.addConstraintsWithFormat("V:|[v0]|", views: plantDetailButton)
        
        weatherView.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        
        plantDetailButton.addTarget(self, action: #selector(self.plantDetailButtonPress), for: .touchUpInside)
    }
    
    @objc func plantDetailButtonPress() {
        self.overviewController?.openBasicInfoController()
    }
    
    func setupAnimationView() {
        animationView.addSubview(pvLabel)
        self.addSubview(pvContentView)
        pvContentView.addSubview(pvIconImageView)
        pvContentView.addSubview(pvValueLabel)
        animationView.addSubview(loadLabel)
        animationView.addSubview(gridLabel)
        
        animationView.addConstraintsWithFormat("H:[v0]", views: pvLabel)
        self.addConstraintsWithFormat("H:[v0(\(70.dp))]", views: pvContentView)
        pvContentView.addConstraintsWithFormat("H:[v0(\(26.dp))]", views: pvIconImageView)
        pvContentView.addConstraintsWithFormat("H:|-\(6.dp)-[v0]-\(6.dp)-|", views: pvValueLabel)
        animationView.addConstraintsWithFormat("H:[v0]", views: loadLabel)
        animationView.addConstraintsWithFormat("H:[v0]", views: gridLabel)
        
        animationView.addConstraintsWithFormat("V:[v0]", views: pvLabel)
        self.addConstraintsWithFormat("V:[v0(\(70.dp))]", views: pvContentView)
        pvContentView.addConstraintsWithFormat("V:|-\(6.dp)-[v0(\(28.dp))]-\(6.dp)-[v1]", views: pvIconImageView, pvValueLabel)
        
        pvLabel.centerXAnchor.constraint(equalTo: animationView.centerXAnchor).isActive = true
        pvContentView.centerXAnchor.constraint(equalTo: animationView.centerXAnchor).isActive = true
        pvIconImageView.centerXAnchor.constraint(equalTo: pvContentView.centerXAnchor).isActive = true
        pvValueLabel.centerXAnchor.constraint(equalTo: pvContentView.centerXAnchor).isActive = true
        loadLabel.centerXAnchor.constraint(equalTo: animationView.leftAnchor, constant: 75.dp).isActive = true
        gridLabel.centerXAnchor.constraint(equalTo: animationView.rightAnchor, constant: -75.dp).isActive = true
        
        pvLabel.topAnchor.constraint(equalTo: animationView.topAnchor, constant: 15.dp).isActive = true
        pvContentView.topAnchor.constraint(equalTo: animationView.topAnchor, constant: 50.dp).isActive = true
        loadLabel.bottomAnchor.constraint(equalTo: animationView.bottomAnchor, constant: -15.dp).isActive = true
        gridLabel.bottomAnchor.constraint(equalTo: animationView.bottomAnchor, constant: -10.dp).isActive = true
    }
    
    func setupBottomView() {
        bottomView.addSubview(yieldValueOverviewView)
        bottomView.addSubview(revenueValueOverviewView)
        bottomView.addSubview(bigValueOverviewView)
        
        bottomView.addConstraintsWithFormat("H:|[v0(\(174.dp))]", views: yieldValueOverviewView)
        bottomView.addConstraintsWithFormat("H:[v0(\(174.dp))]|", views: revenueValueOverviewView)
        bottomView.addConstraintsWithFormat("H:|[v0]|", views: bigValueOverviewView)
        
        bottomView.addConstraintsWithFormat("V:|[v0(\(70.dp))]", views: yieldValueOverviewView)
        bottomView.addConstraintsWithFormat("V:|[v0(\(70.dp))]", views: revenueValueOverviewView)
        bottomView.addConstraintsWithFormat("V:[v0(\(70.dp))]|", views: bigValueOverviewView)
    }
    
    func initBigValueOverviewView() {
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 20.dp),  NSAttributedString.Key.paragraphStyle: style]
        let attrs1: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16.dp), NSAttributedString.Key.paragraphStyle: style]
        
        let attString: NSMutableAttributedString = NSMutableAttributedString(string: "\(realKpi?.month_power ?? 0.00)", attributes: attrs)
        let attrString1 = NSAttributedString(string: " \(NSLocalizedString("kwh", comment: ""))", attributes: attrs1)
        attString.append(attrString1)
        self.bigValueOverviewView.monthBigValueOverviewCellView.valueLabel.attributedText = attString
        
        let attString2: NSMutableAttributedString = NSMutableAttributedString(string: "\(realKpi?.total_power ?? 0.00)", attributes: attrs)
        let attrString3 = NSAttributedString(string: " \(NSLocalizedString("kwh", comment: ""))", attributes: attrs1)
        attString2.append(attrString3)
        self.bigValueOverviewView.yearBigValueOverviewCellView.valueLabel.attributedText = attString2
        
        let attString4: NSMutableAttributedString = NSMutableAttributedString(string: "\(realKpi?.total_power ?? 0.00)", attributes: attrs)
        let attrString5 = NSAttributedString(string: " \(NSLocalizedString("kwh", comment: ""))", attributes: attrs1)
        attString4.append(attrString5)
        self.bigValueOverviewView.totalBigValueOverviewCellView.valueLabel.attributedText = attString4
    }
    
    //ApiService
    func fetchStations() {
        if let stationCodes = self.station?.plantCode {
            self.showLoadingView()
            ApiService.sharedInstance.fetchStationRealKpi(stationCodes: stationCodes) {
                (error: CustomError?, realKpis: [StationRealKpi]?) in
                self.hideLoadingView()
                if(error?.code ?? 0 == 0) {
                    if(realKpis?.count ?? 0 > 0) {
                        self.realKpi = realKpis?[0]
                    }
                } else {
                    //error
                }
            }
        }
    }
    //
    
    func showLoadingView() {
        self.addSubview(loadingView)
        self.addConstraintsWithFormat("H:|[v0]|", views: loadingView)
        loadingView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        loadingView.isHidden = false
        loadingView.startActivityIndicator()
    }
    
    func hideLoadingView() {
        loadingView.stopActivityIndicator()
        loadingView.isHidden = true
    }
    
    func generateKpi() { //for test
        var realKpi = StationRealKpi()
        realKpi.real_health_state = 3
        realKpi.total_power = 74.88
        realKpi.day_income = 0.00
        realKpi.day_power = 122.4
        realKpi.month_power = 13.89
        realKpi.total_income = 0.0
        self.realKpi = realKpi

        var weather = Weather()
        weather.status = 1
        weather.startTemp = 32
        weather.endTemp = 43
        self.weather = weather
        
//        var alarm1 = Alarm()
//        alarm1.alarmCause = "An unrecoverable fault has occurred in the internal circuit of the device."
//        alarm1.alarmId = 2064
//        alarm1.alarmName = "The device is abnormal."
//        alarm1.alarmType = 2
//        alarm1.causeId = 5
//        alarm1.devName = "Inverter-1"
//        alarm1.devTypeId = 38
//        alarm1.esnCode = "Inverter05"
//        alarm1.lev = 1
//        alarm1.raiseTime = 1667179861000
//        alarm1.repairSuggestion = "Turn off the AC and DC switches, wait for 5 minutes, and then turn on the AC and DC switches. If the fault persists, contact your dealer or technical support."
//        alarm1.stationCode = "NE=33554792"
//        alarm1.stationName = "hzhStation02"
//        alarm1.status = 1
//        self.alarm = alarm1
    }
}

class StatusOverviewView: UIView {
    
    var overviewView: OverviewView?
    
    var status: Int? {
        didSet {
            if let value = status {
                if(value == 1) {
                    borderView.backgroundColor = .rgb(215, green: 228, blue: 237)
                    statusLabel.text = NSLocalizedString("offline", comment: "")
                    statusLabel.textColor = .rgb(106, green: 106, blue: 106)
                    fonStatusView.backgroundColor = .rgb(207, green: 219, blue: 231)
                    alarmLabel.textColor = .rgb(106, green: 106, blue: 106)
                }
                if(value == 2) {
                    borderView.backgroundColor = .rgb(228, green: 214, blue: 227)
                    statusLabel.text = NSLocalizedString("faulty", comment: "")
                    statusLabel.textColor = .rgb(224, green: 69, blue: 76)
                    fonStatusView.backgroundColor = .rgb(234, green: 195, blue: 214)
                    alarmLabel.textColor = .rgb(224, green: 69, blue: 76)
                }
                if(value == 3) {
                    borderView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                    statusLabel.text = NSLocalizedString("normal", comment: "")
                    statusLabel.textColor = .rgb(84, green: 164, blue: 110)
                    fonStatusView.backgroundColor = .rgb(215, green: 234, blue: 239)
                }
            }
        }
    }
    
    var alarm: Alarm? {
        didSet {
            self.alarmLabel.isHidden = false
            self.arrowImageView.isHidden = false
            self.alarmLabel.text = alarm?.alarmName ?? ""
        }
    }
    
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16.dp
        return view
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 12.dp)
        return label
    }()
    
    let fonStatusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4.dp
        return view
    }()
    
    let alarmLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 14.dp)
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "btn_arrow")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(borderView)
        borderView.addSubview(fonStatusView)
        borderView.addSubview(statusLabel)
        borderView.addSubview(alarmLabel)
        borderView.addSubview(arrowImageView)
        
        self.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: borderView)
        borderView.addConstraintsWithFormat("H:|-\(21.dp)-[v0]-\(20.dp)-[v1]-\(7.dp)-[v2(\(9.dp))]-\(12.dp)-|", views: statusLabel, alarmLabel, arrowImageView)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: borderView)
        borderView.addConstraintsWithFormat("V:[v0]", views: statusLabel)
        borderView.addConstraintsWithFormat("V:[v0]", views: alarmLabel)
        borderView.addConstraintsWithFormat("V:[v0(\(14.dp))]", views: arrowImageView)
        borderView.addConstraintsWithFormat("V:[v0(\(22.dp))]", views: fonStatusView)
        
        borderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fonStatusView.leftAnchor.constraint(equalTo: statusLabel.leftAnchor, constant: -8.dp).isActive = true
        fonStatusView.rightAnchor.constraint(equalTo: statusLabel.rightAnchor, constant: 8.dp).isActive = true
        
        statusLabel.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
        alarmLabel.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
        fonStatusView.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor).isActive = true
        
        alarmLabel.isHidden = true
        arrowImageView.isHidden = true
        
        let borderViewTap = UITapGestureRecognizer(target: self, action: #selector(self.borderViewPress))
        borderView.isUserInteractionEnabled = true
        borderView.addGestureRecognizer(borderViewTap)
    }
    
    @objc func borderViewPress() {
        if let alarm = self.alarm {
            self.overviewView?.overviewController?.openAlarmDetailController(alarm: alarm)
        }
    }
}

class ValueOverviewView: UIView {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 20.dp)
        return label
    }()
    
    let parametrLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 12.dp)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 14.dp)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(iconImageView)
        self.addSubview(valueLabel)
        self.addSubview(parametrLabel)
        self.addSubview(nameLabel)
        
        self.addConstraintsWithFormat("H:|-\(12.dp)-[v0(\(44.dp))]-\(8.dp)-[v1]-\(2.dp)-[v2]", views: iconImageView, valueLabel, parametrLabel)
        self.addConstraintsWithFormat("H:|-\(64.dp)-[v0]|", views: nameLabel)
        
        self.addConstraintsWithFormat("V:|-\(8.dp)-[v0(\(44.dp))]", views: iconImageView)
        self.addConstraintsWithFormat("V:|-\(16.dp)-[v0]-\(2.dp)-[v1]", views: valueLabel, nameLabel)
        self.addConstraintsWithFormat("V:[v0]", views: parametrLabel)
        
        parametrLabel.topAnchor.constraint(equalTo: valueLabel.topAnchor).isActive = true
    }
}

class BigValueOverviewView: UIView {
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let monthBigValueOverviewCellView: BigValueOverviewCellView = {
        let view = BigValueOverviewCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = (NSLocalizedString("yield_this_month", comment: ""))
        return view
    }()
    
    let yearBigValueOverviewCellView: BigValueOverviewCellView = {
        let view = BigValueOverviewCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = (NSLocalizedString("yield_this_year", comment: ""))
        return view
    }()
    
    let totalBigValueOverviewCellView: BigValueOverviewCellView = {
        let view = BigValueOverviewCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = (NSLocalizedString("yield_this_total", comment: ""))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(contentView)
        contentView.addSubview(monthBigValueOverviewCellView)
        contentView.addSubview(yearBigValueOverviewCellView)
        contentView.addSubview(totalBigValueOverviewCellView)
        
        self.addConstraintsWithFormat("H:[v0(\(324.dp))]", views: contentView)
        contentView.addConstraintsWithFormat("H:|[v0(\(102.dp))]-\(9.dp)-[v1(\(102.dp))]-\(9.dp)-[v2(\(102.dp))]", views: monthBigValueOverviewCellView, yearBigValueOverviewCellView, totalBigValueOverviewCellView)
        
        self.addConstraintsWithFormat("V:[v0(\(35.dp))]", views: contentView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: monthBigValueOverviewCellView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: yearBigValueOverviewCellView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: totalBigValueOverviewCellView)
        
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

class BigValueOverviewCellView: UIView {
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.textAlignment = .center
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(valueLabel)
        self.addSubview(nameLabel)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: valueLabel)
        self.addConstraintsWithFormat("H:|[v0]|", views: nameLabel)
        
        self.addConstraintsWithFormat("V:|[v0][v1]", views: valueLabel, nameLabel)
    }
}
