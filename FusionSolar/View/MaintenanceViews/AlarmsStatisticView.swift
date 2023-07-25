//
//  AlarmsStatisticView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit
import DGCharts

class AlarmsStatisticView: UIView {
    
    let chartView: PieChartView = {
        let view = PieChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.noDataText = NSLocalizedString("no_data_available", comment: "")
        view.noDataTextColor = .rgb(106, green: 106, blue: 106)
        view.noDataFont = .systemFont(ofSize: 18.dp)
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        self.setupView()
       // self.setupChartView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(chartView)
        //self.addSubview(contentView)
        
       // self.addConstraintsWithFormat("H:|-\(31.dp)-[v0(\(100.dp))]-\(35.dp)-[v1]|", views: chartView, contentView)
        self.addConstraintsWithFormat("H:|[v0]|", views: chartView)
        self.addConstraintsWithFormat("V:[v0(\(300.dp))]", views: chartView)
        //self.addConstraintsWithFormat("V:[v0(\(100.dp))]", views: contentView)
        
        chartView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      //  contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupChartView() {
        chartView.entryLabelColor = .black
        chartView.entryLabelFont = .systemFont(ofSize: 6.dp)
        
        chartView.legend.enabled = false
        
        var entries = [PieChartDataEntry]()

        //test data
        let criticalCount = 2
        let majorCount = 8
        let minorCount = 1
        let warningCount = 3
        //
        let totalCount = criticalCount + majorCount + minorCount + warningCount

        let entrieCritical = PieChartDataEntry(value: Double(criticalCount), label: "")
        let entrieMajor = PieChartDataEntry(value: Double(majorCount), label: "")
        let entrieMinor = PieChartDataEntry(value: Double(minorCount), label: "")
        let entrieWarning = PieChartDataEntry(value: Double(warningCount), label: "")

        entries.append(entrieCritical)
        entries.append(entrieMajor)
        entries.append(entrieMinor)
        entries.append(entrieWarning)
        
        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 1
      //  set.sl
        
        set.colors = [UIColor.rgb(244, green: 54, blue: 82), UIColor.rgb(246, green: 117, blue: 26), UIColor.rgb(246, green: 195, blue: 8), UIColor.rgb(93, green: 140, blue: 246)]
        
        let data = PieChartData(dataSet: set)
        
        data.setValueFont(.systemFont(ofSize: 0.1))
        data.setValueTextColor(.black)
        chartView.data = data
        chartView.highlightValues(nil)
        
        chartView.drawCenterTextEnabled = true
        
        chartView.centerText = "\(totalCount)\n\(NSLocalizedString("total", comment: "")):"
        
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
       // chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
    }
}
