//
//  DevicesView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit

class DevicesView: UIView {
    
    var homeController: HomeController?
    
    var topSafeArea: CGFloat = 0.0
    
    //topView
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(241, green: 243, blue: 245)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("devices", comment: "")
        label.font = .boldSystemFont(ofSize: 24.dp)
        label.textColor = .rgb(1, green: 6, blue: 10)
        return label
    }()
    
   let searchDevicesView: SearchDevicesView = {
        let view = SearchDevicesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //
    
    let emptyView: EmptyDataView = {
        let view = EmptyDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var deviceTypeSearchView: DeviceTypeSearchView = {
        let view = DeviceTypeSearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.devicesView = self
        return view
    }()
    
    let loadingView: LoadingView = {
        let lV = LoadingView()
        lV.translatesAutoresizingMaskIntoConstraints = false
        return lV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupTopView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(topView)
        self.addSubview(emptyView)
        self.addSubview(deviceTypeSearchView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topView)
        self.addConstraintsWithFormat("H:[v0(\(143.dp))]", views: emptyView)
        self.addConstraintsWithFormat("H:|-\(35.dp)-[v0(\(170.dp))]", views: deviceTypeSearchView)
        
        let window = UIApplication.shared.keyWindow
        topSafeArea = window?.safeAreaInsets.top ?? 0.0
        
        self.addConstraintsWithFormat("V:|[v0(\(125.dp + topSafeArea))]", views: topView)
        self.addConstraintsWithFormat("V:[v0(\(154.dp))]", views: emptyView)
        self.addConstraintsWithFormat("V:[v0(\(97.dp))]", views: deviceTypeSearchView)
        
        deviceTypeSearchView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -8.dp).isActive = true
        deviceTypeSearchView.isHidden = true
        
        emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyView.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func showDeviceTypeSearchView() {
        deviceTypeSearchView.isHidden = false
    }
    
    func setupTopView() {
        topView.addSubview(titleLabel)
        topView.addSubview(searchDevicesView)
        
        topView.addConstraintsWithFormat("H:|-\(25.dp)-[v0]", views: titleLabel)
        topView.addConstraintsWithFormat("H:[v0(\(344.dp))]", views: searchDevicesView)
        
        topView.addConstraintsWithFormat("V:|-\(16.dp + topSafeArea)-[v0]-\(16.dp)-[v1(\(48.dp))]", views: titleLabel, searchDevicesView)
        
        searchDevicesView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        
        searchDevicesView.typeValue = "name"
        searchDevicesView.devicesView = self
    }
}

class SearchDevicesView: UIView {
    
    var devicesView: DevicesView? {
        didSet {
            devicesSearchView.devicesView = devicesView
        }
    }
    
    var typeValue: String? {
        didSet {
            print("typeValue \(typeValue)")
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
    }
    
    @objc func typeViewPress() {
        self.devicesView?.showDeviceTypeSearchView()
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

class DevicesSearchView: UIView {
    
    var devicesView: DevicesView?
    
    var isEditing: Bool? {
        didSet {
            if(isEditing ?? false) {
                clearButton.isHidden = false
                groupFilterButton.isHidden = true
            } else {
                clearButton.isHidden = true
                groupFilterButton.isHidden = false
            }
        }
    }
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 45.dp, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 52.dp, height: textField.frame.height))
        textField.rightView = rightPaddingView
        textField.rightViewMode = UITextField.ViewMode.always
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16.dp), .foregroundColor: UIColor.rgb(106, green: 106, blue: 106)]
        textField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("seacrh_device_name", comment: ""), attributes: attrs)
        textField.textColor = .rgb(1, green: 6, blue: 10)
        textField.font = UIFont.systemFont(ofSize: 16.dp)
        textField.textAlignment = .left
        textField.backgroundColor = .rgb(255, green: 255, blue: 255)
        textField.layer.cornerRadius = 24.dp
        return textField
    }()
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_search")
        return imageView
    }()
    
    let groupFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "btn")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "delete")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(searchTextField)
        self.addSubview(searchImageView)
        self.addSubview(groupFilterButton)
        self.addSubview(clearButton)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: searchTextField)
        self.addConstraintsWithFormat("H:|-\(17.dp)-[v0(\(20.dp))]", views: searchImageView)
        self.addConstraintsWithFormat("H:[v0(\(48.dp))]-\(2.dp)-|", views: groupFilterButton)
        self.addConstraintsWithFormat("H:[v0(\(48.dp))]-\(2.dp)-|", views: clearButton)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: searchTextField)
        self.addConstraintsWithFormat("V:[v0(\(20.dp))]", views: searchImageView)
        self.addConstraintsWithFormat("V:|[v0]|", views: groupFilterButton)
        self.addConstraintsWithFormat("V:|[v0]|", views: clearButton)
        
        searchImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        searchTextField.addTarget(self, action: #selector(searchTextFieldChaged), for: .allEditingEvents)
        groupFilterButton.addTarget(self, action: #selector(self.groupFilterButtonPress), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(self.clearButtonPress), for: .touchUpInside)
        
        clearButton.isHidden = true
    }
    
    @objc func searchTextFieldChaged() {
        print("searchTextFieldChaged")
        if let text = searchTextField.text {
            if(text != "") {
                self.isEditing = true
            }
        }
    }
    
    @objc func groupFilterButtonPress() {
        print("groupFilterButtonPress")
    }
    
    @objc func clearButtonPress() {
        print("clearButtonPress")
        self.searchTextField.text = ""
        self.isEditing = false
        self.devicesView?.homeController?.doneButtonAction()
    }
}
