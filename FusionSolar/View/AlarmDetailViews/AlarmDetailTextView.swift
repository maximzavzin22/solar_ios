//
//  AlarmDetailTextView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 19/04/24.
//

import UIKit

class AlarmDetailTextView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.dp)
        label.textColor = .rgb(1, green: 6, blue: 10)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14.dp)
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp

        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(titleLabel)
        self.addSubview(valueLabel)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(20.dp)-|", views: titleLabel)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(20.dp)-|", views: valueLabel)
        
        self.addConstraintsWithFormat("V:|-\(24.dp)-[v0]-\(8.dp)-[v1]", views: titleLabel, valueLabel)
    }
}
