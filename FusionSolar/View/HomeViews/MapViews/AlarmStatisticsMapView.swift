//
//  AlarmStatisticsMapView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 19/04/24.
//

import UIKit

class AlarmStatisticsMapView: UIView {
    
    //criticalView
    let criticalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let criticalValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(152, green: 152, blue: 152)
        label.font = .systemFont(ofSize: 20.dp)
        label.textAlignment = .center
        return label
    }()
    
    let criticalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("map_critical", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    let seperate1View: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "divider")
        return imageView
    }()
    
    //majorView
    let majorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let majorValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(152, green: 152, blue: 152)
        label.font = .systemFont(ofSize: 20.dp)
        label.textAlignment = .center
        return label
    }()
    
    let majorTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("map_major", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    let seperate2View: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "divider")
        return imageView
    }()
    
    //minorView
    let minorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let minorValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(152, green: 152, blue: 152)
        label.font = .systemFont(ofSize: 20.dp)
        label.textAlignment = .center
        return label
    }()
    
    let minorTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("map_minor", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    let seperate3View: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "divider")
        return imageView
    }()
    
    //warningView
    let warningView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let warningValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(152, green: 152, blue: 152)
        label.font = .systemFont(ofSize: 20.dp)
        label.textAlignment = .center
        return label
    }()
    
    let warningTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("map_warning", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupCriticalView()
        self.setupMajorView()
        self.setupMinorView()
        self.setupWarningView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(criticalView)
        self.addSubview(seperate1View)
        self.addSubview(majorView)
        self.addSubview(seperate2View)
        self.addSubview(minorView)
        self.addSubview(seperate3View)
        self.addSubview(warningView)
        
        self.addConstraintsWithFormat("H:|[v0(\(72.dp))][v1(\(21.dp))][v2(\(72.dp))][v3(\(21.dp))][v4(\(72.dp))][v5(\(21.dp))][v6(\(72.dp))]", views: criticalView, seperate1View, majorView, seperate2View, minorView, seperate3View, warningView)
        
        self.addConstraintsWithFormat("V:[v0(\(60.dp))]", views: criticalView)
        self.addConstraintsWithFormat("V:[v0(\(41.dp))]", views: seperate1View)
        self.addConstraintsWithFormat("V:[v0(\(60.dp))]", views: majorView)
        self.addConstraintsWithFormat("V:[v0(\(41.dp))]", views: seperate2View)
        self.addConstraintsWithFormat("V:[v0(\(60.dp))]", views: minorView)
        self.addConstraintsWithFormat("V:[v0(\(41.dp))]", views: seperate3View)
        self.addConstraintsWithFormat("V:[v0(\(60.dp))]", views: warningView)
        
        criticalView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        seperate1View.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        majorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        seperate2View.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        minorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        seperate3View.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        warningView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupCriticalView() {
        criticalView.addSubview(criticalValueLabel)
        criticalView.addSubview(criticalTitleLabel)
        
        criticalView.addConstraintsWithFormat("H:|[v0]|", views: criticalValueLabel)
        criticalView.addConstraintsWithFormat("H:|[v0]|", views: criticalTitleLabel)
        
        criticalView.addConstraintsWithFormat("V:|-\(12.dp)-[v0]-\(2.dp)-[v1]", views: criticalValueLabel, criticalTitleLabel)
    }
    
    func setupMajorView() {
        majorView.addSubview(majorValueLabel)
        majorView.addSubview(majorTitleLabel)
        
        majorView.addConstraintsWithFormat("H:|[v0]|", views: majorValueLabel)
        majorView.addConstraintsWithFormat("H:|[v0]|", views: majorTitleLabel)
        
        majorView.addConstraintsWithFormat("V:|-\(12.dp)-[v0]-\(2.dp)-[v1]", views: majorValueLabel, majorTitleLabel)
    }
    
    func setupMinorView() {
        minorView.addSubview(minorValueLabel)
        minorView.addSubview(minorTitleLabel)
        
        minorView.addConstraintsWithFormat("H:|[v0]|", views: minorValueLabel)
        minorView.addConstraintsWithFormat("H:|[v0]|", views: minorTitleLabel)
        
        minorView.addConstraintsWithFormat("V:|-\(12.dp)-[v0]-\(2.dp)-[v1]", views: minorValueLabel, minorTitleLabel)
    }
    
    func setupWarningView() {
        warningView.addSubview(warningValueLabel)
        warningView.addSubview(warningTitleLabel)
        
        warningView.addConstraintsWithFormat("H:|[v0]|", views: warningValueLabel)
        warningView.addConstraintsWithFormat("H:|[v0]|", views: warningTitleLabel)
        
        warningView.addConstraintsWithFormat("V:|-\(12.dp)-[v0]-\(2.dp)-[v1]", views: warningValueLabel, warningTitleLabel)
    }
}
