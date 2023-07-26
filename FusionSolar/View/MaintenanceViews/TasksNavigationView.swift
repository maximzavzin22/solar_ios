//
//  TasksNavigationView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 26/07/23.
//

import UIKit

class TasksNavigationView: UIView {
    
    var tasksCellView: TasksCellView?
    
    var selectePage: Int? {
        didSet {
            if((selectePage ?? 0) == 0) {
                inspectionLabel.textColor = .rgb(39, green: 87, blue: 238)
                inspectionSeperateView.isHidden = false
                
                eliminationLabel.textColor = .rgb(106, green: 106, blue: 106)
                eliminationSeperateView.isHidden = true
            } else {
                eliminationLabel.textColor = .rgb(39, green: 87, blue: 238)
                eliminationSeperateView.isHidden = false
                
                inspectionLabel.textColor = .rgb(106, green: 106, blue: 106)
                inspectionSeperateView.isHidden = true
            }
            self.tasksCellView?.scrollToMenuIndex()
        }
    }
    
    //inspectionView
    let inspectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inspectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.dp)
        label.text = NSLocalizedString("inspection_tasks", comment: "")
        label.textColor = .rgb(39, green: 87, blue: 238)
        return label
    }()
    
    let inspectionSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(39, green: 87, blue: 238)
        return view
    }()
    //
    
    //eliminationView
    let eliminationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let eliminationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18.dp)
        label.text = NSLocalizedString("elimination_tasks", comment: "")
        label.textColor = .rgb(106, green: 106, blue: 106)
        return label
    }()
    
    let eliminationSeperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(39, green: 87, blue: 238)
        return view
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.setupView()
        self.setupInspectionView()
        self.setupEliminationView()
        
        self.selectePage = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(inspectionView)
        self.addSubview(eliminationView)
        
        let inspectionViewWidth = self.getWidth(text: NSLocalizedString("inspection_tasks", comment: "")) + 5.dp
        let eliminationViewWidth = self.getWidth(text: NSLocalizedString("elimination_tasks", comment: "")) + 5.dp
        print("widths \(inspectionViewWidth) \(eliminationViewWidth)")
        self.addConstraintsWithFormat("H:[v0(\(inspectionViewWidth))]", views: inspectionView)
        self.addConstraintsWithFormat("H:[v0(\(eliminationViewWidth))]", views: eliminationView)
        
        self.addConstraintsWithFormat("V:|-\(15.dp)-[v0(\(48.dp))]", views: inspectionView)
        self.addConstraintsWithFormat("V:|-\(15.dp)-[v0(\(48.dp))]", views: eliminationView)
        
        inspectionView.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -12.dp).isActive = true
        eliminationView.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 12.dp).isActive = true
        
        let inspectionViewTap = UITapGestureRecognizer(target: self, action: #selector(self.inspectionViewPress))
        inspectionView.isUserInteractionEnabled = true
        inspectionView.addGestureRecognizer(inspectionViewTap)
        
        let eliminationViewTap = UITapGestureRecognizer(target: self, action: #selector(self.eliminationViewPress))
        eliminationView.isUserInteractionEnabled = true
        eliminationView.addGestureRecognizer(eliminationViewTap)
    }
    
    @objc func inspectionViewPress() {
        self.selectePage = 0
    }
    
    @objc func eliminationViewPress() {
        self.selectePage = 1
    }
    
    func setupInspectionView() {
        inspectionView.addSubview(inspectionLabel)
        inspectionView.addSubview(inspectionSeperateView)
        
        inspectionView.addConstraintsWithFormat("H:|[v0]|", views: inspectionLabel)
        inspectionView.addConstraintsWithFormat("H:|[v0]|", views: inspectionSeperateView)
        
        inspectionView.addConstraintsWithFormat("V:|-\(9.dp)-[v0]", views: inspectionLabel)
        inspectionView.addConstraintsWithFormat("V:[v0(\(2.dp))]-\(9.dp)-|", views: inspectionSeperateView)
    }
    
    func setupEliminationView() {
        eliminationView.addSubview(eliminationLabel)
        eliminationView.addSubview(eliminationSeperateView)
        
        eliminationView.addConstraintsWithFormat("H:|[v0]|", views: eliminationLabel)
        eliminationView.addConstraintsWithFormat("H:|[v0]|", views: eliminationSeperateView)
        
        eliminationView.addConstraintsWithFormat("V:|-\(9.dp)-[v0]", views: eliminationLabel)
        eliminationView.addConstraintsWithFormat("V:[v0(\(2.dp))]-\(9.dp)-|", views: eliminationSeperateView)
        
        eliminationSeperateView.isHidden = true
    }
    
    func getWidth(text: String) -> CGFloat {
        let dummySize = CGSize(width: 1000.dp, height: 15.dp)
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
