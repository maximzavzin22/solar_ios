//
//  AlarmsStatisticView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit
import DGCharts

class AlarmsStatisticView: UIView {
    
    var alarmsView: AlarmsView?
    
    var criticalCount = 0
    var majorCount = 0
    var minorCount = 0
    var warningCount = 0
    
    let chartView: PieChartView = {
        let view = PieChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.noDataText = NSLocalizedString("no_data_available", comment: "")
        view.noDataTextColor = .rgb(106, green: 106, blue: 106)
        view.noDataFont = .systemFont(ofSize: 18.dp)
        return view
    }()
    
    //contentView
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let criticalAlarmsStatistiValueView: AlarmsStatistiValueView = {
        let view = AlarmsStatistiValueView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = NSLocalizedString("critical", comment: "")
        view.circleView.backgroundColor = .rgb(244, green: 54, blue: 82)
        return view
    }()
    
    let majorAlarmsStatistiValueView: AlarmsStatistiValueView = {
        let view = AlarmsStatistiValueView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = NSLocalizedString("major", comment: "")
        view.circleView.backgroundColor = .rgb(246, green: 117, blue: 26)
        return view
    }()
    
    let minorAlarmsStatistiValueView: AlarmsStatistiValueView = {
        let view = AlarmsStatistiValueView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = NSLocalizedString("minor", comment: "")
        view.circleView.backgroundColor = .rgb(246, green: 195, blue: 8)
        return view
    }()
    
    let warningAlarmsStatistiValueView: AlarmsStatistiValueView = {
        let view = AlarmsStatistiValueView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = NSLocalizedString("warning", comment: "")
        view.circleView.backgroundColor = .rgb(93, green: 140, blue: 246)
        return view
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        self.setupView()
        self.setupContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func initData() {
        self.criticalAlarmsStatistiValueView.valueLabel.text = "\(criticalCount)"
        self.majorAlarmsStatistiValueView.valueLabel.text = "\(majorCount)"
        self.minorAlarmsStatistiValueView.valueLabel.text = "\(minorCount)"
        self.warningAlarmsStatistiValueView.valueLabel.text = "\(warningCount)"
        self.setupChartView()
    }
    
    func setupView() {
        self.addSubview(chartView)
        self.addSubview(contentView)
        
        self.addConstraintsWithFormat("H:|[v0(\(160.dp))][v1]|", views: chartView, contentView)
        self.addConstraintsWithFormat("V:[v0(\(150.dp))]", views: chartView)
        self.addConstraintsWithFormat("V:[v0(\(100.dp))]", views: contentView)
        
        chartView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        let tapChartView = UITapGestureRecognizer(target: self, action: #selector(self.chartViewPress))
        chartView.isUserInteractionEnabled = true
        chartView.addGestureRecognizer(tapChartView)
    }
    
    @objc func chartViewPress() {
        self.alarmsView?.status = 0
        self.unSelectedAll()
    }
    
    func setupChartView() {
        chartView.entryLabelColor = .black
        chartView.entryLabelFont = .systemFont(ofSize: 6.dp)
        
        chartView.legend.enabled = false
        
        var entries = [PieChartDataEntry]()

        let totalCount = criticalCount + majorCount + minorCount + warningCount

        if(totalCount == 0) {
            let entrieEmpty = PieChartDataEntry(value: 1.0, label: "")
            entries.append(entrieEmpty)
        } else {
            let entrieCritical = PieChartDataEntry(value: Double(criticalCount), label: "")
            let entrieMajor = PieChartDataEntry(value: Double(majorCount), label: "")
            let entrieMinor = PieChartDataEntry(value: Double(minorCount), label: "")
            let entrieWarning = PieChartDataEntry(value: Double(warningCount), label: "")
            entries.append(entrieCritical)
            entries.append(entrieMajor)
            entries.append(entrieMinor)
            entries.append(entrieWarning)
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.drawIconsEnabled = false
        dataSet.sliceSpace = 1
        if(totalCount == 0) {
            dataSet.colors = [UIColor.rgb(243, green: 243, blue: 243)]
        } else {
            dataSet.colors = [UIColor.rgb(244, green: 54, blue: 82), UIColor.rgb(246, green: 117, blue: 26), UIColor.rgb(246, green: 195, blue: 8), UIColor.rgb(93, green: 140, blue: 246)]
        }
        dataSet.drawValuesEnabled = false
        
        let data = PieChartData(dataSet: dataSet)
        
        chartView.data = data
        chartView.highlightValues(nil)
        
        chartView.drawCenterTextEnabled = true
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 20.dp), .foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: style]
        let attrs1: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14.dp), .foregroundColor: UIColor.rgb(106, green: 106, blue: 106), NSAttributedString.Key.paragraphStyle: style]
        let attString: NSMutableAttributedString = NSMutableAttributedString(string: "\(totalCount)", attributes: attrs)
        let attrString1 = NSAttributedString(string: "\n\(NSLocalizedString("total", comment: ""))", attributes: attrs1)
        attString.append(attrString1)
        chartView.centerAttributedText = attString
        
