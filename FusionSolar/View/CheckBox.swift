//
//  CheckBox.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 22/04/24.
//

import UIKit

class CheckBox: UIView {
    
    var isActive: Bool? {
        didSet {
            if(isActive ?? false) {
                checkImageView.isHidden = false
                borderView.backgroundColor = .rgb(39, green: 87, blue: 238)
                borderView.layer.borderWidth = 0.dp
            } else {
                checkImageView.isHidden = true
                borderView.backgroundColor = .white
                borderView.layer.borderWidth = 1.dp
            }
        }
    }
    
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5.dp
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.rgb(175, green: 175, blue: 175).cgColor
        return view
    }()
    
    let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_check")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(borderView)
        borderView.addSubview(checkImageView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: borderView)
        borderView.addConstraintsWithFormat("H:[v0(\(12.dp))]", views: checkImageView)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: borderView)
        borderView.addConstraintsWithFormat("V:[v0(\(10.dp))]", views: checkImageView)
        
        checkImageView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        checkImageView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
    }
    
}
