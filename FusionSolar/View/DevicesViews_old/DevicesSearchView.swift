//
//  DevicesSearchView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 26/04/24.
//

import UIKit

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
        if let text = searchTextField.text {
            if(text != "") {
                self.isEditing = true
            }
        }
    }
    
    @objc func groupFilterButtonPress() {

    }
    
    @objc func clearButtonPress() {
        self.searchTextField.text = ""
        self.isEditing = false
        self.devicesView?.homeController?.doneButtonAction()
    }
}
