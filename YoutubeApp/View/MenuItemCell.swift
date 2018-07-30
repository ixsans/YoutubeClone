//
//  MenuItemCell.swift
//  YoutubeApp
//
//  Created by Ikhsan on 25/7/18.
//  Copyright © 2018 Yanmii. All rights reserved.
//

import UIKit

class MenuItemCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_home")
        return iv
    }()
    
    let bottomLineIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.isHidden = true
        return view
    }()
    
    let imgTintColor: UIColor = {
       return UIColor.rgb(red: 91, green: 14, blue: 13)
    }()
    
    override var isHighlighted: Bool {
        didSet{
            imageView.tintColor = isHighlighted ? UIColor.white : imgTintColor
        }
    }
    
    override var isSelected: Bool {
        didSet{
            imageView.tintColor = isSelected ? UIColor.white : imgTintColor
            bottomLineIndicator.isHidden = !isSelected
        }
    }
    
    override func setupView() {
        addSubview(imageView)
        addSubview(bottomLineIndicator)
        
        addConstraintWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintWithFormat(format: "V:[v0(28)]", views: imageView)
        
        //addConstraintWithFormat(format: "H:[v0(10)]", views: bottomLineIndicator)
        addConstraintWithFormat(format: "H:|[v0]|", views: bottomLineIndicator)
        addConstraintWithFormat(format: "V:[v0(4)]|", views: bottomLineIndicator)
        
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
