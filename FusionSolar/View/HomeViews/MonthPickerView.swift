//
//  MonthPickerView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 24/07/23.
//

import UIKit

class MonthPickerView: UIView {
    
    var homeController: HomeController?
    var overviewController: OverviewController?
    var graphView: GraphView?
    var stationChartsView: StationChartsView?
    
    var selectedDate: Date? {
        didSet {
            if let date = selectedDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM yyyy"
                titleLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
    var viewBottomConstraint: NSLayoutConstraint?
    var height: CGFloat = 0
    var bottomSafeArea: CGFloat = 0
    
    let blackoutView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 32.dp
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 24.dp)
        return label
    }()
    
    let datePicker: MonthYearWheelPicker = {
        let dP = MonthYearWheelPicker()
        dP.translatesAutoresizingMaskIntoConstraints = false
       // dP.datePickerMode = .date
       // dP.preferredDatePickerStyle = .wheels
      //  dP.maximumDate = Date()
      //  dP.minimumDate = Date(-2)
        return dP
    }()
    
    //buttonsView
    let buttonsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        button.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        button.titleLabel?.textColor = .rgb(39, green: 87, blue: 238)
        button.titleLabel?.font = .systemFont(ofSize: 18.dp)
        button.tintColor = .rgb(39, green: 87, blue: 238)
        button.layer.cornerRadius = 21.dp
        return button
    }()
    
    let seperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(204, green: 204, blue: 204)
        return view
    }()
    
    let okButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        button.setTitle(NSLocalizedString("ok", comment: ""), for: .normal)
        button.titleLabel?.textColor = .rgb(39, green: 87, blue: 238)
        button.titleLabel?.font = .systemFont(ofSize: 18.dp)
        button.tintColor = .rgb(39, green: 87, blue: 238)
        button.layer.cornerRadius = 21.dp
        return button
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupBorderView()
        self.setupButtonsView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let window = UIApplication.shared.keyWindow
        var topSafeArea: CGFloat = 0.0
        topSafeArea = window?.safeAreaInsets.top ?? 0
        bottomSafeArea = window?.safeAreaInsets.bottom ?? 0
        
        self.addSubview(blackoutView)
        self.addBlurEffect()
        self.addSubview(borderView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: blackoutView)
        self.addConstraintsWithFormat("H:|[v0]|", views: borderView)
        self.addConstraintsWithFormat("V:|[v0]|", views: blackoutView)
        
        height = 392.dp + bottomSafeArea
        self.addConstraintsWithFormat("V:[v0(\(height))]", views: borderView)
        
        viewBottomConstraint = borderView.anchor(nil, left: nil, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: (-1 * height), rightConstant: 0, widthConstant: 0, heightConstant: 0)[0]
        viewBottomConstraint?.isActive = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeBlackoutView))
        blackoutView.isUserInteractionEnabled = true
        blackoutView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupBorderView() {
        borderView.addSubview(titleLabel)
        borderView.addSubview(datePicker)
        borderView.addSubview(buttonsView)
        
        borderView.addConstraintsWithFormat("H:[v0]", views: titleLabel)
        borderView.addConstraintsWithFormat("H:[v0(\(342.dp))]", views: datePicker)
        borderView.addConstraintsWithFormat("H:[v0(\(342.dp))]", views: buttonsView)
        
        borderView.addConstraintsWithFormat("V:|-\(24.dp)-[v0]-\(12.dp)-[v1(\(266.dp))]", views: titleLabel, datePicker)
        borderView.addConstraintsWithFormat("V:[v0(\(42.dp))]", views: buttonsView)
        
        titleLabel.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        buttonsView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        
        buttonsView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -1 * bottomSafeArea).isActive = true
        datePicker.addTarget(self, action: #selector(self.datePickerChanged), for: .valueChanged)
    }
    
    @objc func datePickerChanged() {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        var strDate = dateFormatter.string(from: datePicker.date)
        self.selectedDate = datePicker.date
    }
    
    func setupButtonsView() {
        buttonsView.addSubview(cancelButton)
        buttonsView.addSubview(seperateView)
        buttonsView.addSubview(okButton)
        
        buttonsView.addConstraintsWithFormat("H:|[v0(\(162.dp))]-\(8.5.dp)-[v1(\(1.dp))]-\(8.5.dp)-[v2(\(162.dp))]", views: cancelButton, seperateView, okButton)
        
        buttonsView.addConstraintsWithFormat("V:|[v0]|", views: cancelButton)
        buttonsView.addConstraintsWithFormat("V:|[v0]|", views: okButton)
        buttonsView.addConstraintsWithFormat("V:[v0(\(18.dp))]", views: seperateView)
        
        seperateView.centerYAnchor.constraint(equalTo: buttonsView.centerYAnchor).isActive = true
        
        cancelButton.addTarget(self, action: #selector(self.cancelButtonPress), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(self.okButtonPress), for: .touchUpInside)
    }
    
    @objc func cancelButtonPress() {
        print("cancelButtonPress")
        self.hideAnimation()
    }
    
    @objc func okButtonPress() {
        print("okButtonPress")
        self.graphView?.selectedDate = self.selectedDate
        self.stationChartsView?.selectedDate = self.selectedDate
        self.hideAnimation()
    }
    
    func hideAnimation() {
        viewBottomConstraint?.constant = height
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.blackoutView.alpha = 0
            self.layoutIfNeeded()
        }) { (completed: Bool) in
            self.blackoutView.isHidden = true
            self.borderView.isHidden = true
            self.isHidden = true
        }
    }
    
    func showAnimaton() {
        print("showAnimaton")
        viewBottomConstraint?.constant = 0.dp
        blackoutView.alpha = 0
        blackoutView.isHidden = false
        borderView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.blackoutView.alpha = 1
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    var blurEffectView: UIVisualEffectView?
    
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = self.bounds
        
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView!)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeBlackoutView))
        blurEffectView?.isUserInteractionEnabled = true
        blurEffectView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func closeBlackoutView() {
        print("close Status View")
        hideAnimation()
    }
}

