//
//  AlarmsStatistiValueView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 23/04/24.
//

import UIKit

class AlarmsStatistiValueView: UIView {
    
    var isSelected: Bool? {
        didSet {
            if(isSelected ?? false) {
                valueLabel.textColor = .rgb(39, green: 87, blue: 238)
                nameLabel.textColor = .rgb(39, green: 87, blue: 238)
            } else {
                valueLabel.textColor = .black
                nameLabel.textColor = .rgb(106, green: 106, blue: 106)
            }
        }
    }
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20.dp)
        return label
    }()
    
    let circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4.dp
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(valueLabel)
        self.addSubview(circleView)
        self.addSubview(nameLabel)
        
        self.addConstraintsWithFormat("H:|[v0]", views: valueLabel)
        self.addConstraintsWithFormat("H:|[v0(\(8.dp))]-\(6.dp)-[v1]|", views: circleView, nameLabel)
        
        self.addConstraintsWithFormat("V:|[v0]-\(8.dp)-[v1]", views: valueLabel, nameLabel)
        self.addConstraintsWithFormat("V:[v0(\(8.dp))]", views: circleView)
        
        circleView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    }
}
