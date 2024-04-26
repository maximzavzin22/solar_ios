//
//  EnvironmentalView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 18/04/24.
//

import UIKit

class EnvironmentalView: UIView {
    
    var detailRealKpis: [DetailRealKpi]? {
        didSet {
            var reductionTotalCo2: Double = 0.0
            var reductionTotalCoal: Double = 0.0
            var reductionTotalTree: Double = 0.0
            
            for detailRealKpi in detailRealKpis ?? [] {
                reductionTotalCo2 = reductionTotalCo2 + (detailRealKpi.reduction_total_co2 ?? 0.0)
                reductionTotalCoal = reductionTotalCoal + (detailRealKpi.reduction_total_coal ?? 0.0)
                reductionTotalTree = reductionTotalTree + (detailRealKpi.reduction_total_tree ?? 0.0)
            }
            
            if(reductionTotalCoal > 1000) {
                coalEnvironmentalCellView.valueLabel.text = "\((reductionTotalCoal/1000.0).rounded(toPlaces: 2))k \(NSLocalizedString("t", comment: ""))"
            } else {
                coalEnvironmentalCellView.valueLabel.text = "\(reductionTotalCoal.rounded(toPlaces: 2)) \(NSLocalizedString("t", comment: ""))"
            }
            
            if(reductionTotalCo2 > 1000) {
                co2EnvironmentalCellView.valueLabel.text = "\((reductionTotalCo2/1000.0).rounded(toPlaces: 2))k \(NSLocalizedString("t", comment: ""))"
            } else {
                co2EnvironmentalCellView.valueLabel.text = "\(reductionTotalCo2.rounded(toPlaces: 2)) \(NSLocalizedString("t", comment: ""))"
            }
            
            if(reductionTotalTree > 1000.0) {
                treesEnvironmentalCellView.valueLabel.text = "\((reductionTotalTree/1000.0).rounded(toPlaces: 2))k"
            } else {
                treesEnvironmentalCellView.valueLabel.text = "\(Int(reductionTotalTree))"
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
    var contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.spacing = 10.dp
        view.axis = .horizontal
        view.alignment = .fill
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
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(20.dp)-|", views: contentView)
        
        self.addConstraintsWithFormat("V:|-\(24.dp)-[v0]-\(19.dp)-[v1(\(130.dp))]", views: titleLabel, contentView)
        
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func setupContentView() {
        coalEnvironmentalCellView.widthAnchor.constraint(equalToConstant: 100.dp).isActive = true
        co2EnvironmentalCellView.widthAnchor.constraint(equalToConstant: 100.dp).isActive = true
        treesEnvironmentalCellView.widthAnchor.constraint(equalToConstant: 100.dp).isActive = true
        
        coalEnvironmentalCellView.heightAnchor.constraint(equalToConstant: 130.dp).isActive = true
        coalEnvironmentalCellView.heightAnchor.constraint(equalToConstant: 130.dp).isActive = true
        coalEnvironmentalCellView.heightAnchor.constraint(equalToConstant: 130.dp).isActive = true
        
        contentView.addArrangedSubview(coalEnvironmentalCellView)
        contentView.addArrangedSubview(co2EnvironmentalCellView)
        contentView.addArrangedSubview(treesEnvironmentalCellView)
    }
}
