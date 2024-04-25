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
            if let capacity = station?.capacity {
                if(capacity < 1000) {
                    self.overviewAnimationView.pvValueLabel.text = "\(capacity.rounded(toPlaces: 3))\n\(NSLocalizedString("kw", comment: ""))" //надо понять что это
                } else {
                    if(capacity < 1000000) {
                        self.overviewAnimationView.pvValueLabel.text = "\((capacity/1000.0).rounded(toPlaces: 3))\n\(NSLocalizedString("mw", comment: ""))" //надо понять что это
                    } else {
                        self.overviewAnimationView.pvValueLabel.text = "\((capacity/1000000.0).rounded(toPlaces: 3))\n\(NSLocalizedString("gw", comment: ""))" //надо понять что это
                    }
                }
                
            }
            if let stationRealKpi = station?.stationRealKpi {
                emptyView.isHidden = true
                overviewAnimationView.isHidden = false
                overviewAnimationView.real_health_state = stationRealKpi.real_health_state
                statusView.status = stationRealKpi.real_health_state
                
                if let day_power = stationRealKpi.day_power {
                    if(day_power < 1000) {
                        self.yieldValueOverviewView.valueLabel.text = "\(day_power.rounded(toPlaces: 2))"
                        self.yieldValueOverviewView.parametrLabel.text = NSLocalizedString("kwh", comment: "")
                    } else {
                        if (day_power < 1000000) {
                            self.yieldValueOverviewView.valueLabel.text = "\((day_power/1000.0).rounded(toPlaces: 2))"
                            self.yieldValueOverviewView.parametrLabel.text = NSLocalizedString("mwh", comment: "")
                        } else {
                            self.yieldValueOverviewView.valueLabel.text = "\((day_power/1000000.0).rounded(toPlaces: 2))"
                            self.yieldValueOverviewView.parametrLabel.text = NSLocalizedString("gwh", comment: "")
                        }
                    }
                }
                self.revenueValueOverviewView.valueLabel.text = "\((stationRealKpi.day_income ?? 0.00).rounded(toPlaces: 2))"
                self.initBigValueOverviewView(realKpi: stationRealKpi)
            } else {
                emptyView.isHidden = false
                overviewAnimationView.isHidden = true
            }
            if(station?.alarms?.count ?? 0 > 0) {
                self.alarm = station?.alarms?.last
            }
            
        }
    }
    
    var alarm: Alarm? {
        didSet {
            self.statusView.alarm = alarm
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
    
    lazy var overviewAnimationView: OverviewAnimationView = {
        let view = OverviewAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        self.setupBottomView()
        
        emptyView.isHidden = false
        overviewAnimationView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(backgroundImageView)
        self.addSubview(topView)
        self.addSubview(statusView)
        self.addSubview(emptyView)
        self.addSubview(overviewAnimationView)
        self.addSubview(bottomView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: backgroundImageView)
        self.addConstraintsWithFormat("H:|[v0]|", views: topView)
        self.addConstraintsWithFormat("H:|[v0]|", views: statusView)
        self.addConstraintsWithFormat("H:[v0(\(143.dp))]", views: emptyView)
        self.addConstraintsWithFormat("H:[v0(\(390.dp))]", views: overviewAnimationView)
        self.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: bottomView)
        
        self.addConstraintsWithFormat("V:|[v0(\(734.dp))]", views: backgroundImageView)
        self.addConstraintsWithFormat("V:[v0(\(44.dp))]", views: topView)
        self.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: statusView)
        self.addConstraintsWithFormat("V:[v0(\(154.dp))]", views: emptyView)
        self.addConstraintsWithFormat("V:[v0(\(390.dp))]", views: overviewAnimationView)
        self.addConstraintsWithFormat("V:[v0(\(148.dp))]|", views: bottomView)
        
        emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        overviewAnimationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bottomView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        topView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 55.dp).isActive = true
        statusView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 4.dp).isActive = true
        emptyView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        if(UIScreen.main.bounds.height/UIScreen.main.bounds.width < 16/9) {
            overviewAnimationView.transform = CGAffineTransformMakeScale(1.5, 1.5)
        }
        overviewAnimationView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 16.dp).isActive = true
    }
    
    func setupTopView() {
        topView.addSubview(plantDetailButton)
        topView.addConstraintsWithFormat("H:[v0]-\(24.dp)-|", views: plantDetailButton)
        topView.addConstraintsWithFormat("V:|[v0]|", views: plantDetailButton)
        plantDetailButton.addTarget(self, action: #selector(self.plantDetailButtonPress), for: .touchUpInside)
    }
    
    @objc func plantDetailButtonPress() {
        self.overviewController?.openBasicInfoController()
    }
    
    func setupBottomView() {
        bottomView.addSubview(yieldValueOverviewView)
        bottomView.addSubview(revenueValueOverviewView)
        bottomView.addSubview(bigValueOverviewView)
        
        bottomView.addConstraintsWithFormat("H:|[v0]|", views: bigValueOverviewView)
        
        bottomView.addConstraintsWithFormat("V:|[v0(\(70.dp))]", views: yieldValueOverviewView)
        bottomView.addConstraintsWithFormat("V:|[v0(\(70.dp))]", views: revenueValueOverviewView)
        bottomView.addConstraintsWithFormat("V:[v0(\(70.dp))]|", views: bigValueOverviewView)
        
        yieldValueOverviewView.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true
        yieldValueOverviewView.rightAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: -9.dp).isActive = true
        revenueValueOverviewView.leftAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 9.dp).isActive = true
        revenueValueOverviewView.rightAnchor.constraint(equalTo: bottomView.rightAnchor).isActive = true
    }
    
    func initBigValueOverviewView(realKpi: StationRealKpi) {
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 20.dp),  NSAttributedString.Key.paragraphStyle: style]
        let attrs1: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16.dp), NSAttributedString.Key.paragraphStyle: style]
        
        var monthPowerStr = ""
        var monthPowerParametr = ""
        var totalPowerStr = ""
        var totalPowerParametr = ""
        
        if let month_power = realKpi.month_power {
            if(month_power < 1000) {
                monthPowerStr = "\(month_power.rounded(toPlaces: 2))"
                monthPowerParametr = NSLocalizedString("kwh", comment: "")
            } else {
                if(month_power < 1000000) {
                    monthPowerStr = "\((month_power/1000.0).rounded(toPlaces: 2))"
                    monthPowerParametr = NSLocalizedString("mwh", comment: "")
                } else {
                    monthPowerStr = "\((month_power/1000000.0).rounded(toPlaces: 2))"
                    monthPowerParametr = NSLocalizedString("gwh", comment: "")
                }
            }
        }
        
        if let total_power = realKpi.total_power {
            if(total_power < 1000) {
                totalPowerStr = "\(total_power.rounded(toPlaces: 2))"
                totalPowerParametr = NSLocalizedString("kwh", comment: "")
            } else {
                if(total_power < 1000000) {
                    totalPowerStr = "\((total_power/1000.0).rounded(toPlaces: 2))"
                    totalPowerParametr = NSLocalizedString("mwh", comment: "")
                } else {
                    totalPowerStr = "\((total_power/1000000.0).rounded(toPlaces: 2))"
                    totalPowerParametr = NSLocalizedString("gwh", comment: "")
                }
            }
        }
        
        let attString: NSMutableAttributedString = NSMutableAttributedString(string: monthPowerStr, attributes: attrs)
        let attrString1 = NSAttributedString(string: " \(monthPowerParametr)", attributes: attrs1)
        attString.append(attrString1)
        self.bigValueOverviewView.monthBigValueOverviewCellView.valueLabel.attributedText = attString
        
        let attString2: NSMutableAttributedString = NSMutableAttributedString(string: totalPowerStr, attributes: attrs)
        let attrString3 = NSAttributedString(string: " \(totalPowerParametr)", attributes: attrs1)
        attString2.append(attrString3)
        self.bigValueOverviewView.yearBigValueOverviewCellView.valueLabel.attributedText = attString2
        
        let attString4: NSMutableAttributedString = NSMutableAttributedString(string: totalPowerStr, attributes: attrs)
        let attrString5 = NSAttributedString(string: " \(totalPowerParametr)", attributes: attrs1)
        attString4.append(attrString5)
        self.bigValueOverviewView.totalBigValueOverviewCellView.valueLabel.attributedText = attString4
    }
}

