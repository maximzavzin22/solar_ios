//
//  GraphView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 22/07/23.
//

import UIKit
import DGCharts

class GraphView: UIView {
    
    var homeStatisticsCellView: StatisticPlantView?
    
    var selectedDate: Date? {
        didSet {
            print("selectedDate \(selectedDate)")
            self.setupSelectedDate()
//            self.setupBarChartView()
            self.homeStatisticsCellView?.getDataForGraph()
        }
    }
    
    var selectedDateType: String? {
        didSet {
            self.selectedDate = Date()
            self.setupSelectedDate()
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("yield_statistics", comment: "")
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 18.dp)
        return label
    }()
    
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
    
    let parametrLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp

        self.setupView()
        self.setupDateSwitcherView()
        self.setupSelectedDateView()
        
        self.setupSelectedDate()
//        self.setupBarChartView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(titleLabel)
        self.addSubview(dateSwitcherView)
        self.addSubview(selectedDateView)
        self.addSubview(parametrLabel)
        self.addSubview(barChartView)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: titleLabel)
        self.addConstraintsWithFormat("H:[v0(\(320.dp))]", views: dateSwitcherView)
        self.addConstraintsWithFormat("H:[v0(\(326.dp))]", views: selectedDateView)
        self.addConstraintsWithFormat("H:|-\(16.dp)-[v0]-\(16.dp)-|", views: barChartView)
        self.addConstraintsWithFormat("H:|-\(10.dp)-[v0]", views: parametrLabel)
        
        self.addConstraintsWithFormat("V:|-\(24.dp)-[v0]-\(16.dp)-[v1(\(36.dp))]-\(16.dp)-[v2(\(20.dp))]-\(26.dp)-[v3]-\(4.dp)-[v4(\(243.dp))]", views: titleLabel, dateSwitcherView, selectedDateView, parametrLabel, barChartView)
        
        dateSwitcherView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        selectedDateView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        barChartView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
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
            parametrLabel.text = NSLocalizedString("kwh", comment: "")
        }
        if(value == "month") {
            dateFormatter.dateFormat = "MM/yyyy"
            selectedDateValueViewWidthConstraint?.constant = 87.dp
            newDate = Calendar.current.date(byAdding: .month, value: 1, to: date)
            parametrLabel.text = NSLocalizedString("mwh", comment: "")
        }
        if(value == "year") {
            dateFormatter.dateFormat = "yyyy"
            selectedDateValueViewWidthConstraint?.constant = 62.dp
            newDate = Calendar.current.date(byAdding: .year, value: 1, to: date)
            parametrLabel.text = NSLocalizedString("mwh", comment: "")
        }
        if(value == "lifetime") {
            dateFormatter.dateFormat = "yyyy"
            selectedDateValueViewWidthConstraint?.constant = 62.dp
            newDate = Calendar.current.date(byAdding: .year, value: 1, to: date)
            parametrLabel.text = NSLocalizedString("mwh", comment: "")
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
            self.homeStatisticsCellView?.homeController?.openDatePickerView(selectedDate: self.selectedDate ?? Date(), graphView: self)
        }
        if(value == "month") {
            self.homeStatisticsCellView?.homeController?.openMonthPickerView(selectedDate: self.selectedDate ?? Date(), graphView: self)
        }
        if(value == "year" || value == "lifetime") {
            self.homeStatisticsCellView?.homeController?.openYearPickerView(selectedDate: self.selectedDate ?? Date(), graphView: self)
        }
    }
    
    
    var yields = [Double]()
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
                    value = graphValue.value ?? 0.0
                }
            }
            yields.append(value)
        }
       
//        for yield in yields {
//            for graphValue in graphValues {
//                if(yield in)
//            }
//        }
        
        self.yields = yields
       
//        //for test
//        if(value == "day") {
//            self.yields[6] = 20.0
//            self.yields[7] = 80.0
//            self.yields[8] = 110.0
//            self.yields[9] = 160.0
//            self.yields[10] = 210.0
//            self.yields[11] = 280.0
//            self.yields[12] = 310.0
//            self.yields[13] = 445.0
//            self.yields[14] = 440.0
//            self.yields[15] = 340.0
//        }
//        if(value == "month") {
//            self.yields[0] = 1.8
//            self.yields[1] = 2.8
//            self.yields[2] = 3.1
//            self.yields[3] = 0.7
//            self.yields[4] = 4.2
//            self.yields[5] = 3.3
//            self.yields[6] = 1.0
//            self.yields[7] = 2.2
//            self.yields[8] = 4.1
//            self.yields[9] = 2.9
//            self.yields[10] = 3.7
//            self.yields[10] = 1.1
//        }
//        if(value == "year") {
//            self.yields[0] = 0.26
//            self.yields[1] = 5.55
//            self.yields[2] = 10.80
//            self.yields[3] = 13.05
//            self.yields[4] = 15.77
//            self.yields[5] = 25.41
//            self.yields[6] = 65.32
//        }
//        if(value == "lifetime") {
//            self.yields[0] = 0.0
//            self.yields[1] = 136.14
//        }
//        //
                
        self.setChart()
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
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Yield")
        chartDataSet.drawValuesEnabled = false
        chartDataSet.colors = [UIColor.rgb(25, green: 206, blue: 135)]
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFont(UIFont.systemFont(ofSize: 12.dp))
        chartData.barWidth = self.barWidth
        barChartView.data = chartData
        
        barChartView.animate(xAxisDuration: 3, yAxisDuration: 3)
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

class GraphDayView: UIView {
 
    var value: String?
    
    var isSelected: Bool? {
        didSet {
            if(isSelected ?? false) {
                titleLabel.textColor = .rgb(1, green: 6, blue: 10)
                self.backgroundColor = .rgb(255, green: 255, blue: 255)
            } else {
                titleLabel.textColor = .rgb(106, green: 106, blue: 106)
                self.backgroundColor = .rgb(241, green: 243, blue: 245)
            }
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.dp)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        self.layer.cornerRadius = 15.dp

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(titleLabel)
        self.addConstraintsWithFormat("H:[v0]", views: titleLabel)
        self.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

