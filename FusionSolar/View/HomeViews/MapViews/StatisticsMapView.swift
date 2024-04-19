//
//  StatisticsMapView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 19/04/24.
//

import UIKit

class StatisticsMapView: UIView {
    
    //allView
    let allView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let allValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(0, green: 0, blue: 0)
        label.font = .systemFont(ofSize: 18.dp)
        label.textAlignment = .center
        return label
    }()
    
    let allTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("all", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    //normalView
    let normalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let normalValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(84, green: 164, blue: 110)
        label.font = .systemFont(ofSize: 18.dp)
        label.textAlignment = .center
        return label
    }()
    
    let normalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("normal", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    //faultyView
    let faultyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let faultyValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(224, green: 69, blue: 76)
        label.font = .systemFont(ofSize: 18.dp)
        label.textAlignment = .center
        return label
    }()
    
    let faultyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("faulty", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    //offlineView
    let offlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let offlineValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 18.dp)
        label.textAlignment = .center
        return label
    }()
    
    let offlineTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("offline", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp
        
        self.setupView()
        self.setupAllView()
        self.setupNormalView()
        self.setupFaultyView()
        self.setupOfflineView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(allView)
        self.addSubview(normalView)
        self.addSubview(faultyView)
        self.addSubview(offlineView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: allView)
        self.addConstraintsWithFormat("H:|[v0]|", views: normalView)
        self.addConstraintsWithFormat("H:|[v0]|", views: faultyView)
        self.addConstraintsWithFormat("H:|[v0]|", views: offlineView)
        
        self.addConstraintsWithFormat("V:|-\(8.dp)-[v0(\(55.dp))][v1(\(55.dp))][v2(\(55.dp))][v3(\(55.dp))]", views: allView, normalView, faultyView, offlineView)
    }
    
    func setupAllView() {
        allView.addSubview(allValueLabel)
        allView.addSubview(allTitleLabel)
        
        allView.addConstraintsWithFormat("H:|[v0]|", views: allValueLabel)
        allView.addConstraintsWithFormat("H:|[v0]|", views: allTitleLabel)
        
        allView.addConstraintsWithFormat("V:|-\(8.dp)-[v0]-\(2.dp)-[v1]", views: allValueLabel, allTitleLabel)
    }
    
    func setupNormalView() {
        normalView.addSubview(normalValueLabel)
        normalView.addSubview(normalTitleLabel)
        
        normalView.addConstraintsWithFormat("H:|[v0]|", views: normalValueLabel)
        normalView.addConstraintsWithFormat("H:|[v0]|", views: normalTitleLabel)
        
        normalView.addConstraintsWithFormat("V:|-\(8.dp)-[v0]-\(2.dp)-[v1]", views: normalValueLabel, normalTitleLabel)
    }
    
    func setupFaultyView() {
        faultyView.addSubview(faultyValueLabel)
        faultyView.addSubview(faultyTitleLabel)
        
        faultyView.addConstraintsWithFormat("H:|[v0]|", views: faultyValueLabel)
        faultyView.addConstraintsWithFormat("H:|[v0]|", views: faultyTitleLabel)
        
        faultyView.addConstraintsWithFormat("V:|-\(8.dp)-[v0]-\(2.dp)-[v1]", views: faultyValueLabel, faultyTitleLabel)
    }
    
    func setupOfflineView() {
        offlineView.addSubview(offlineValueLabel)
        offlineView.addSubview(offlineTitleLabel)
        
        offlineView.addConstraintsWithFormat("H:|[v0]|", views: offlineValueLabel)
        offlineView.addConstraintsWithFormat("H:|[v0]|", views: offlineTitleLabel)
        
        offlineView.addConstraintsWithFormat("V:|-\(8.dp)-[v0]-\(2.dp)-[v1]", views: offlineValueLabel, offlineTitleLabel)
    }
}
