//
//  CharacterCell.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 3/1/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    let image: CustomImageView = {
        let imgView = CustomImageView()
        imgView.layer.cornerRadius = 8
        imgView.backgroundColor = Colors.lightGray
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    
    let imgSelected: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = Colors.appRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textBlack
        label.text = "Marvel Hero"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.initViews()
        self.isSelected(false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        
        self.addSubview(imgSelected)
        imgSelected.widthAnchor.constraint(equalToConstant: 76).isActive = true
        imgSelected.heightAnchor.constraint(equalToConstant: 78).isActive = true
        
        self.addSubview(image)
        image.widthAnchor.constraint(equalToConstant: 70).isActive = true
        image.heightAnchor.constraint(equalToConstant: 72).isActive = true
        NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 3).isActive = true
        NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: imgSelected, attribute: .centerX, relatedBy: .equal, toItem: image, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imgSelected, attribute: .centerY, relatedBy: .equal, toItem: image, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        self.addSubview(name)
        self.addConstraintsWithFormat(format: "H:|-3-[v0]-3-|", views: name)
        NSLayoutConstraint(item: name, attribute: .top, relatedBy: .equal, toItem: image, attribute: .bottom, multiplier: 1, constant: 4).isActive = true
    }
    
    func isSelected(_ bool: Bool) {
        imgSelected.isHidden = bool ? false : true
    }
    
    
}
