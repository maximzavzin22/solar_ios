//
//  PlantMapInfoView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 28/07/23.
//

import UIKit

class PlantMapInfoView: UIView {
    
    var homeController: HomeController?
    
    var station: Station? {
        didSet {
            self.titleLabel.text = station?.plantName ?? ""
            self.plantMapInfoContentView.station = station
        }
    }
    
    var viewBottomConstraint: NSLayoutConstraint?
    var height: CGFloat = 0
    var bottomSafeArea: CGFloat = 0
    
    let blackoutView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        return view
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 32.dp
        return view
    }()
    
    let topGrayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(230, green: 230, blue: 230)
        view.layer.cornerRadius = 3.dp
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 18.dp)
        label.numberOfLines = 2
        return label
    }()
    
    let plantMapInfoContentView: PlantMapInfoContentView = {
        let view = PlantMapInfoContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupBorderView()
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
        self.addSubview(borderView)
        
        self.addConstraintsWithFormat("H:|[v0]|", views: blackoutView)
        self.addConstraintsWithFormat("H:|[v0]|", views: borderView)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: blackoutView)
        height = 266.dp + bottomSafeArea
        self.addConstraintsWithFormat("V:[v0(\(height))]", views: borderView)
        
        viewBottomConstraint = borderView.anchor(nil, left: nil, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: (-1 * height), rightConstant: 0, widthConstant: 0, heightConstant: 0)[0]
        viewBottomConstraint?.isActive = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeBlackoutView))
        blackoutView.isUserInteractionEnabled = true
        blackoutView.addGestureRecognizer(tapGestureRecognizer)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownGesture))
        swipeDown.direction = .down
        borderView.addGestureRecognizer(swipeDown)
    }
    
    @objc func swipeDownGesture() {
        hideAnimation()
    }
    
    func setupBorderView() {
        borderView.addSubview(topGrayView)
        borderView.addSubview(titleLabel)
        borderView.addSubview(plantMapInfoContentView)
        
        borderView.addConstraintsWithFormat("H:[v0(\(42.dp))]", views: topGrayView)
        borderView.addConstraintsWithFormat("H:|-\(24.dp)-[v0]-\(24.dp)-|", views: titleLabel)
        borderView.addConstraintsWithFormat("H:|[v0]|", views: plantMapInfoContentView)
        
        borderView.addConstraintsWithFormat("V:|-\(12.dp)-[v0(\(6.dp))]", views: topGrayView)
        borderView.addConstraintsWithFormat("V:|-\(32.dp)-[v0]-\(8.dp)-[v1(\(196.dp))]", views: titleLabel, plantMapInfoContentView)
        
        topGrayView.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        
        let borderViewTap = UITapGestureRecognizer(target: self, action: #selector(self.borderViewPress))
        borderView.isUserInteractionEnabled = true
        borderView.addGestureRecognizer(borderViewTap)
    }
    
    @objc func borderViewPress() {
        if let station = self.station {
            self.homeController?.openOverviewController(station: station)
        }
        self.hideAnimation()
    }
    
    func hideAnimation() {
        viewBottomConstraint?.constant = height
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }) { (completed: Bool) in
            self.borderView.isHidden = true
            self.isHidden = true
        }
    }
    
    func showAnimaton() {
        print("showAnimaton")
        viewBottomConstraint?.constant = 0.dp
        borderView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func closeBlackoutView() {
        print("close Status View")
        hideAnimation()
    }
}


