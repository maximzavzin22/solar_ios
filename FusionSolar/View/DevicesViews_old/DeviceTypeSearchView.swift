//
//  DeviceTypeSearchView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit

class DeviceTypeSearchView: UIView {
    
    var devicesView: DevicesView?
    
    let nameRowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 18.dp)
        label.text = NSLocalizedString("name", comment: "")
        return label
    }()
    
    let seperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(223, green: 223, blue: 223)
        return view
    }()
    
    let cnRowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cnLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 18.dp)
        label.text = NSLocalizedString("sn", comment: "")
        return label
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
        self.addSubview(nameRowView)
        nameRowView.addSubview(nameLabel)
        self.addSubview(seperateView)
        self.addSubview(cnRowView)
        cnRowView.addSubview(cnLabel)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: nameRowView)
        nameRowView.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: nameLabel)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(20.dp)-|", views: seperateView)
        self.addConstraintsWithFormat("H:|[v0]|", views: cnRowView)
        cnRowView.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: cnLabel)
        
        self.addConstraintsWithFormat("V:|[v0(\(48.dp))][v1(\(1.dp))][v2(\(48.dp))]", views: nameRowView, seperateView, cnRowView)
        nameRowView.addConstraintsWithFormat("V:[v0]", views: nameLabel)
        cnRowView.addConstraintsWithFormat("V:[v0]", views: cnLabel)
        
        nameLabel.centerYAnchor.constraint(equalTo: nameRowView.centerYAnchor).isActive = true
        cnLabel.centerYAnchor.constraint(equalTo: cnRowView.centerYAnchor).isActive = true
        
        let nameRowViewTap = UITapGestureRecognizer(target: self, action: #selector(self.nameRowViewPress))
        nameRowView.isUserInteractionEnabled = true
        nameRowView.addGestureRecognizer(nameRowViewTap)
        
        let cnRowViewTap = UITapGestureRecognizer(target: self, action: #selector(self.cnRowViewPress))
        cnRowView.isUserInteractionEnabled = true
        cnRowView.addGestureRecognizer(cnRowViewTap)
    }
    
    @objc func nameRowViewPress() {
        self.devicesView?.searchDevicesView.typeValue = "name"
        self.isHidden = true
    }
    
    @objc func cnRowViewPress() {
        self.devicesView?.searchDevicesView.typeValue = "sn"
        self.isHidden = true
    }
}
