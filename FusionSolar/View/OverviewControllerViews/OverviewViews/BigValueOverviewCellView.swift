//
//  BigValueOverviewCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 19/04/24.
//

import UIKit

class BigValueOverviewCellView: UIView {
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.textAlignment = .center
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 12.dp)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(valueLabel)
        self.addSubview(nameLabel)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: valueLabel)
        self.addConstraintsWithFormat("H:|[v0]|", views: nameLabel)
        
        self.addConstraintsWithFormat("V:|[v0][v1]", views: valueLabel, nameLabel)
    }
}
