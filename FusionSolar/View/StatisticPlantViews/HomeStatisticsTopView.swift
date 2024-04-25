//
//  HomeStatisticsTopView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 24/04/24.
//

import UIKit

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
