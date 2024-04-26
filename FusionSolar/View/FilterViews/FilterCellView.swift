//
//  FilterCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 26/04/24.
//

import UIKit

class FilterCellView: UIView {
    
    var isSelected: Bool? {
        didSet {
            if(isSelected ?? false) {
                self.backgroundColor = .rgb(231, green: 238, blue: 254)
            } else {
                self.backgroundColor = .rgb(243, green: 243, blue: 243)
            }
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(243, green: 243, blue: 243)
        self.layer.cornerRadius = 14.dp
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(titleLabel)
        self.addConstraintsWithFormat("H:|-\(8.dp)-[v0]-\(8.dp)-|", views: titleLabel)
        self.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
