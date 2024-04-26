//
//  SearchDevicesView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 26/04/24.
//

import UIKit

class SearchDevicesView: UIView {
    
    var devicesView: DevicesView? {
        didSet {
            devicesSearchView.devicesView = devicesView
        }
    }
    
    var typeValue: String? {
        didSet {
            if(typeValue ?? "" == "name") {
                let text = NSLocalizedString("name", comment: "")
                typeLabel.text = text
                width = self.getWidth(text: text) + 6.dp + 12.dp
                let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16.dp), .foregroundColor: UIColor.rgb(106, green: 106, blue: 106)]
                self.devicesSearchView.searchTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("seacrh_device_name", comment: ""), attributes: attrs)
            }
            if(typeValue ?? "" == "sn") {
                let text = NSLocalizedString("sn", comment: "")
                typeLabel.text = text
                width = self.getWidth(text: text) + 6.dp + 12.dp
                let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16.dp), .foregroundColor: UIColor.rgb(106, green: 106, blue: 106)]
                self.devicesSearchView.searchTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("seacrh_device_sn", comment: ""), attributes: attrs)
            }
            viewWidthConstraint?.constant = width
            self.layoutIfNeeded()
        }
    }
    
    var viewWidthConstraint: NSLayoutConstraint?
    var width: CGFloat = 0
    
    //typeView
    let typeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 18.dp)
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "arrow_down")
        return imageView
    }()
    //
    
    lazy var devicesSearchView: DevicesSearchView = {
        let view = DevicesSearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupTypeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(typeView)
        self.addSubview(devicesSearchView)
        self.addSubview(filterButton)
        
        self.addConstraintsWithFormat("H:[v0(\(44.dp))]", views: filterButton)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: typeView)
        self.addConstraintsWithFormat("V:|[v0]|", views: devicesSearchView)
        self.addConstraintsWithFormat("V:[v0(\(44.dp))]", views: filterButton)
        
        typeView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        width = 49.dp + 6.dp + 12.dp
        viewWidthConstraint = typeView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: width, heightConstant: 0)[0]
        viewWidthConstraint?.isActive = true
        
        devicesSearchView.leftAnchor.constraint(equalTo: typeView.rightAnchor, constant: 10.dp).isActive = true
        devicesSearchView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -45.dp).isActive = true
        filterButton.leftAnchor.constraint(equalTo: devicesSearchView.rightAnchor).isActive = true
        
        filterButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        let typeViewTap = UITapGestureRecognizer(target: self, action: #selector(self.typeViewPress))
        typeView.isUserInteractionEnabled = true
        typeView.addGestureRecognizer(typeViewTap)
        
        filterButton.addTarget(self, action: #selector(self.filterButtonPress), for: .touchUpInside)
    }
    
    @objc func typeViewPress() {
        self.devicesView?.showDeviceTypeSearchView()
    }
    
    @objc func filterButtonPress() {
        self.devicesView?.homeController?.openDeviceFilterView()
    }
    
    func setupTypeView() {
        typeView.addSubview(typeLabel)
        typeView.addSubview(arrowImageView)
        
        typeView.addConstraintsWithFormat("H:|[v0]", views: typeLabel)
        typeView.addConstraintsWithFormat("H:[v0(\(12.dp))]|", views: arrowImageView)
        
        typeView.addConstraintsWithFormat("V:[v0]", views: typeLabel)
        typeView.addConstraintsWithFormat("V:[v0(\(12.dp))]", views: arrowImageView)
        
        typeLabel.centerYAnchor.constraint(equalTo: typeView.centerYAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: typeView.centerYAnchor).isActive = true
    }
    
    func getWidth(text: String) -> CGFloat {
        let dummySize = CGSize(width: 1000.dp, height: 15.dp)
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let rect = descAttributedText(name: text).boundingRect(with: dummySize, options: options, context: nil)
        return rect.width
    }
    
    fileprivate func descAttributedText(name: String?) -> NSAttributedString {
        let text = name
        let attrs:[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.dp)]
        let normal = NSMutableAttributedString(string: text!, attributes:attrs)
        return normal
    }
}
