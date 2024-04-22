//
//  ProfileRowFonView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 22/04/24.
//

import UIKit

class ProfileRowFonView: UIView {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "arrow")
        return imageView
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
        self.addSubview(titleLabel)
        self.addSubview(arrowImageView)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0(\(24.dp))]-\(12.dp)-[v1][v2(\(10.dp))]-\(20.dp)-|", views: iconImageView, titleLabel, arrowImageView)
        
        self.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: iconImageView)
        self.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        self.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: arrowImageView)
        
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
