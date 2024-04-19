//
//  BigValueOverviewView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 19/04/24.
//

import UIKit

class BigValueOverviewView: UIView {
    
    var contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.spacing = 9.dp
        view.axis = .horizontal
        view.alignment = .fill
        return view
    }()
    
    let monthBigValueOverviewCellView: BigValueOverviewCellView = {
        let view = BigValueOverviewCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = (NSLocalizedString("yield_this_month", comment: ""))
        return view
    }()
    
    let yearBigValueOverviewCellView: BigValueOverviewCellView = {
        let view = BigValueOverviewCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = (NSLocalizedString("yield_this_year", comment: ""))
        return view
    }()
    
    let totalBigValueOverviewCellView: BigValueOverviewCellView = {
        let view = BigValueOverviewCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = (NSLocalizedString("yield_this_total", comment: ""))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(contentView)
        self.addConstraintsWithFormat("H:|[v0]|", views: contentView)
        self.addConstraintsWithFormat("V:[v0(\(35.dp))]", views: contentView)

        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        monthBigValueOverviewCellView.widthAnchor.constraint(equalToConstant: 102.dp).isActive = true
        yearBigValueOverviewCellView.widthAnchor.constraint(equalToConstant: 102.dp).isActive = true
        totalBigValueOverviewCellView.widthAnchor.constraint(equalToConstant: 102.dp).isActive = true
        
        monthBigValueOverviewCellView.heightAnchor.constraint(equalToConstant: 35.dp).isActive = true
        yearBigValueOverviewCellView.heightAnchor.constraint(equalToConstant: 35.dp).isActive = true
        totalBigValueOverviewCellView.heightAnchor.constraint(equalToConstant: 35.dp).isActive = true
        
        contentView.addArrangedSubview(monthBigValueOverviewCellView)
        contentView.addArrangedSubview(yearBigValueOverviewCellView)
        contentView.addArrangedSubview(totalBigValueOverviewCellView)
    }
}