        chartView.holeRadiusPercent = 0.9
        chartView.highlightPerTapEnabled = false
        
        chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
    }
    
    func setupContentView() {
        contentView.addSubview(criticalAlarmsStatistiValueView)
        contentView.addSubview(minorAlarmsStatistiValueView)
        contentView.addSubview(majorAlarmsStatistiValueView)
        contentView.addSubview(warningAlarmsStatistiValueView)
        
        contentView.addConstraintsWithFormat("H:|[v0(\(105.dp))]-\(10.dp)-[v1(\(105.dp))]", views: criticalAlarmsStatistiValueView, majorAlarmsStatistiValueView)
        contentView.addConstraintsWithFormat("H:|[v0(\(105.dp))]-\(10.dp)-[v1(\(105.dp))]", views: minorAlarmsStatistiValueView, warningAlarmsStatistiValueView)
        
        contentView.addConstraintsWithFormat("V:|[v0(\(36.dp))]-\(28.dp)-[v1(\(36.dp))]", views: criticalAlarmsStatistiValueView, minorAlarmsStatistiValueView)
        contentView.addConstraintsWithFormat("V:|[v0(\(36.dp))]-\(28.dp)-[v1(\(36.dp))]", views: majorAlarmsStatistiValueView, warningAlarmsStatistiValueView)
        
        let tapMajorAlarmsStatistiValueView = UITapGestureRecognizer(target: self, action: #selector(self.majorAlarmsStatistiValueViewPress))
        majorAlarmsStatistiValueView.isUserInteractionEnabled = true
        majorAlarmsStatistiValueView.addGestureRecognizer(tapMajorAlarmsStatistiValueView)
        
        let tapWarningAlarmsStatistiValueView = UITapGestureRecognizer(target: self, action: #selector(self.warningAlarmsStatistiValueViewPress))
        warningAlarmsStatistiValueView.isUserInteractionEnabled = true
        warningAlarmsStatistiValueView.addGestureRecognizer(tapWarningAlarmsStatistiValueView)
        
        let tapMinorAlarmsStatistiValueView = UITapGestureRecognizer(target: self, action: #selector(self.minorAlarmsStatistiValueViewPress))
        minorAlarmsStatistiValueView.isUserInteractionEnabled = true
        minorAlarmsStatistiValueView.addGestureRecognizer(tapMinorAlarmsStatistiValueView)
        
        let tapCriticalAlarmsStatistiValueView = UITapGestureRecognizer(target: self, action: #selector(self.criticalAlarmsStatistiValueViewPress))
        criticalAlarmsStatistiValueView.isUserInteractionEnabled = true
        criticalAlarmsStatistiValueView.addGestureRecognizer(tapCriticalAlarmsStatistiValueView)
    }
    
    @objc func majorAlarmsStatistiValueViewPress() {
        self.unSelectedAll()
        majorAlarmsStatistiValueView.isSelected = true
        self.alarmsView?.status = 2
    }
    
    @objc func warningAlarmsStatistiValueViewPress() {
        self.unSelectedAll()
        warningAlarmsStatistiValueView.isSelected = true
        self.alarmsView?.status = 4
    }
    
    @objc func minorAlarmsStatistiValueViewPress() {
        self.unSelectedAll()
        minorAlarmsStatistiValueView.isSelected = true
        self.alarmsView?.status = 3
    }
    
    @objc func criticalAlarmsStatistiValueViewPress() {
        self.unSelectedAll()
        criticalAlarmsStatistiValueView.isSelected = true
        self.alarmsView?.status = 1
    }
    
    func unSelectedAll() {
        majorAlarmsStatistiValueView.isSelected = false
        warningAlarmsStatistiValueView.isSelected = false
        minorAlarmsStatistiValueView.isSelected = false
        criticalAlarmsStatistiValueView.isSelected = false
    }
}


