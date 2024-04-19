//
//  ValueOverviewView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 19/04/24.
//

import UIKit

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
