//
//  StatisticPlantCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 22/07/23.
//

import UIKit

class StatisticPlantCellView: UICollectionViewCell {
    
    var index: Int? {
        didSet {
            if var newIndex = index {
                newIndex = newIndex + 1
                numberLabel.text = "\(newIndex)"
                numberLabel.textColor = .rgb(1, green: 6, blue: 10)
                if(newIndex == 1) {
                    flagImageView.image = UIImage(named: "flag_1")
                    numberLabel.textColor = .white
                }
                if(newIndex == 2) {
                    flagImageView.image = UIImage(named: "flag_2")
                    numberLabel.textColor = .white
                }
                if(newIndex == 3) {
                    flagImageView.image = UIImage(named: "flag_3")
                    numberLabel.textColor = .white
                }
            }
        }
    }
    
    var station: Station? {
        didSet {
            self.nameLabel.text = station?.plantName ?? ""
            if let attitude = station?.attitude {
                self.valueLabel.text = "\(attitude.rounded(toPlaces: 2))"
            }
            
        }
    }
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17.dp)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 23.dp
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "img1")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14.dp)
        label.numberOfLines = 2
        label.textColor = .rgb(1, green: 6, blue: 10)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16.dp)
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.text = "0.00"
        return label
    }()
    
    let parametrLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12.dp)
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.text = "\(NSLocalizedString("kwh", comment: ""))/\(NSLocalizedString("kwp", comment: ""))"
        return label
    }()
    
    let seperateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .rgb(106, green: 106, blue: 106)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(flagImageView)
        self.addSubview(numberLabel)
        self.addSubview(iconImageView)
        self.addSubview(valueLabel)
        self.addSubview(parametrLabel)
        self.addSubview(seperateView)
        self.addSubview(nameLabel)
        
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0(\(28.dp))]-\(13.dp)-[v1(\(46.dp))]", views: flagImageView, iconImageView)
        self.addConstraintsWithFormat("H:[v0]-\(4.dp)-[v1]-\(20.dp)-|", views: valueLabel, parametrLabel)
        self.addConstraintsWithFormat("H:[v0]", views: numberLabel)
        self.addConstraintsWithFormat("H:|-\(20.dp)-[v0]-\(20.dp)-|", views: seperateView)
        
        self.addConstraintsWithFormat("V:[v0(\(32.dp))]", views: flagImageView)
        self.addConstraintsWithFormat("V:[v0]", views: numberLabel)
        self.addConstraintsWithFormat("V:[v0(\(46.dp))]", views: iconImageView)
        self.addConstraintsWithFormat("V:[v0]", views: nameLabel)
        self.addConstraintsWithFormat("V:[v0]", views: valueLabel)
        self.addConstraintsWithFormat("V:[v0]", views: parametrLabel)
        self.addConstraintsWithFormat("V:[v0(\(1.dp))]|", views: seperateView)
        
        numberLabel.centerXAnchor.constraint(equalTo: flagImageView.centerXAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10.dp).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: valueLabel.leftAnchor, constant: -5.dp).isActive = true
        
        flagImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        parametrLabel.bottomAnchor.constraint(equalTo: valueLabel.bottomAnchor).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: flagImageView.centerYAnchor).isActive = true
    }
}
