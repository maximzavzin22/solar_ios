//
//  ProfileRowView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 22/04/24.
//

import UIKit

class ProfileRowView: UIView {
    
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
    
    let seperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(226, green: 226, blue: 226)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(iconImageView)
        self.addSubview(titleLabel)
        self.addSubview(arrowImageView)
        self.addSubview(seperateView)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0(\(24.dp))]-\(12.dp)-[v1][v2(\(10.dp))]-\(20.dp)-|", views: iconImageView, titleLabel, arrowImageView)
        self.addConstraintsWithFormat("H:|-\(56.dp)-[v0]-\(20.dp)-|", views: seperateView)
        
        self.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: iconImageView)
        self.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        self.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: arrowImageView)
        self.addConstraintsWithFormat("V:[v0(\(1.dp))]|", views: seperateView)
        
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
