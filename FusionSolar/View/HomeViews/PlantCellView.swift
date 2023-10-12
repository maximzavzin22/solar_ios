//
//  PlantCellView.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 21/07/23.
//

import UIKit

class PlantCellView: UICollectionViewCell {
    
    var station: Station? {
        didSet {
            titleLabel.text = station?.plantName ?? ""
            addressLabel.text = station?.plantAddress ?? ""
            if let capacity = station?.capacity {
                solarValueLabel.text = "\(capacity)\(NSLocalizedString("kwp", comment: ""))"
            }
            
            if let statusValue = station?.status {
                if(statusValue == 1) {
                    status = "normal"
                }
                if(statusValue == 2) {
                    status = "faulty"
                }
                if(statusValue == 3) {
                    status = "offline"
                }
            }
        }
    }
    
    var status: String? {
        didSet {
            if let value = status {
                if(value == "normal") {
                    statusLabel.text = NSLocalizedString("normal", comment: "")
                    statusLabel.textColor = .rgb(84, green: 164, blue: 110)
                    fonStatusView.backgroundColor = .rgb(236, green: 246, blue: 240)
                }
                if(value == "faulty") {
                    statusLabel.text = NSLocalizedString("faulty", comment: "")
                    statusLabel.textColor = .rgb(224, green: 69, blue: 76)
                    fonStatusView.backgroundColor = .rgb(255, green: 229, blue: 231)
                }
                if(value == "offline") {
                    statusLabel.text = NSLocalizedString("offline", comment: "")
                    statusLabel.textColor = .rgb(106, green: 106, blue: 106)
                    fonStatusView.backgroundColor = .rgb(242, green: 242, blue: 242)
                }
            }
            width = self.getWidth(text: statusLabel.text ?? "") + 8.dp + 8.dp + 8.dp
            nameLeftConstraint?.constant = -1 * width
            self.layoutIfNeeded()
        }
    }
    
    var nameLeftConstraint: NSLayoutConstraint?
    var width: CGFloat = 0
    
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16.dp
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "img1")
        imageView.layer.cornerRadius = 8.dp
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 12.dp)
        return label
    }()
    
    let fonStatusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4.dp
        return view
    }()
    
    //contentBlockView
    let contentBlockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .boldSystemFont(ofSize: 16.dp)
        label.numberOfLines = 1
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 12.dp)
        label.numberOfLines = 2
        return label
    }()
    
    //bottomView
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let solarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "solar")
        return imageView
    }()
    
    let solarValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(174, green: 174, blue: 174)
        label.font = .systemFont(ofSize: 12.dp)
        label.text = "--\(NSLocalizedString("kwp", comment: ""))"
        return label
    }()
    
    let energyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "energy")
        return imageView
    }()
    
    let energyValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(174, green: 174, blue: 174)
        label.font = .systemFont(ofSize: 12.dp)
        label.text = "--\(NSLocalizedString("kwh", comment: ""))"
        return label
    }()
    //
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .rgb(241, green: 243, blue: 245)

        self.setupView()
        self.setupBorderView()
        self.setupBottomView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func setupView() {
        self.addSubview(borderView)
        self.addConstraintsWithFormat("H:|-\(15.dp)-[v0]-\(15.dp)-|", views: borderView)
        self.addConstraintsWithFormat("V:[v0(\(117.dp))]", views: borderView)
        borderView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func setupBorderView() {
        borderView.addSubview(iconImageView)
        borderView.addSubview(fonStatusView)
        borderView.addSubview(statusLabel)
        borderView.addSubview(titleLabel)
        borderView.addSubview(addressLabel)
        borderView.addSubview(bottomView)
        
        borderView.addConstraintsWithFormat("H:|-\(16.dp)-[v0(\(72.dp))]", views: iconImageView)
        borderView.addConstraintsWithFormat("H:[v0]-\(18.dp)-|", views: statusLabel)
        borderView.addConstraintsWithFormat("H:|-\(101.dp)-[v0]-\(32.dp)-|", views: addressLabel)
        borderView.addConstraintsWithFormat("H:|-\(101.dp)-[v0(\(227.dp))]", views: bottomView)
        
        borderView.addConstraintsWithFormat("V:|-\(23.dp)-[v0(\(72.dp))]", views: iconImageView)
        borderView.addConstraintsWithFormat("V:[v0(\(22.dp))]", views: fonStatusView)
        borderView.addConstraintsWithFormat("V:|-\(18.dp)-[v0]", views: statusLabel)
        
        borderView.addConstraintsWithFormat("V:|-\(22.dp)-[v0]-\(6.dp)-[v1]", views: titleLabel, addressLabel)
        borderView.addConstraintsWithFormat("V:[v0(\(16.dp))]-\(21.dp)-|", views: bottomView)
        
        fonStatusView.leftAnchor.constraint(equalTo: statusLabel.leftAnchor, constant: -8.dp).isActive = true
        fonStatusView.rightAnchor.constraint(equalTo: statusLabel.rightAnchor, constant: 8.dp).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 13.dp).isActive = true
        nameLeftConstraint = titleLabel.anchor(nil, left: nil, bottom: nil, right: borderView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 32.dp, widthConstant: 0, heightConstant: 0)[0]
        nameLeftConstraint?.isActive = true
        
        fonStatusView.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor).isActive = true
    }
    
    func setupBottomView() {
        bottomView.addSubview(solarImageView)
        bottomView.addSubview(solarValueLabel)
        bottomView.addSubview(energyImageView)
        bottomView.addSubview(energyValueLabel)
        
        bottomView.addConstraintsWithFormat("H:|[v0(\(16.dp))]-\(6.dp)-[v1]", views: solarImageView, solarValueLabel)
        bottomView.addConstraintsWithFormat("H:|-\(90.dp)-[v0(\(16.dp))]-\(6.dp)-[v1]", views: energyImageView, energyValueLabel)
        
        bottomView.addConstraintsWithFormat("V:[v0(\(16.dp))]", views: solarImageView)
        bottomView.addConstraintsWithFormat("V:[v0]", views: solarValueLabel)
        bottomView.addConstraintsWithFormat("V:[v0(\(16.dp))]", views: energyImageView)
        bottomView.addConstraintsWithFormat("V:[v0]", views: energyValueLabel)
        
        solarImageView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        solarValueLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        energyImageView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        energyValueLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
    }
    
    func getWidth(text: String) -> CGFloat {
        let dummySize = CGSize(width: 1000.dp, height: 10.dp)
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let rect = descAttributedText(name: text).boundingRect(with: dummySize, options: options, context: nil)
        return rect.width
    }
    
    fileprivate func descAttributedText(name: String?) -> NSAttributedString {
        let text = name
        let attrs:[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.dp)]
        let normal = NSMutableAttributedString(string: text!, attributes:attrs)
        return normal
    }
}
