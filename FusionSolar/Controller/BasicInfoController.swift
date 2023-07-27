//
//  BasicInfoController.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 27/07/23.
//

import UIKit

class BasicInfoController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    var station: Station? {
        didSet {
            self.titleLabel.text = station?.plantName ?? ""
        }
    }
    
    //headerView
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "back")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .rgb(1, green: 6, blue: 10)
        label.font = .systemFont(ofSize: 16.dp)
        label.numberOfLines = 0
        return label
    }()
    //
    
}
