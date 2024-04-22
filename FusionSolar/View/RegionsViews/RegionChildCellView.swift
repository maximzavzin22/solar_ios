//
//  RegionChildCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 22/04/24.
//

import UIKit

class RegionChildCellView: UICollectionViewCell {
    
    var regionsController: RegionsController?
    
    var region: Region? {
        didSet {
            checkBox.isActive = region?.isSelected ?? false
            titleLabel.text = region?.node_name ?? ""
        }
    }
    
    let valueContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(0, green: 0, blue: 0)
        label.font = .systemFont(ofSize: 14.dp)
        return label
    }()
    
    let checkBox: CheckBox = {
        let view = CheckBox()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        self.setupView()
        self.setupValueContentView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(valueContentView)
        self.addConstraintsWithFormat("H:|[v0]|", views: valueContentView)
        self.addConstraintsWithFormat("V:|-\(8.dp)-[v0(\(20.dp))]", views: valueContentView)
    }
    
    func setupValueContentView() {
        valueContentView.addSubview(titleLabel)
        valueContentView.addSubview(checkBox)
        
        valueContentView.addConstraintsWithFormat("H:|-\(52.dp)-[v0]-\(14.dp)-[v1(\(20.dp))]-\(28.dp)-|", views: titleLabel, checkBox)
        
        valueContentView.addConstraintsWithFormat("V:[v0]", views: titleLabel)
        valueContentView.addConstraintsWithFormat("V:[v0(\(20.dp))]", views: checkBox)
        
        titleLabel.centerYAnchor.constraint(equalTo: valueContentView.centerYAnchor).isActive = true
        checkBox.centerYAnchor.constraint(equalTo: valueContentView.centerYAnchor).isActive = true
        
        let checkBoxTap = UITapGestureRecognizer(target: self, action: #selector(self.checkBoxPress))
        checkBox.isUserInteractionEnabled = true
        checkBox.addGestureRecognizer(checkBoxTap)
    }
    
    @objc func checkBoxPress() {
        self.region?.isSelected = !(self.region?.isSelected ?? false)
        self.regionsController?.collectionView.reloadData()
    }
}
