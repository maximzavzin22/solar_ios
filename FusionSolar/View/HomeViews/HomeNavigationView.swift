//
//  HomeNavigationView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit

class HomeNavigationView: UIView {
    
    var homeView: HomeView?
    
    var selectePage: Int? {
        didSet {
            if((selectePage ?? 0) == 0) {
                plantsButton.titleLabel?.font = .systemFont(ofSize: 24.dp)
                plantsButton.titleLabel?.textColor = .rgb(1, green: 6, blue: 10)
                plantsButton.tintColor = .rgb(1, green: 6, blue: 10)
                
                statisticsButton.titleLabel?.font = .systemFont(ofSize: 18.dp)
                statisticsButton.titleLabel?.textColor = .rgb(106, green: 106, blue: 106)
                statisticsButton.tintColor = .rgb(106, green: 106, blue: 106)
            } else {
                statisticsButton.titleLabel?.font = .systemFont(ofSize: 24.dp)
                statisticsButton.titleLabel?.textColor = .rgb(1, green: 6, blue: 10)
                statisticsButton.tintColor = .rgb(1, green: 6, blue: 10)
                
                plantsButton.titleLabel?.font = .systemFont(ofSize: 18.dp)
                plantsButton.titleLabel?.textColor = .rgb(106, green: 106, blue: 106)
                plantsButton.tintColor = .rgb(106, green: 106, blue: 106)
            }
            self.homeView?.scrollToMenuIndex()
        }
    }
    
    let plantsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle(NSLocalizedString("plants", comment: ""), for: .normal)
        button.sizeToFit()
        return button
    }()
    
    let statisticsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle(NSLocalizedString("statistics", comment: ""), for: .normal)
        button.sizeToFit()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.setupView()
        
        selectePage = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(plantsButton)
        self.addSubview(statisticsButton)
        
        self.addConstraintsWithFormat("H:|-\(26.dp)-[v0]-\(20.dp)-[v1]", views: plantsButton, statisticsButton)
        
        self.addConstraintsWithFormat("V:[v0]", views: plantsButton)
        self.addConstraintsWithFormat("V:[v0]", views: statisticsButton)
        
        plantsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        statisticsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        plantsButton.addTarget(self, action: #selector(self.plantsButtonPress), for: .touchUpInside)
        statisticsButton.addTarget(self, action: #selector(self.statisticsButtonPress), for: .touchUpInside)
    }
    
    @objc func plantsButtonPress() {
        self.selectePage = 0
    }
    
    @objc func statisticsButtonPress() {
        self.selectePage = 1
    }
}
