//
//  BasicInfoLargeView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 19/04/24.
//

import UIKit

class BasicInfoLargeView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        label.textAlignment = .right
        label.numberOfLines = 2
        return label
    }()
    
    let seperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(223, green: 223, blue: 223)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(titleLabel)
        self.addSubview(valueLabel)
        self.addSubview(seperateView)
        
        self.addConstraintsWithFormat("H:|-\(24.dp)-[v0(\(171.dp))]", views: titleLabel)
        self.addConstraintsWithFormat("H:[v0(\(171.dp))]-\(24.dp)-|", views: valueLabel)
        self.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: seperateView)
        
        self.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        self.addConstraintsWithFormat("V:[v0]", views: valueLabel)
        self.addConstraintsWithFormat("V:[v0(\(1.dp))]|", views: seperateView)
        
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
