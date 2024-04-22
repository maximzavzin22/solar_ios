//
//  ProfileInfoView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 22/04/24.
//

import UIKit

class ProfileInfoView: UIView {

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "avatar")
        return imageView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 24.dp)
        label.text = HomeController.login
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = "test@gmail.com"
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
        self.addSubview(iconImageView)
        self.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        
        self.addConstraintsWithFormat("H:|-\(17.dp)-[v0(\(72.dp))]-\(16.dp)-[v1]|", views: iconImageView, contentView)
        contentView.addConstraintsWithFormat("H:|[v0]", views: nameLabel)
        contentView.addConstraintsWithFormat("H:|[v0]", views: emailLabel)
        
        self.addConstraintsWithFormat("V:[v0(\(72.dp))]", views: iconImageView)
        self.addConstraintsWithFormat("V:[v0(\(54.dp))]", views: contentView)
        contentView.addConstraintsWithFormat("V:|[v0]-\(6.dp)-[v1]", views: nameLabel, emailLabel)
        
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
