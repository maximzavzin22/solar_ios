//
//  EnvironmentalView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 18/04/24.
//

import UIKit

class EnvironmentalView: UIView {
    
    var total_power: Double? {
        didSet {
            if let value = total_power {
//                let coalEnvironmental = 398.0 * value / 1000.0
                let coalEnvironmental = value / 2460.0
                print("coalEnvironmental \(coalEnvironmental) \(value)")
                if(coalEnvironmental > 1000) {
                    coalEnvironmentalCellView.valueLabel.text = "\((coalEnvironmental/1000.0).rounded(toPlaces: 2))k \(NSLocalizedString("t", comment: ""))"
                } else {
                    coalEnvironmentalCellView.valueLabel.text = "\(coalEnvironmental.rounded(toPlaces: 2)) \(NSLocalizedString("t", comment: ""))"
                }
                
                let co2Count = (0.846 * value) / 2204.6 //футы -> тонны
//                let co2Count = value * 0.00070555
                if(co2Count > 1000) {
                    co2EnvironmentalCellView.valueLabel.text = "\((co2Count/1000.0).rounded(toPlaces: 2))k \(NSLocalizedString("t", comment: ""))"
                } else {
                    co2EnvironmentalCellView.valueLabel.text = "\(co2Count.rounded(toPlaces: 2)) \(NSLocalizedString("t", comment: ""))"
                }
                
                //let treesCount = 125.0 * value / 10000.0
                //let treesCount = value / 55.3
               // let treesCount = co2Count * 0.039//0.0075//0.021//
                let treesCount = value / 55.3 / 10
                if(treesCount > 1000.0) {
                    treesEnvironmentalCellView.valueLabel.text = "\((treesCount/1000.0).rounded(toPlaces: 2))k"
                } else {
                    treesEnvironmentalCellView.valueLabel.text = "\(treesCount.rounded(toPlaces: 2))"
                }
                
            }
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("environmental_benefits", comment: "")
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 18.dp)
        return label
    }()
    
    //contentView
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let coalEnvironmentalCellView: EnvironmentalCellView = {
        let view = EnvironmentalCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.valueLabel.text = "0.00 \(NSLocalizedString("t", comment: ""))"
        view.titleLabel.text = NSLocalizedString("standard_coal_saved", comment: "")
        view.backgroundColor = .rgb(208, green: 232, blue: 255)
        view.animatioName = "stroyka"
        return view
    }()
    
    let co2EnvironmentalCellView: EnvironmentalCellView = {
        let view = EnvironmentalCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.valueLabel.text = "0.00 \(NSLocalizedString("t", comment: ""))"
        view.titleLabel.text = NSLocalizedString("co2_reduced", comment: "")
        view.backgroundColor = .rgb(255, green: 236, blue: 217)
        view.animatioName = "zavod"
        return view
    }()
    
    let treesEnvironmentalCellView: EnvironmentalCellView = {
        let view = EnvironmentalCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.valueLabel.text = "0"
        view.titleLabel.text = NSLocalizedString("equivalent_trees_planted", comment: "")
        view.backgroundColor = .rgb(198, green: 255, blue: 218)
        view.animatioName = "ELKI 2"
        return view
    }()
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.layer.cornerRadius = 16.dp

        self.setupView()
        self.setupContentView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
 
    func setupView() {
        self.addSubview(titleLabel)
        self.addSubview(contentView)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]", views: titleLabel)
        self.addConstraintsWithFormat("H:[v0(\(320.dp))]", views: contentView)
        
        self.addConstraintsWithFormat("V:|-\(24.dp)-[v0]-\(19.dp)-[v1(\(130.dp))]", views: titleLabel, contentView)
        
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func setupContentView() {
        contentView.addSubview(coalEnvironmentalCellView)
        contentView.addSubview(co2EnvironmentalCellView)
        contentView.addSubview(treesEnvironmentalCellView)
        
        contentView.addConstraintsWithFormat("H:|[v0(\(100.dp))]-\(10.dp)-[v1(\(100.dp))]-\(10.dp)-[v2(\(100.dp))]", views: coalEnvironmentalCellView, co2EnvironmentalCellView, treesEnvironmentalCellView)
        
        contentView.addConstraintsWithFormat("V:|[v0]|", views: coalEnvironmentalCellView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: co2EnvironmentalCellView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: treesEnvironmentalCellView)
    }
}
