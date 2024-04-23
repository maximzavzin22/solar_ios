//
//  AlarmContactView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 19/04/24.
//

import UIKit

class AlarmContactView: UIView {
    
    var alarmDetailController: AlarmDetailController?
    
    //personView
    let personView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let personTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = NSLocalizedString("contact_person", comment: "")
        return label
    }()
    
    let personValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let personSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(223, green: 223, blue: 223)
        return view
    }()
    //
    
    //methodView
    let methodView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let methodTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = NSLocalizedString("contact_method", comment: "")
        return label
    }()
    
    let methodValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let methodSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(223, green: 223, blue: 223)
        return view
    }()
    //
    
    //addressView
    let addressView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addressTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        label.text = NSLocalizedString("plant_address", comment: "")
        return label
    }()
    
    let addressValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        label.numberOfLines = 2
        return label
    }()
    
    let directionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "direction")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp

        self.setupView()
        self.setupPersonView()
        self.setupMethodView()
        self.setupAddressView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(personView)
        self.addSubview(methodView)
        self.addSubview(addressView)

        self.addConstraintsWithFormat("H:|[v0]|", views: personView)
        self.addConstraintsWithFormat("H:|[v0]|", views: methodView)
        self.addConstraintsWithFormat("H:|[v0]|", views: addressView)
        
        self.addConstraintsWithFormat("V:|[v0(\(48.dp))][v1(\(48.dp))][v2(\(52.dp))]", views: personView, methodView, addressView)
    }
    
    func setupPersonView() {
        personView.addSubview(personTitleLabel)
        personView.addSubview(personValueLabel)
        personView.addSubview(personSeperateView)
        
        personView.addConstraintsWithFormat("H:|-\(20.dp)-[v0(\(150.dp))]-\(6.dp)-[v1]-\(20.dp)-|", views: personTitleLabel, personValueLabel)
        personView.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(20.dp)-|", views: personSeperateView)
        
        personView.addConstraintsWithFormat("V:[v0]", views: personTitleLabel)
        personView.addConstraintsWithFormat("V:[v0]", views: personValueLabel)
        personView.addConstraintsWithFormat("V:[v0(\(1.dp))]|", views: personSeperateView)
        
        personTitleLabel.centerYAnchor.constraint(equalTo: personView.centerYAnchor).isActive = true
        personValueLabel.centerYAnchor.constraint(equalTo: personView.centerYAnchor).isActive = true
    }
    
    func setupMethodView() {
        methodView.addSubview(methodTitleLabel)
        methodView.addSubview(methodValueLabel)
        methodView.addSubview(methodSeperateView)
        
        methodView.addConstraintsWithFormat("H:|-\(20.dp)-[v0(\(130.dp))]-\(6.dp)-[v1]-\(20.dp)-|", views: methodTitleLabel, methodValueLabel)
        methodView.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(20.dp)-|", views: methodSeperateView)
        
        methodView.addConstraintsWithFormat("V:[v0]", views: methodTitleLabel)
        methodView.addConstraintsWithFormat("V:[v0]", views: methodValueLabel)
        methodView.addConstraintsWithFormat("V:[v0(\(1.dp))]|", views: methodSeperateView)
        
        methodTitleLabel.centerYAnchor.constraint(equalTo: methodView.centerYAnchor).isActive = true
        methodValueLabel.centerYAnchor.constraint(equalTo: methodView.centerYAnchor).isActive = true
    }
    
    func setupAddressView() {
        addressView.addSubview(addressTitleLabel)
        addressView.addSubview(addressValueLabel)
        addressView.addSubview(directionButton)
        
        addressView.addConstraintsWithFormat("H:|-\(20.dp)-[v0(\(130.dp))]-\(6.dp)-[v1]-\(10.dp)-[v2(\(46.dp))]-\(10.dp)-|", views: addressTitleLabel, addressValueLabel, directionButton)
        
        addressView.addConstraintsWithFormat("V:|-\(20.dp)-[v0]", views: addressTitleLabel)
        addressView.addConstraintsWithFormat("V:|-\(20.dp)-[v0]", views: addressValueLabel)
        addressView.addConstraintsWithFormat("V:|-\(10.dp)-[v0(\(46.dp))]", views: directionButton)
        
        directionButton.addTarget(self, action: #selector(self.directionButtonPress), for: .touchUpInside)
    }
    
    @objc func directionButtonPress() {
        print("directionButtonPress")
        self.alarmDetailController?.openApp()
    }
}
