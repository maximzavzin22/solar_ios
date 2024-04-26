//
//  PlantsFilterView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit

class PlantsFilterView: UIView {
    
    var homeController: HomeController?
    
    var fromDate: Date?
    var toDate: Date?
    var selectedCapacityMin: Double?
    var selectedCapacityMax: Double?
    
    var viewBottomConstraint: NSLayoutConstraint?
    var viewHeightConstraint: NSLayoutConstraint?
    var height: CGFloat = 0
    var bottomSafeArea: CGFloat = 0
    
    var isDatePickerShow: Bool? {
        didSet {
            if(isDatePickerShow ?? false) {
                height = 392.dp + 200.dp + bottomSafeArea
                datePicker.isHidden = false
            } else {
                height = 392.dp + bottomSafeArea
                datePicker.isHidden = true
            }
            self.viewHeightConstraint?.constant = height
            self.layoutIfNeeded()
        }
    }
    
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
        label.text = NSLocalizedString("filter", comment: "")
        return label
    }()
    
    //capacityView
    let capacityView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let capacityTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("total_string_capacity", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let cap1FilterCellView: FilterCellView = {
        let view = FilterCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("all", comment: "")
        view.isSelected = true
        return view
    }()
    
    let cap2FilterCellView: FilterCellView = {
        let view = FilterCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "10-50 \(NSLocalizedString("kwp", comment: ""))"
        view.isSelected = false
        return view
    }()
    
    let cap3FilterCellView: FilterCellView = {
        let view = FilterCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "100 \(NSLocalizedString("kwp", comment: ""))-1 \(NSLocalizedString("mwp", comment: ""))"
        view.isSelected = false
        return view
    }()
    
    let cap4FilterCellView: FilterCellView = {
        let view = FilterCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "0-10 \(NSLocalizedString("kwp", comment: ""))"
        view.isSelected = false
        return view
    }()
    
    let cap5FilterCellView: FilterCellView = {
        let view = FilterCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "50-100 \(NSLocalizedString("kwp", comment: ""))"
        view.isSelected = false
        return view
    }()
    
    let cap6FilterCellView: FilterCellView = {
        let view = FilterCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "> 1 \(NSLocalizedString("mwp", comment: ""))"
        view.isSelected = false
        return view
    }()
    //
    
    //dateConnectionView
    let dateConnectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateConnectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("grid_connection_date", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let dateSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(197, green: 197, blue: 197)
        return view
    }()
    
    let fromFilterCellView: FilterCellView = {
        let view = FilterCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("start_time", comment: "")
        view.isSelected = false
        return view
    }()
    
    let toFilterCellView: FilterCellView = {
        let view = FilterCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("end_time", comment: "")
        view.isSelected = false
        return view
    }()
    //
    
    let datePicker: UIDatePicker = {
        let dP = UIDatePicker()
        dP.translatesAutoresizingMaskIntoConstraints = false
        dP.datePickerMode = .date
        dP.preferredDatePickerStyle = .wheels
        return dP
    }()
    
    //buttonsView
    let buttonsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        button.setTitle(NSLocalizedString("reset", comment: ""), for: .normal)
        button.titleLabel?.textColor = .rgb(39, green: 87, blue: 238)
        button.titleLabel?.font = .systemFont(ofSize: 18.dp)
        button.tintColor = .rgb(39, green: 87, blue: 238)
        button.layer.cornerRadius = 21.dp
        return button
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .rgb(39, green: 87, blue: 238)
        button.setTitle(NSLocalizedString("confirm", comment: ""), for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18.dp)
        button.tintColor = .white
        button.layer.cornerRadius = 21.dp
        return button
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupBorderView()
        self.setupCapacityView()
        self.setupDateConnectionView()
        self.setupButtonsView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(blackoutView)
        self.addBlurEffect()
        self.addSubview(borderView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: blackoutView)
        self.addConstraintsWithFormat("H:|[v0]|", views: borderView)
        self.addConstraintsWithFormat("V:|[v0]|", views: blackoutView)
        
        height = 392.dp + HomeController.bottomSafeArea
        
        viewBottomConstraint = borderView.anchor(nil, left: nil, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: (-1 * height), rightConstant: 0, widthConstant: 0, heightConstant: 0)[0]
        viewBottomConstraint?.isActive = true
        viewHeightConstraint = borderView.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: height)[0]
        viewHeightConstraint?.isActive = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeBlackoutView))
        blackoutView.isUserInteractionEnabled = true
        blackoutView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupBorderView() {
        borderView.addSubview(titleLabel)
        borderView.addSubview(capacityView)
        borderView.addSubview(dateConnectionView)
        borderView.addSubview(datePicker)
        borderView.addSubview(buttonsView)
        
        borderView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]", views: titleLabel)
        borderView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: capacityView)
        borderView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: dateConnectionView)
        borderView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: datePicker)
        borderView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: buttonsView)
        
        borderView.addConstraintsWithFormat("V:|-\(24.dp)-[v0]-\(20.dp)-[v1(\(139.dp))]-\(28.dp)-[v2(\(59.dp))]", views: titleLabel, capacityView, dateConnectionView)
        borderView.addConstraintsWithFormat("V:[v0(\(42.dp))]", views: buttonsView)
        borderView.addConstraintsWithFormat("V:[v0(\(200.dp))]", views: datePicker)
        
        capacityView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        dateConnectionView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        buttonsView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        
        datePicker.topAnchor.constraint(equalTo: dateConnectionView.bottomAnchor, constant: 16.dp).isActive = true
        buttonsView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -1 * bottomSafeArea).isActive = true
        
        datePicker.addTarget(self, action: #selector(self.datePickerChanged), for: .valueChanged)
        
        datePicker.isHidden = true
    }
    
    @objc func datePickerChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        let strDate = dateFormatter.string(from: datePicker.date)
        if(fromFilterCellView.isSelected ?? false) {
            fromFilterCellView.titleLabel.text = strDate
            self.fromDate = datePicker.date
        }
        if(toFilterCellView.isSelected ?? false) {
            toFilterCellView.titleLabel.text = strDate
            self.toDate = datePicker.date
        }
    }
    
    func setupCapacityView() {
        capacityView.addSubview(capacityTitleLabel)
        capacityView.addSubview(cap1FilterCellView)
        capacityView.addSubview(cap2FilterCellView)
        capacityView.addSubview(cap3FilterCellView)
        capacityView.addSubview(cap4FilterCellView)
        capacityView.addSubview(cap5FilterCellView)
        capacityView.addSubview(cap6FilterCellView)
        
        capacityView.addConstraintsWithFormat("H:|[v0]", views: capacityTitleLabel)

        capacityView.addConstraintsWithFormat("V:|[v0]-\(12.dp)-[v1(\(28.dp))]-\(12.dp)-[v2(\(28.dp))]-\(12.dp)-[v3(\(28.dp))]", views: capacityTitleLabel, cap1FilterCellView, cap2FilterCellView, cap3FilterCellView)
        capacityView.addConstraintsWithFormat("V:[v0(\(28.dp))]", views: cap4FilterCellView)
        capacityView.addConstraintsWithFormat("V:[v0(\(28.dp))]", views: cap5FilterCellView)
        capacityView.addConstraintsWithFormat("V:[v0(\(28.dp))]", views: cap6FilterCellView)
        
        cap1FilterCellView.leftAnchor.constraint(equalTo: capacityView.leftAnchor).isActive = true
        cap1FilterCellView.rightAnchor.constraint(equalTo: capacityView.centerXAnchor, constant: -9.dp).isActive = true
        cap2FilterCellView.leftAnchor.constraint(equalTo: capacityView.leftAnchor).isActive = true
        cap2FilterCellView.rightAnchor.constraint(equalTo: capacityView.centerXAnchor, constant: -9.dp).isActive = true
        cap3FilterCellView.leftAnchor.constraint(equalTo: capacityView.leftAnchor).isActive = true
        cap3FilterCellView.rightAnchor.constraint(equalTo: capacityView.centerXAnchor, constant: -9.dp).isActive = true
        cap4FilterCellView.leftAnchor.constraint(equalTo: capacityView.centerXAnchor, constant: 9.dp).isActive = true
        cap4FilterCellView.rightAnchor.constraint(equalTo: capacityView.rightAnchor).isActive = true
        cap5FilterCellView.leftAnchor.constraint(equalTo: capacityView.centerXAnchor, constant: 9.dp).isActive = true
        cap5FilterCellView.rightAnchor.constraint(equalTo: capacityView.rightAnchor).isActive = true
        cap6FilterCellView.leftAnchor.constraint(equalTo: capacityView.centerXAnchor, constant: 9.dp).isActive = true
        cap6FilterCellView.rightAnchor.constraint(equalTo: capacityView.rightAnchor).isActive = true
        
        cap4FilterCellView.centerYAnchor.constraint(equalTo: cap1FilterCellView.centerYAnchor).isActive = true
        cap5FilterCellView.centerYAnchor.constraint(equalTo: cap2FilterCellView.centerYAnchor).isActive = true
        cap6FilterCellView.centerYAnchor.constraint(equalTo: cap3FilterCellView.centerYAnchor).isActive = true
        
        let cap1FilterCellViewTap = UITapGestureRecognizer(target: self, action: #selector(self.cap1FilterCellViewPress))
        cap1FilterCellView.isUserInteractionEnabled = true
        cap1FilterCellView.addGestureRecognizer(cap1FilterCellViewTap)
        
        let cap2FilterCellViewTap = UITapGestureRecognizer(target: self, action: #selector(self.cap2FilterCellViewPress))
        cap2FilterCellView.isUserInteractionEnabled = true
        cap2FilterCellView.addGestureRecognizer(cap2FilterCellViewTap)
        
        let cap3FilterCellViewTap = UITapGestureRecognizer(target: self, action: #selector(self.cap3FilterCellViewPress))
        cap3FilterCellView.isUserInteractionEnabled = true
        cap3FilterCellView.addGestureRecognizer(cap3FilterCellViewTap)
        
        let cap4FilterCellViewTap = UITapGestureRecognizer(target: self, action: #selector(self.cap4FilterCellViewPress))
        cap4FilterCellView.isUserInteractionEnabled = true
        cap4FilterCellView.addGestureRecognizer(cap4FilterCellViewTap)
        
        let cap5FilterCellViewTap = UITapGestureRecognizer(target: self, action: #selector(self.cap5FilterCellViewPress))
        cap5FilterCellView.isUserInteractionEnabled = true
        cap5FilterCellView.addGestureRecognizer(cap5FilterCellViewTap)
        
        let cap6FilterCellViewTap = UITapGestureRecognizer(target: self, action: #selector(self.cap6FilterCellViewPress))
        cap6FilterCellView.isUserInteractionEnabled = true
        cap6FilterCellView.addGestureRecognizer(cap6FilterCellViewTap)
    }
    
    @objc func cap1FilterCellViewPress() {
        self.unSelectAll()
        cap1FilterCellView.isSelected = true
        self.selectedCapacityMin = 0.0
        self.selectedCapacityMax = 0.0
    }
    
    @objc func cap2FilterCellViewPress() {
        self.unSelectAll()
        cap2FilterCellView.isSelected = true
        self.selectedCapacityMin = 10.0
        self.selectedCapacityMax = 50.0
    }
    
    @objc func cap3FilterCellViewPress() {
        self.unSelectAll()
        cap3FilterCellView.isSelected = true
        self.selectedCapacityMin = 100.0
        self.selectedCapacityMax = 1000.0
    }
    
    @objc func cap4FilterCellViewPress() {
        self.unSelectAll()
        cap4FilterCellView.isSelected = true
        self.selectedCapacityMin = 0.0
        self.selectedCapacityMax = 10.0
    }
    
    @objc func cap5FilterCellViewPress() {
        self.unSelectAll()
        cap5FilterCellView.isSelected = true
        self.selectedCapacityMin = 50.0
        self.selectedCapacityMax = 100.0
    }
    
    @objc func cap6FilterCellViewPress() {
        self.unSelectAll()
        cap6FilterCellView.isSelected = true
        self.selectedCapacityMin = 1000.0
        self.selectedCapacityMax = 1000.0
    }
    
    func unSelectAll() {
        cap1FilterCellView.isSelected = false
        cap2FilterCellView.isSelected = false
        cap3FilterCellView.isSelected = false
        cap4FilterCellView.isSelected = false
        cap5FilterCellView.isSelected = false
        cap6FilterCellView.isSelected = false
    }
    
    func setupDateConnectionView() {
        dateConnectionView.addSubview(dateConnectionTitleLabel)
        dateConnectionView.addSubview(fromFilterCellView)
        dateConnectionView.addSubview(dateSeperateView)
        dateConnectionView.addSubview(toFilterCellView)
        
        dateConnectionView.addConstraintsWithFormat("H:|[v0]", views: dateConnectionTitleLabel)
        dateConnectionView.addConstraintsWithFormat("H:[v0(\(10.dp))]", views: dateSeperateView)
        
        dateConnectionView.addConstraintsWithFormat("V:|[v0]-\(12.dp)-[v1(\(28.dp))]", views: dateConnectionTitleLabel, fromFilterCellView)
        dateConnectionView.addConstraintsWithFormat("V:[v0(\(1.dp))]", views: dateSeperateView)
        dateConnectionView.addConstraintsWithFormat("V:[v0(\(28.dp))]", views: toFilterCellView)
        
        fromFilterCellView.leftAnchor.constraint(equalTo: dateConnectionView.leftAnchor).isActive = true
        fromFilterCellView.rightAnchor.constraint(equalTo: dateConnectionView.centerXAnchor, constant: -9.dp).isActive = true
        dateSeperateView.centerXAnchor.constraint(equalTo: dateConnectionView.centerXAnchor).isActive = true
        toFilterCellView.leftAnchor.constraint(equalTo: dateConnectionView.centerXAnchor, constant: 9.dp).isActive = true
        toFilterCellView.rightAnchor.constraint(equalTo: dateConnectionView.rightAnchor).isActive = true
        
        toFilterCellView.centerYAnchor.constraint(equalTo: fromFilterCellView.centerYAnchor).isActive = true
        dateSeperateView.centerYAnchor.constraint(equalTo: fromFilterCellView.centerYAnchor).isActive = true
        
        let fromFilterCellViewTap = UITapGestureRecognizer(target: self, action: #selector(self.fromFilterCellViewPress))
        fromFilterCellView.isUserInteractionEnabled = true
        fromFilterCellView.addGestureRecognizer(fromFilterCellViewTap)
        
        let toFilterCellViewTap = UITapGestureRecognizer(target: self, action: #selector(self.toFilterCellViewPress))
        toFilterCellView.isUserInteractionEnabled = true
        toFilterCellView.addGestureRecognizer(toFilterCellViewTap)
    }
    
    @objc func fromFilterCellViewPress() {
        self.isDatePickerShow = true
        self.fromFilterCellView.isSelected = true
        self.toFilterCellView.isSelected = false
    }
    
    @objc func toFilterCellViewPress() {
        self.isDatePickerShow = true
        self.fromFilterCellView.isSelected = false
        self.toFilterCellView.isSelected = true
        if(self.fromDate != nil) {
            self.datePicker.minimumDate = self.fromDate
        }
    }
    
    func setupButtonsView() {
        buttonsView.addSubview(resetButton)
        buttonsView.addSubview(confirmButton)
        
        buttonsView.addConstraintsWithFormat("V:|[v0]|", views: resetButton)
        buttonsView.addConstraintsWithFormat("V:|[v0]|", views: confirmButton)
        
        resetButton.leftAnchor.constraint(equalTo: buttonsView.leftAnchor).isActive = true
        resetButton.rightAnchor.constraint(equalTo: buttonsView.centerXAnchor, constant: -9.dp).isActive = true
        confirmButton.leftAnchor.constraint(equalTo: buttonsView.centerXAnchor, constant: 9.dp).isActive = true
        confirmButton.rightAnchor.constraint(equalTo: buttonsView.rightAnchor).isActive = true
        
        resetButton.addTarget(self, action: #selector(self.resetButtonPress), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(self.confirmButtonPress), for: .touchUpInside)
    }
    
    @objc func resetButtonPress() {
        self.unSelectAll()
        self.cap1FilterCellView.isSelected = true
        self.fromDate = nil
        self.toDate = nil
        self.selectedCapacityMin = nil
        self.selectedCapacityMax = nil
        self.sendData()
        self.homeController?.homeView.plantsView.isFilter = false
        self.fromFilterCellView.titleLabel.text = NSLocalizedString("start_time", comment: "")
        self.fromFilterCellView.isSelected = false
        self.toFilterCellView.titleLabel.text = NSLocalizedString("end_time", comment: "")
        self.toFilterCellView.isSelected = false
        self.isDatePickerShow = false
        self.hideAnimation()
    }
    
    @objc func confirmButtonPress() {
        self.isDatePickerShow = false
        self.hideAnimation()
        var isFilter = true
        if((self.cap1FilterCellView.isSelected ?? false) && fromDate == nil && toDate == nil) {
            isFilter = false
        }
        if(!(self.cap1FilterCellView.isSelected ?? false) || fromDate != nil || toDate != nil) {
            isFilter = true
        }
        self.sendData()
        self.homeController?.homeView.plantsView.isFilter = isFilter
    }
    
    func sendData() {
        self.homeController?.homeView.plantsView.fromDate = self.fromDate
        self.homeController?.homeView.plantsView.toDate = self.toDate
        self.homeController?.homeView.plantsView.capacityMin = self.selectedCapacityMin
        self.homeController?.homeView.plantsView.capacityMax = self.selectedCapacityMax
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
        
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView!)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeBlackoutView))
        blurEffectView?.isUserInteractionEnabled = true
        blurEffectView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func closeBlackoutView() {
        self.isDatePickerShow = false
        hideAnimation()
    }
}
