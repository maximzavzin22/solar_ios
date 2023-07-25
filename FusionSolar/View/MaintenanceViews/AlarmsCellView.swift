//
//  AlarmsCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 25/07/23.
//

import UIKit

class AlarmsCellView: UICollectionViewCell {
    
    var maintenanceView: MaintenanceView?
    
    //topView
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let alarmsStatisticView: AlarmsStatisticView = {
        let view = AlarmsStatisticView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //searchView
    let searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let alarmSearchView: AlarmSearchView = {
        let view = AlarmSearchView()
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
    //
    //
    
    let emptyView: EmptyDataView = {
        let view = EmptyDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        self.setupSearchView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func initKeyboard() {
        self.maintenanceView?.homeController?.setupToolbar()
    }
    
    func setupView() {
        self.addSubview(topView)
       // self.addSubview(emptyView)
       // self.addSubview(collectionView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: topView)
       // self.addConstraintsWithFormat("H:[v0(\(143.dp))]", views: emptyView)
       // self.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        
        //self.addConstraintsWithFormat("V:|[v0(\(219.dp))][v1]|", views: topView, collectionView)
        //self.addConstraintsWithFormat("V:|[v0(\(219.dp))]", views: topView)
        self.addConstraintsWithFormat("V:|[v0(\(519.dp))]", views: topView) //test
      //  self.addConstraintsWithFormat("V:[v0(\(154.dp))]", views: emptyView)
        
       // emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
       // emptyView.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupTopView() {
        topView.addSubview(alarmsStatisticView)
        topView.addSubview(searchView)
        
        topView.addConstraintsWithFormat("H:[v0(\(359.dp))]", views: alarmsStatisticView)
        topView.addConstraintsWithFormat("H:[v0(\(359.dp))]", views: searchView)
        
        //topView.addConstraintsWithFormat("V:|-\(16.dp)-[v0(\(100.dp))]-\(32.dp)-[v1(\(48.dp))]", views: alarmsStatisticView, searchView)
        topView.addConstraintsWithFormat("V:|-\(16.dp)-[v0(\(300.dp))]-\(32.dp)-[v1(\(48.dp))]", views: alarmsStatisticView, searchView) //test
        
        alarmsStatisticView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        searchView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
    }
    
    func setupSearchView() {
        searchView.addSubview(alarmSearchView)
        searchView.addSubview(filterButton)
        
        searchView.addConstraintsWithFormat("H:|[v0(\(321.dp))]-\(15.dp)-[v1(\(24.dp))]", views: alarmSearchView, filterButton)
        
        searchView.addConstraintsWithFormat("V:|[v0]|", views: alarmSearchView)
        searchView.addConstraintsWithFormat("V:[v0(\(24.dp))]", views: filterButton)
        
        filterButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        
        filterButton.addTarget(self, action: #selector(self.filterButtonPress), for: .touchUpInside)
        
        alarmSearchView.alarmsCellView = self
    }
    
    @objc func filterButtonPress() {
        print("filterButtonPress")

    }
}

class AlarmSearchView: UIView {
    
    var alarmsCellView: AlarmsCellView?
    
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
        textField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("search_alarm", comment: ""), attributes: attrs)
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

        
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(searchTextField)
        self.addSubview(searchImageView)
        self.addSubview(clearButton)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: searchTextField)
        self.addConstraintsWithFormat("H:|-\(17.dp)-[v0(\(20.dp))]", views: searchImageView)
        self.addConstraintsWithFormat("H:[v0(\(48.dp))]-\(2.dp)-|", views: clearButton)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: searchTextField)
        self.addConstraintsWithFormat("V:[v0(\(20.dp))]", views: searchImageView)
        self.addConstraintsWithFormat("V:|[v0]|", views: clearButton)
        
        searchImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
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
        self.alarmsCellView?.maintenanceView?.homeController?.doneButtonAction()
    }
}
