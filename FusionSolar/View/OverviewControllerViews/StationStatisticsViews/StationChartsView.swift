//
//  StationChartsView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 27/07/23.
//

import UIKit
import DGCharts

class StationChartsView: UIView {
    
    var stationStatisticsView: StationStatisticsView?
    
    var selectedDate: Date? {
        didSet {
            print("selectedDate \(selectedDate)")
            self.setupSelectedDate()
            self.stationStatisticsView?.getDataForGraph()
        }
    }
    
    var selectedDateType: String? {
        didSet {
            self.selectedDate = Date()
        }
    }
    
    var yieldTotal: Double? {
        didSet {
            if let value = yieldTotal {
                let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 26.dp), NSAttributedString.Key.foregroundColor: UIColor.rgb(1, green: 6, blue: 10)]
                let attrs1: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14.dp), NSAttributedString.Key.foregroundColor: UIColor.rgb(106, green: 106, blue: 106)]
                if(value < 1000.0) {
                    let attString: NSMutableAttributedString = NSMutableAttributedString(string: "\(value.rounded(toPlaces: 2))", attributes: attrs)
                    let attrString1 = NSAttributedString(string: " \(NSLocalizedString("kwh", comment: ""))", attributes: attrs1)
                    attString.append(attrString1)
                    yieldValueLabel.attributedText = attString
                } else {
                    if(value < 1000000.0) {
                        let attString: NSMutableAttributedString = NSMutableAttributedString(string: "\((value/1000.0).rounded(toPlaces: 2))", attributes: attrs)
                        let attrString1 = NSAttributedString(string: " \(NSLocalizedString("mwh", comment: ""))", attributes: attrs1)
                        attString.append(attrString1)
                        yieldValueLabel.attributedText = attString
                    } else {
                        let attString: NSMutableAttributedString = NSMutableAttributedString(string: "\((value/1000000.0).rounded(toPlaces: 2))", attributes: attrs)
                        let attrString1 = NSAttributedString(string: " \(NSLocalizedString("gwh", comment: ""))", attributes: attrs1)
                        attString.append(attrString1)
                        yieldValueLabel.attributedText = attString
                    }
                }
                
            }
        }
    }
    
    var revenueTotal: Double? {
        didSet {
            if let value = revenueTotal {
                let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 26.dp), NSAttributedString.Key.foregroundColor: UIColor.rgb(1, green: 6, blue: 10)]
                let attrs1: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14.dp), NSAttributedString.Key.foregroundColor: UIColor.rgb(106, green: 106, blue: 106)]
                
                if(value < 1000.0) {
                    let attString: NSMutableAttributedString = NSMutableAttributedString(string: "\(value.rounded(toPlaces: 2))", attributes: attrs)
                    let attrString1 = NSAttributedString(string: " \(NSLocalizedString("$", comment: ""))", attributes: attrs1)
                    attString.append(attrString1)
                    revenueValueLabel.attributedText = attString
                } else {
                    let attString: NSMutableAttributedString = NSMutableAttributedString(string: "\((value/1000.0).rounded(toPlaces: 2))k", attributes: attrs)
                    let attrString1 = NSAttributedString(string: " \(NSLocalizedString("$", comment: ""))", attributes: attrs1)
                    attString.append(attrString1)
                    revenueValueLabel.attributedText = attString
                }
            }
        }
    }
    
    //dateSwitcherView
    let dateSwitcherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(241, green: 243, blue: 245)
        view.layer.cornerRadius = 18.dp
        return view
    }()
    
    let dayView: GraphDayView = {
        let view = GraphDayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("day", comment: "")
        view.isSelected = true
        view.value = "day"
        return view
    }()
    
    let mounthView: GraphDayView = {
        let view = GraphDayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("month", comment: "")
        view.isSelected = false
        view.value = "month"
        return view
    }()
    
    let yearView: GraphDayView = {
        let view = GraphDayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("year", comment: "")
        view.isSelected = false
        view.value = "year"
        return view
    }()
    
    let lifetimeView: GraphDayView = {
        let view = GraphDayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("lifetime", comment: "")
        view.isSelected = false
        view.value = "lifetime"
        return view
    }()
    //
    
    //selectedDateView
    let selectedDateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "arrow_left")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "arrow_right")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    var selectedDateValueViewWidthConstraint: NSLayoutConstraint?
    let selectedDateValueView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let selectedDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 16.dp)
        return label
    }()
    
    let arrowDownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "arrow_down")
        return imageView
    }()
    //
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("energy_management", comment: "")
        label.font = .boldSystemFont(ofSize: 18.dp)
        label.textColor = .rgb(1, green: 6, blue: 10)
        return label
    }()
    
    //yieldView
    let yieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let yieldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("yield", comment: "")
        label.font = .systemFont(ofSize: 14.dp)
        label.textColor = .rgb(1, green: 6, blue: 10)
        return label
    }()
    
    let questionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "help_icon")
        return imageView
    }()
    //
    
    let yieldValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 26.dp), NSAttributedString.Key.foregroundColor: UIColor.rgb(1, green: 6, blue: 10)]
        let attrs1: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14.dp), NSAttributedString.Key.foregroundColor: UIColor.rgb(106, green: 106, blue: 106)]
        let attString: NSMutableAttributedString = NSMutableAttributedString(string: "0.00", attributes: attrs)
        let attrString1 = NSAttributedString(string: " \(NSLocalizedString("kwh", comment: ""))", attributes: attrs1)
        attString.append(attrString1)
        label.attributedText = attString
        return label
    }()
    
    let fullScreenView: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .rgb(241, green: 243, blue: 245)
        button.layer.cornerRadius = 4.dp
        let image = UIImage(named: "zoom")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitle(NSLocalizedString("full_screen", comment: ""), for: .normal)
        button.titleLabel?.textColor = .rgb(1, green: 6, blue: 10)
        button.titleLabel?.font = .systemFont(ofSize: 12.dp)
        button.tintColor = .rgb(1, green: 6, blue: 10)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4.dp, bottom: 0, right: 4.dp)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -4.dp, bottom: 0, right: 4.dp)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8.dp, bottom: 0, right: 8.dp)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    let yieldParametrLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12.dp)
        label.textColor = .rgb(106, green: 106, blue: 106)
        return label
    }()

    let barChartView: BarChartView = {
        let view = BarChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.noDataText = NSLocalizedString("no_data_available", comment: "")
        view.noDataTextColor = .rgb(106, green: 106, blue: 106)
        view.noDataFont = .systemFont(ofSize: 18.dp)
        return view
    }()
    
    //revenue
    
    let revenueTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("revenue", comment: "")
        label.font = .boldSystemFont(ofSize: 18.dp)
        label.textColor = .rgb(1, green: 6, blue: 10)
        return label
    }()
    
    let totalRevenueTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("total_revenue", comment: "")
        label.font = .systemFont(ofSize: 14.dp)
        label.textColor = .rgb(1, green: 6, blue: 10)
        return label
    }()
    
    let revenueValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 26.dp), NSAttributedString.Key.foregroundColor: UIColor.rgb(1, green: 6, blue: 10)]
        let attrs1: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14.dp), NSAttributedString.Key.foregroundColor: UIColor.rgb(106, green: 106, blue: 106)]
        let attString: NSMutableAttributedString = NSMutableAttributedString(string: "0.00", attributes: attrs)
        let attrString1 = NSAttributedString(string: " \(NSLocalizedString("$", comment: ""))", attributes: attrs1)
        attString.append(attrString1)
        label.attributedText = attString
        return label
    }()
    
    let revenueFullScreenView: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .rgb(241, green: 243, blue: 245)
        button.layer.cornerRadius = 4.dp
        let image = UIImage(named: "zoom")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitle(NSLocalizedString("full_screen", comment: ""), for: .normal)
        button.titleLabel?.textColor = .rgb(1, green: 6, blue: 10)
        button.titleLabel?.font = .systemFont(ofSize: 12.dp)
        button.tintColor = .rgb(1, green: 6, blue: 10)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4.dp, bottom: 0, right: 4.dp)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -4.dp, bottom: 0, right: 4.dp)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8.dp, bottom: 0, right: 8.dp)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    let revenueBarChartView: BarChartView = {
        let view = BarChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.noDataText = NSLocalizedString("no_data_available", comment: "")
        view.noDataTextColor = .rgb(106, green: 106, blue: 106)
        view.noDataFont = .systemFont(ofSize: 18.dp)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp
        
        self.setupView()
        self.setupDateSwitcherView()
        self.setupSelectedDateView()
        self.setupYieldView()
        
//        self.setupBarChartView(powerProfits: [Double]())
        self.setupSelectedDate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(dateSwitcherView)
        self.addSubview(selectedDateView)
        self.addSubview(titleLabel)
        self.addSubview(yieldView)
        self.addSubview(yieldValueLabel)
        self.addSubview(fullScreenView)
        self.addSubview(yieldParametrLabel)
        self.addSubview(barChartView)
        self.addSubview(revenueTitleLabel)
        self.addSubview(totalRevenueTitleLabel)
        self.addSubview(revenueValueLabel)
        self.addSubview(revenueFullScreenView)
        self.addSubview(revenueBarChartView)
        
        self.addConstraintsWithFormat("H:[v0(\(320.dp))]", views: dateSwitcherView)
        self.addConstraintsWithFormat("H:[v0(\(326.dp))]", views: selectedDateView)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: titleLabel)
        let yieldViewWidth = self.getWidth(text: NSLocalizedString("yield", comment: "")) + 5.dp + 4.dp + 18.dp
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0(\(yieldViewWidth))]", views: yieldView)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: yieldValueLabel)
        self.addConstraintsWithFormat("H:[v0]-\(16.dp)-|", views: fullScreenView)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: yieldParametrLabel)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(20.dp)-|", views: barChartView)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: revenueTitleLabel)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: totalRevenueTitleLabel)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: revenueValueLabel)
        self.addConstraintsWithFormat("H:[v0]-\(16.dp)-|", views: revenueFullScreenView)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(20.dp)-|", views: revenueBarChartView)
        
        self.addConstraintsWithFormat("V:|-\(16.dp)-[v0(\(36.dp))]-\(16.dp)-[v1(\(20.dp))]-\(24.dp)-[v2]-\(12.dp)-[v3(\(18.dp))]-\(10.dp)-[v4]-\(12.dp)-[v5(\(22.dp))]-\(16.dp)-[v6][v7(\(205.dp))]-\(32.dp)-[v8]-\(16.dp)-[v9]-\(12.dp)-[v10]-\(12.dp)-[v11(\(22.dp))]-\(32.dp)-[v12(\(205.dp))]", views: dateSwitcherView, selectedDateView, titleLabel, yieldView, yieldValueLabel, fullScreenView, yieldParametrLabel, barChartView, revenueTitleLabel, totalRevenueTitleLabel, revenueValueLabel, revenueFullScreenView, revenueBarChartView)
        
        dateSwitcherView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        selectedDateView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        barChartView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        revenueBarChartView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        let yieldViewTap = UITapGestureRecognizer(target: self, action: #selector(self.yieldViewPress))
        yieldView.isUserInteractionEnabled = true
        yieldView.addGestureRecognizer(yieldViewTap)
        
        fullScreenView.isHidden = true
        revenueFullScreenView.isHidden = true
    }
    
    @objc func yieldViewPress() {
        print("yieldViewPress")
    }
    
    func setupDateSwitcherView() {
        dateSwitcherView.addSubview(dayView)
        dateSwitcherView.addSubview(mounthView)
        dateSwitcherView.addSubview(yearView)
        dateSwitcherView.addSubview(lifetimeView)
        
        dateSwitcherView.addConstraintsWithFormat("H:|-\(3.dp)-[v0(\(78.5.dp))][v1(\(78.5.dp))][v2(\(78.5.dp))][v3(\(78.5.dp))]", views: dayView, mounthView, yearView, lifetimeView)
        
        dateSwitcherView.addConstraintsWithFormat("V:[v0(\(30.dp))]", views: dayView)
        dateSwitcherView.addConstraintsWithFormat("V:[v0(\(30.dp))]", views: mounthView)
        dateSwitcherView.addConstraintsWithFormat("V:[v0(\(30.dp))]", views: yearView)
        dateSwitcherView.addConstraintsWithFormat("V:[v0(\(30.dp))]", views: lifetimeView)
        
        dayView.centerYAnchor.constraint(equalTo: dateSwitcherView.centerYAnchor).isActive = true
        mounthView.centerYAnchor.constraint(equalTo: dateSwitcherView.centerYAnchor).isActive = true
        yearView.centerYAnchor.constraint(equalTo: dateSwitcherView.centerYAnchor).isActive = true
        lifetimeView.centerYAnchor.constraint(equalTo: dateSwitcherView.centerYAnchor).isActive = true
        
        let dayViewTap = UITapGestureRecognizer(target: self, action: #selector(self.dayViewPress))
        dayView.isUserInteractionEnabled = true
        dayView.addGestureRecognizer(dayViewTap)
        
        let mounthViewTap = UITapGestureRecognizer(target: self, action: #selector(self.mounthViewPress))
        mounthView.isUserInteractionEnabled = true
        mounthView.addGestureRecognizer(mounthViewTap)
        
        let yearViewTap = UITapGestureRecognizer(target: self, action: #selector(self.yearViewPress))
        yearView.isUserInteractionEnabled = true
        yearView.addGestureRecognizer(yearViewTap)
        
        let lifetimeViewTap = UITapGestureRecognizer(target: self, action: #selector(self.lifetimeViewPress))
        lifetimeView.isUserInteractionEnabled = true
        lifetimeView.addGestureRecognizer(lifetimeViewTap)
    }
    
    @objc func dayViewPress() {
        self.unselectAll()
        self.dayView.isSelected = true
        self.selectedDateType = self.dayView.value
    }
    
    @objc func mounthViewPress() {
        self.unselectAll()
        self.mounthView.isSelected = true
        self.selectedDateType = self.mounthView.value
    }
    
    @objc func yearViewPress() {
        self.unselectAll()
        self.yearView.isSelected = true
        self.selectedDateType = self.yearView.value
    }
    
    @objc func lifetimeViewPress() {
        self.unselectAll()
        self.lifetimeView.isSelected = true
        self.selectedDateType = self.lifetimeView.value
    }
    
    func unselectAll() {
        self.dayView.isSelected = false
        self.mounthView.isSelected = false
        self.yearView.isSelected = false
        self.lifetimeView.isSelected = false
    }
    
    func setupSelectedDateView() {
        selectedDateView.addSubview(leftButton)
        selectedDateView.addSubview(rightButton)
        selectedDateView.addSubview(selectedDateValueView)
        selectedDateValueView.addSubview(selectedDateLabel)
        selectedDateValueView.addSubview(arrowDownImageView)
        
        selectedDateView.addConstraintsWithFormat("H:|[v0(\(20.dp))]", views: leftButton)
        selectedDateView.addConstraintsWithFormat("H:[v0(\(20.dp))]|", views: rightButton)
        selectedDateValueView.addConstraintsWithFormat("H:|[v0]", views: selectedDateLabel)
        selectedDateValueView.addConstraintsWithFormat("H:[v0(\(12.dp))]", views: arrowDownImageView)
        
        selectedDateView.addConstraintsWithFormat("V:|[v0]|", views: leftButton)
        selectedDateView.addConstraintsWithFormat("V:|[v0]|", views: rightButton)
        selectedDateView.addConstraintsWithFormat("V:|[v0]|", views: selectedDateValueView)
        selectedDateValueView.addConstraintsWithFormat("V:|[v0]|", views: selectedDateLabel)
        selectedDateValueView.addConstraintsWithFormat("V:[v0(\(12.dp))]", views: arrowDownImageView)
        
        selectedDateValueView.centerXAnchor.constraint(equalTo: selectedDateView.centerXAnchor).isActive = true
        arrowDownImageView.centerYAnchor.constraint(equalTo: selectedDateValueView.centerYAnchor).isActive = true
        arrowDownImageView.leftAnchor.constraint(equalTo: selectedDateLabel.rightAnchor, constant: 6.dp).isActive = true
        
        selectedDateValueViewWidthConstraint = selectedDateValueView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 118.dp, heightConstant: 0)[0]
        selectedDateValueViewWidthConstraint?.isActive = true
        
        leftButton.addTarget(self, action: #selector(self.leftButtonPress), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(self.rightButtonPress), for: .touchUpInside)
        
        let selectedDateValueViewTap = UITapGestureRecognizer(target: self, action: #selector(self.selectedDateValueViewPress))
        selectedDateValueView.isUserInteractionEnabled = true
        selectedDateValueView.addGestureRecognizer(selectedDateValueViewTap)
    }
    
    func setupSelectedDate() {
        let value = self.selectedDateType ?? "day"
        let date = self.selectedDate ?? Date()
        var newDate: Date?
        let dateFormatter = DateFormatter()
        if(value == "day") {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            selectedDateValueViewWidthConstraint?.constant = 112.dp
            newDate = Calendar.current.date(byAdding: .day, value: 1, to: date)
        }
        if(value == "month") {
            dateFormatter.dateFormat = "MM/yyyy"
            selectedDateValueViewWidthConstraint?.constant = 87.dp
            newDate = Calendar.current.date(byAdding: .month, value: 1, to: date)
        }
        if(value == "year") {
            dateFormatter.dateFormat = "yyyy"
            selectedDateValueViewWidthConstraint?.constant = 62.dp
            newDate = Calendar.current.date(byAdding: .year, value: 1, to: date)
        }
        if(value == "lifetime") {
            dateFormatter.dateFormat = "yyyy"
            selectedDateValueViewWidthConstraint?.constant = 62.dp
            newDate = Calendar.current.date(byAdding: .year, value: 1, to: date)
        }
        self.layoutIfNeeded()
        self.selectedDateLabel.text = dateFormatter.string(from: date)
        if(newDate != nil) {
            var toDay = Calendar.current.startOfDay(for: Date())
            var newDay = Calendar.current.startOfDay(for: newDate!)
            if(newDay > toDay) {
                print("needs disable button")
                self.rightButton.isEnabled = false
                let image = UIImage(named: "arrow_right_gray")?.withRenderingMode(.alwaysOriginal)
                self.rightButton.setImage(image, for: .normal)
            } else {
                print("needs active button")
                self.rightButton.isEnabled = true
                let image = UIImage(named: "arrow_right")?.withRenderingMode(.alwaysOriginal)
                self.rightButton.setImage(image, for: .normal)
            }
        }
    }
    
    @objc func leftButtonPress() {
        print("leftButtonPress")
        let date = self.selectedDate ?? Date()
        let value = self.selectedDateType ?? "day"
        if(value == "day") {
            self.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: date)
        }
        if(value == "month") {
            self.selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: date)
        }
        if(value == "year") {
            self.selectedDate = Calendar.current.date(byAdding: .year, value: -1, to: date)
        }
        if(value == "lifetime") {
            self.selectedDate = Calendar.current.date(byAdding: .year, value: -1, to: date)
        }
    }
    
    @objc func rightButtonPress() {
        print("rightButtonPress")
        let date = self.selectedDate ?? Date()
        let value = self.selectedDateType ?? "day"
        if(value == "day") {
            self.selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: date)
        }
        if(value == "month") {
            self.selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: date)
        }
        if(value == "year") {
            self.selectedDate = Calendar.current.date(byAdding: .year, value: 1, to: date)
        }
        if(value == "lifetime") {
            self.selectedDate = Calendar.current.date(byAdding: .year, value: 1, to: date)
        }
    }
    
    @objc func selectedDateValueViewPress() {
        let value = self.selectedDateType ?? "day"
        if(value == "day") {
            self.stationStatisticsView?.overviewController?.openDatePickerView(selectedDate: self.selectedDate ?? Date(), stationChartsView: self)
        }
        if(value == "month") {
            self.stationStatisticsView?.overviewController?.openMonthPickerView(selectedDate: self.selectedDate ?? Date(), stationChartsView: self)
        }
        if(value == "year" || value == "lifetime") {
            self.stationStatisticsView?.overviewController?.openYearPickerView(selectedDate: self.selectedDate ?? Date(), stationChartsView: self)
        }
    }
    
    func setupYieldView() {
        yieldView.addSubview(yieldLabel)
        yieldView.addSubview(questionImageView)
        
        yieldView.addConstraintsWithFormat("H:|[v0]-\(4.dp)-[v1(\(18.dp))]", views: yieldLabel, questionImageView)
        
        yieldView.addConstraintsWithFormat("V:[v0]", views: yieldLabel)
        yieldView.addConstraintsWithFormat("V:[v0(\(18.dp))]", views: questionImageView)
        
        yieldLabel.centerYAnchor.constraint(equalTo: yieldView.centerYAnchor).isActive = true
        questionImageView.centerYAnchor.constraint(equalTo: yieldView.centerYAnchor).isActive = true
    }
    
    func getWidth(text: String) -> CGFloat {
        let dummySize = CGSize(width: 1000.dp, height: 21.dp)
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let rect = descAttributedText(name: text).boundingRect(with: dummySize, options: options, context: nil)
        return rect.width
    }
    
    fileprivate func descAttributedText(name: String?) -> NSAttributedString {
        let text = name
        let attrs:[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.dp)]
        let normal = NSMutableAttributedString(string: text!, attributes:attrs)
        return normal
    }
    
    var yields = [Double]()
    var revenues = [Double]()
    var axisValue = [String]()
    var granularity = 1.0
    var barWidth = 0.5
    
    func setupBarChartView(graphValues: [GraphValue]) {
        let value = self.selectedDateType ?? "day"
        if(value == "day") {
            let hours = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
            axisValue = hours
            granularity = 1.0
        }
        if(value == "month") {
            let date = self.selectedDate ?? Date()
            let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
            if let month = calendarDate.month {
                if let year = calendarDate.year {
                    if let numberOfDays = getDaysInMonth(month: month, year: year) {
                        var days = [String]()
                        for i in 0..<numberOfDays {
                            let value = i + 1
                            if(value > 9) {
                                days.append("\(value)")
                            } else {
                                days.append("0\(value)")
                            }
                        }
                        axisValue = days
                        granularity = 2.0
                    }
                }
            }
            
        }
        if(value == "year") {
            let months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
            axisValue = months
            granularity = 1.0
        }
        if(value == "lifetime") {
            let years = ["2023", "2024"]
            axisValue = years
            granularity = 1.0
        }
       
        var yields = [Double]()
        for i in 0..<axisValue.count {
            var value = 0.0
            for graphValue in graphValues {
                if(axisValue[i] == graphValue.key) {
                    value = graphValue.inverterPower ?? 0.0
                }
            }
            yields.append(value)
        }
       
        
        self.yields = yields
        
        var revenues = [Double]()
        for i in 0..<axisValue.count {
            var value = 0.0
            for graphValue in graphValues {
                if(axisValue[i] == graphValue.key) {
                    value = graphValue.powerProfit ?? 0.0
                }
            }
            revenues.append(value)
        }
        self.revenues = revenues
                
        self.setChart()
        self.setRevenueChart()
    }
    
    func setChart() {
        let xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 12.dp)
        xAxis.granularity = self.granularity
        xAxis.labelCount = self.axisValue.count
        xAxis.drawAxisLineEnabled = false
        xAxis.valueFormatter = IndexAxisValueFormatter(values: axisValue)
        xAxis.labelFont = .systemFont(ofSize: 12.dp)
        xAxis.labelTextColor = .rgb(106, green: 106, blue: 106)
        
        barChartView.doubleTapToZoomEnabled = false

        let legend = barChartView.legend
        legend.horizontalAlignment = .left
        legend.verticalAlignment = .bottom
        legend.orientation = .horizontal
        legend.drawInside = false
        legend.form = .circle
        legend.formSize = 9
        legend.font = .systemFont(ofSize: 12.dp)
        legend.xEntrySpace = 4
        
        let leftAxis = barChartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 12.dp)
        leftAxis.labelCount = 6
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 0
        leftAxis.axisMinimum = 0
        leftAxis.labelFont = .systemFont(ofSize: 12.dp)
        leftAxis.labelTextColor = .rgb(106, green: 106, blue: 106)
        
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        
        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12.dp),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: barChartView.xAxis.valueFormatter!)
        marker.chartView = barChartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        barChartView.marker = marker
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<yields.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: yields[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "PV output")
        chartDataSet.drawValuesEnabled = false
        chartDataSet.colors = [UIColor.rgb(25, green: 206, blue: 135)]
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFont(UIFont.systemFont(ofSize: 12.dp))
        chartData.barWidth = self.barWidth
        barChartView.data = chartData
        
        barChartView.animate(xAxisDuration: 3, yAxisDuration: 3)
    }
    
    func setRevenueChart() {
        let xAxis = revenueBarChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 12.dp)
        xAxis.granularity = self.granularity
        xAxis.labelCount = self.axisValue.count
        xAxis.drawAxisLineEnabled = false
        xAxis.valueFormatter = IndexAxisValueFormatter(values: axisValue)
        xAxis.labelFont = .systemFont(ofSize: 12.dp)
        xAxis.labelTextColor = .rgb(106, green: 106, blue: 106)
        
        revenueBarChartView.doubleTapToZoomEnabled = false

        revenueBarChartView.legend.enabled = false
        
        let leftAxis = revenueBarChartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 12.dp)
        leftAxis.labelCount = 6
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 0
        leftAxis.axisMinimum = 0
        leftAxis.labelFont = .systemFont(ofSize: 12.dp)
        leftAxis.labelTextColor = .rgb(106, green: 106, blue: 106)
        
        revenueBarChartView.rightAxis.enabled = false
        revenueBarChartView.xAxis.drawGridLinesEnabled = false
        
        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12.dp),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: revenueBarChartView.xAxis.valueFormatter!)
        marker.chartView = revenueBarChartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        revenueBarChartView.marker = marker
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<revenues.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: revenues[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "$")
        chartDataSet.drawValuesEnabled = false
        chartDataSet.colors = [UIColor.rgb(25, green: 206, blue: 135)]
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFont(UIFont.systemFont(ofSize: 12.dp))
        chartData.barWidth = self.barWidth
        revenueBarChartView.data = chartData
        
        revenueBarChartView.animate(xAxisDuration: 3, yAxisDuration: 3)
    }
    
    func getDaysInMonth(month: Int, year: Int) -> Int? {
        let calendar = Calendar.current

        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year

        var endComps = DateComponents()
        endComps.day = 1
        endComps.month = month == 12 ? 1 : month + 1
        endComps.year = month == 12 ? year + 1 : year

            
        let startDate = calendar.date(from: startComps)!
        let endDate = calendar.date(from:endComps)!

            
        let diff = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)

        return diff.day
    }
}
