//
//  PlantsTopView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 18/04/24.
//

import UIKit

class PlantsTopView: UIView {
    
    var isSelect: Bool? {
        didSet {
            if(isSelect ?? false) {
                self.backgroundColor = .rgb(239, green: 244, blue: 254)
                self.layer.borderColor = UIColor.rgb(101, green: 142, blue: 245).cgColor
                self.layer.borderWidth = 1.dp
            } else {
                self.backgroundColor = .rgb(245, green: 244, blue: 244)
                self.layer.borderWidth = 0.dp
            }
        }
    }
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20.dp)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 12.dp)
        label.textColor = .rgb(106, green: 106, blue: 106)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .rgb(245, green: 244, blue: 244)
        self.layer.cornerRadius = 16.dp
        
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(valueLabel)
        self.addSubview(titleLabel)
        
        self.addConstraintsWithFormat("H:[v0]", views: valueLabel)
        self.addConstraintsWithFormat("H:[v0]", views: titleLabel)
        
        self.addConstraintsWithFormat("V:|-\(10.dp)-[v0]", views: valueLabel)
        self.addConstraintsWithFormat("V:[v0]-\(10.dp)-|", views: titleLabel)
        
        valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
