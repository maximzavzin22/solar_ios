//
//  StationDevicesNavigationView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 23/04/24.
//

import UIKit

class StationDevicesNavigationView: UIView {
    
    var stationDevicesView: StationDevicesView?
    
    var selectePage: Int? {
        didSet {
            if((selectePage ?? 0) == 0) {
                allLabel.textColor = .rgb(39, green: 87, blue: 238)
                allSeperateView.isHidden = false

                inverterLabel.textColor = .rgb(106, green: 106, blue: 106)
                inverterSeperateView.isHidden = true
                
                dongleLabel.textColor = .rgb(106, green: 106, blue: 106)
                dongleSeperateView.isHidden = true
                
                self.stationDevicesView?.filter = "all"
            }
            if((selectePage ?? 0) == 1) {
                inverterLabel.textColor = .rgb(39, green: 87, blue: 238)
                inverterSeperateView.isHidden = false

                allLabel.textColor = .rgb(106, green: 106, blue: 106)
                allSeperateView.isHidden = true
                
                dongleLabel.textColor = .rgb(106, green: 106, blue: 106)
                dongleSeperateView.isHidden = true
                
                self.stationDevicesView?.filter = "inverter"
            }
            if((selectePage ?? 0) == 2) {
                dongleLabel.textColor = .rgb(39, green: 87, blue: 238)
                dongleSeperateView.isHidden = false

                inverterLabel.textColor = .rgb(106, green: 106, blue: 106)
                inverterSeperateView.isHidden = true
                
                allLabel.textColor = .rgb(106, green: 106, blue: 106)
                allSeperateView.isHidden = true
                
                self.stationDevicesView?.filter = "dongle"
            }
        }
    }
    
    //allView
    var allViewWidth: CGFloat = 0.0
    let allView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let allLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.dp)
        label.text = NSLocalizedString("all", comment: "")
        label.textColor = .rgb(39, green: 87, blue: 238)
        return label
    }()
    
    let allSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(39, green: 87, blue: 238)
        return view
    }()
    //
    
    //inverterView
    var inverterViewWidth: CGFloat = 0.0
    let inverterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inverterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.dp)
        label.text = NSLocalizedString("inverter", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        return label
    }()
    
    let inverterSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(39, green: 87, blue: 238)
        return view
    }()
    //
    
    //dongleView
    var dongleViewWidth: CGFloat = 0.0
    let dongleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dongleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.dp)
        label.text = NSLocalizedString("dongle", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        return label
    }()
    
    let dongleSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(39, green: 87, blue: 238)
        return view
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rgb(241, green: 243, blue: 245)
        
        self.setupView()
        self.setupAllView()
        self.setupInverterView()
        self.setupDongleView()
        
        self.selectePage = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(allView)
        self.addSubview(inverterView)
        self.addSubview(dongleView)
        
        allViewWidth = self.getWidth(text: NSLocalizedString("all", comment: "")) + 5.dp
        inverterViewWidth = self.getWidth(text: NSLocalizedString("inverter", comment: "")) + 5.dp
        dongleViewWidth = self.getWidth(text: NSLocalizedString("dongle", comment: "")) + 5.dp
        
        print("allViewWidth \(allViewWidth)")
        print("inverterViewWidth \(inverterViewWidth)")
        print("dongleViewWidth \(dongleViewWidth)")
        
        self.addConstraintsWithFormat("H:[v0(\(allViewWidth))]", views: allView)
        self.addConstraintsWithFormat("H:[v0(\(inverterViewWidth))]", views: inverterView)
        self.addConstraintsWithFormat("H:[v0(\(dongleViewWidth))]", views: dongleView)
        
        self.addConstraintsWithFormat("V:|[v0]|", views: allView)
        self.addConstraintsWithFormat("V:|[v0]|", views: inverterView)
        self.addConstraintsWithFormat("V:|[v0]|", views: dongleView)
        
        allView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        inverterView.leftAnchor.constraint(equalTo: allView.rightAnchor, constant: 26.dp).isActive = true
        dongleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        let allViewTap = UITapGestureRecognizer(target: self, action: #selector(self.allViewPress))
        allView.isUserInteractionEnabled = true
        allView.addGestureRecognizer(allViewTap)
        
        let inverterViewTap = UITapGestureRecognizer(target: self, action: #selector(self.inverterViewPress))
        inverterView.isUserInteractionEnabled = true
        inverterView.addGestureRecognizer(inverterViewTap)
        
        let dongleViewTap = UITapGestureRecognizer(target: self, action: #selector(self.dongleViewPress))
        dongleView.isUserInteractionEnabled = true
        dongleView.addGestureRecognizer(dongleViewTap)
    }
    
    @objc func allViewPress() {
        self.selectePage = 0
    }
    
    @objc func inverterViewPress() {
        self.selectePage = 1
    }
    
    @objc func dongleViewPress() {
        self.selectePage = 2
    }
    
    func setupAllView() {
        allView.addSubview(allLabel)
        allView.addSubview(allSeperateView)
        
        allView.addConstraintsWithFormat("H:|[v0]|", views: allLabel)
        allView.addConstraintsWithFormat("H:|[v0]|", views: allSeperateView)
        
        allView.addConstraintsWithFormat("V:|-\(10.dp)-[v0]-\(10.dp)-[v1(\(2.dp))]", views: allLabel, allSeperateView)
    }
    
    func setupInverterView() {
        inverterView.addSubview(inverterLabel)
        inverterView.addSubview(inverterSeperateView)
        
        inverterView.addConstraintsWithFormat("H:|[v0]|", views: inverterLabel)
        inverterView.addConstraintsWithFormat("H:|[v0]|", views: inverterSeperateView)
        
        inverterView.addConstraintsWithFormat("V:|-\(10.dp)-[v0]-\(10.dp)-[v1(\(2.dp))]", views: inverterLabel, inverterSeperateView)
    }
    
    func setupDongleView() {
        dongleView.addSubview(dongleLabel)
        dongleView.addSubview(dongleSeperateView)
        
        dongleView.addConstraintsWithFormat("H:|[v0]|", views: dongleLabel)
        dongleView.addConstraintsWithFormat("H:|[v0]|", views: dongleSeperateView)
        
        dongleView.addConstraintsWithFormat("V:|-\(10.dp)-[v0]-\(10.dp)-[v1(\(2.dp))]", views: dongleLabel, dongleSeperateView)
    }
    
    func getWidth(text: String) -> CGFloat {
        let dummySize = CGSize(width: 1000.dp, height: 21.dp)
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let rect = descAttributedText(name: text).boundingRect(with: dummySize, options: options, context: nil)
        return rect.width
    }
    
    fileprivate func descAttributedText(name: String?) -> NSAttributedString {
        let text = name
        let attrs:[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.dp)]
        let normal = NSMutableAttributedString(string: text!, attributes:attrs)
        return normal
    }
}
