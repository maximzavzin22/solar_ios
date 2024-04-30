//
//  DeviceFilterView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 26/07/23.
//

import UIKit

class DeviceFilterView: UIView {
    
    var homeController: HomeController?
    
    var viewBottomConstraint: NSLayoutConstraint?
    var height: CGFloat = 0
    
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
    
    //typeView
    let typeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let typeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("device_type", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        label.font = .systemFont(ofSize: 16.dp)
        return label
    }()
    
    let type1FilterCellView: FilterCellView = {
        let view = FilterCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("all", comment: "")
        view.isSelected = true
        return view
    }()
    
    let type2FilterCellView: FilterCellView = {
        let view = FilterCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("inverter", comment: "")
        view.isSelected = false
        return view
    }()
    
    let type3FilterCellView: FilterCellView = {
        let view = FilterCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = NSLocalizedString("dongle", comment: "")
        view.isSelected = false
        return view
    }()
    //
    
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
        self.setupTypeView()
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
        
        height = 220.dp + HomeController.bottomSafeArea
        self.addConstraintsWithFormat("V:[v0(\(height))]", views: borderView)
        
        viewBottomConstraint = borderView.anchor(nil, left: nil, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: (-1 * height), rightConstant: 0, widthConstant: 0, heightConstant: 0)[0]
        viewBottomConstraint?.isActive = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeBlackoutView))
        blackoutView.isUserInteractionEnabled = true
        blackoutView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupBorderView() {
        borderView.addSubview(titleLabel)
        borderView.addSubview(typeView)
        borderView.addSubview(buttonsView)
        
        borderView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]", views: titleLabel)
        borderView.addConstraintsWithFormat("H:[v0(\(342.dp))]", views: typeView)
        borderView.addConstraintsWithFormat("H:[v0(\(342.dp))]", views: buttonsView)
        
        borderView.addConstraintsWithFormat("V:|-\(24.dp)-[v0]-\(20.dp)-[v1(\(59.dp))]", views: titleLabel, typeView)
        borderView.addConstraintsWithFormat("V:[v0(\(42.dp))]", views: buttonsView)
        
        typeView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        buttonsView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        
        buttonsView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -1 * HomeController.bottomSafeArea).isActive = true
    }
    
    func setupTypeView() {
        typeView.addSubview(typeTitleLabel)
        typeView.addSubview(type1FilterCellView)
        typeView.addSubview(type2FilterCellView)
        typeView.addSubview(type3FilterCellView)
        
        typeView.addConstraintsWithFormat("H:|[v0]", views: typeTitleLabel)
        typeView.addConstraintsWithFormat("H:|[v0(\(102.dp))]-\(18.dp)-[v1(\(102.dp))]-\(18.dp)-[v2(\(102.dp))]", views: type1FilterCellView, type2FilterCellView, type3FilterCellView)
        
        typeView.addConstraintsWithFormat("V:|[v0]-\(12.dp)-[v1(\(28.dp))]", views: typeTitleLabel, type1FilterCellView)
        typeView.addConstraintsWithFormat("V:[v0(\(28.dp))]", views: type2FilterCellView)
        typeView.addConstraintsWithFormat("V:[v0(\(28.dp))]", views: type3FilterCellView)
        
        type2FilterCellView.centerYAnchor.constraint(equalTo: type1FilterCellView.centerYAnchor).isActive = true
        type3FilterCellView.centerYAnchor.constraint(equalTo: type1FilterCellView.centerYAnchor).isActive = true
        
        let type1FilterCellViewTap = UITapGestureRecognizer(target: self, action: #selector(self.type1FilterCellViewPress))
        type1FilterCellView.isUserInteractionEnabled = true
        type1FilterCellView.addGestureRecognizer(type1FilterCellViewTap)
        
        let type2FilterCellViewTap = UITapGestureRecognizer(target: self, action: #selector(self.type2FilterCellViewPress))
        type2FilterCellView.isUserInteractionEnabled = true
        type2FilterCellView.addGestureRecognizer(type2FilterCellViewTap)
        
        let type3FilterCellViewTap = UITapGestureRecognizer(target: self, action: #selector(self.type3FilterCellViewPress))
        type3FilterCellView.isUserInteractionEnabled = true
        type3FilterCellView.addGestureRecognizer(type3FilterCellViewTap)
    }
    
    @objc func type1FilterCellViewPress() {
        self.unSelectAll()
        type1FilterCellView.isSelected = true
    }
    
    @objc func type2FilterCellViewPress() {
        self.unSelectAll()
        type2FilterCellView.isSelected = true
    }
    
    @objc func type3FilterCellViewPress() {
        self.unSelectAll()
        type3FilterCellView.isSelected = true
    }
    
    func unSelectAll() {
        type1FilterCellView.isSelected = false
        type2FilterCellView.isSelected = false
        type3FilterCellView.isSelected = false
    }
    
    func setupButtonsView() {
        buttonsView.addSubview(resetButton)
        buttonsView.addSubview(confirmButton)
        
        buttonsView.addConstraintsWithFormat("H:|[v0(\(162.dp))]-\(18.dp)-[v1(\(162.dp))]", views: resetButton, confirmButton)
        
        buttonsView.addConstraintsWithFormat("V:|[v0]|", views: resetButton)
        buttonsView.addConstraintsWithFormat("V:|[v0]|", views: confirmButton)
        
        resetButton.addTarget(self, action: #selector(self.resetButtonPress), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(self.confirmButtonPress), for: .touchUpInside)
    }
    
    @objc func resetButtonPress() {
        type1FilterCellView.isSelected = true
        type2FilterCellView.isSelected = false
        type3FilterCellView.isSelected = false
        self.hideAnimation()
    }
    
    @objc func confirmButtonPress() {
        self.hideAnimation()
        if(!(self.type1FilterCellView.isSelected ?? false)) {
            
        } else {

        }
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
        
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView!)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeBlackoutView))
        blurEffectView?.isUserInteractionEnabled = true
        blurEffectView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func closeBlackoutView() {
        hideAnimation()
    }
}
