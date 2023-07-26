//
//  InspectionTasksCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 26/07/23.
//

import UIKit

class InspectionTasksCellView: UICollectionViewCell {
    
    var tasksCellView: TasksCellView?
    
    lazy var searchView: SearchInspectionTasksView = {
        let view = SearchInspectionTasksView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.inspectionTasksCellView = self
        return view
    }()
    
    let emptyView: EmptyDataView = {
        let view = EmptyDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .rgb(241, green: 243, blue: 245)

        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(searchView)
        self.addSubview(emptyView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: searchView)
        self.addConstraintsWithFormat("H:[v0(\(143.dp))]", views: emptyView)
        
        self.addConstraintsWithFormat("V:|[v0(\(78.dp))]", views: searchView)
        self.addConstraintsWithFormat("V:[v0(\(154.dp))]", views: emptyView)
        
        emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func initKeyboard() {
        self.tasksCellView?.maintenanceView?.homeController?.setupToolbar()
    }
}

class SearchInspectionTasksView: UIView {
    
    var inspectionTasksCellView: InspectionTasksCellView?
    
    var isEditing: Bool? {
        didSet {
            if(isEditing ?? false) {
                clearButton.isHidden = false
            } else {
                clearButton.isHidden = true
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
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18.dp), .foregroundColor: UIColor.rgb(106, green: 106, blue: 106)]
        textField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("search_task", comment: ""), attributes: attrs)
        textField.textColor = .rgb(1, green: 6, blue: 10)
        textField.font = UIFont.systemFont(ofSize: 18.dp)
        textField.textAlignment = .left
        textField.backgroundColor = .rgb(245, green: 244, blue: 244)
        textField.layer.cornerRadius = 24.dp
        return textField
    }()
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_search")
        return imageView
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

        self.backgroundColor = .white
        
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(searchTextField)
        self.addSubview(searchImageView)
        self.addSubview(clearButton)
        
        self.addConstraintsWithFormat("H:[v0(\(360.dp))]", views: searchTextField)
        self.addConstraintsWithFormat("H:[v0(\(20.dp))]", views: searchImageView)
        self.addConstraintsWithFormat("H:[v0(\(48.dp))]", views: clearButton)
        
        self.addConstraintsWithFormat("V:[v0(\(48.dp))]", views: searchTextField)
        self.addConstraintsWithFormat("V:[v0(\(20.dp))]", views: searchImageView)
        self.addConstraintsWithFormat("V:[v0(\(48.dp))]", views: clearButton)
        
        searchTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        searchImageView.leftAnchor.constraint(equalTo: searchTextField.leftAnchor, constant: 17.dp).isActive = true
        clearButton.rightAnchor.constraint(equalTo: searchTextField.rightAnchor, constant: -2.dp).isActive = true
        
        searchTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        searchImageView.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true
        clearButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true
        
        searchTextField.addTarget(self, action: #selector(searchTextFieldChaged), for: .allEditingEvents)
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
    
    @objc func clearButtonPress() {
        print("clearButtonPress")
        self.searchTextField.text = ""
        self.isEditing = false
        self.inspectionTasksCellView?.tasksCellView?.maintenanceView?.homeController?.doneButtonAction()
    }
}
