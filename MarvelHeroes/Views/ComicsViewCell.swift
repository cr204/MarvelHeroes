//
//  ComicsViewCell.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 3/1/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import UIKit

class ComicsViewCell: UITableViewCell {
    
//    var comicsItem: ComicsItem? {
//        didSet {
//            self.titleLabel.text = self.comicsItem?.name ?? ""
//            self.descLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
//            self.initViews()
//        }
//    }
    
    var comicsDetailsItem: ComicsDetailsItem? {
        didSet {
            self.titleLabel.text = self.comicsDetailsItem?.title ?? ""
            self.descLabel.text = self.comicsDetailsItem?.description ?? "No description"
            self.comicsImage.loadImageUsingURLString(urlString: self.comicsDetailsItem?.imageURL ?? "", fade: true, centerFit: true,cornerRadius: 10)
            self.initViews()
        }
    }
    
    let comicsImage: CustomImageView = {
        let imgView = CustomImageView()
        imgView.layer.cornerRadius = 10
        imgView.backgroundColor = Colors.lightGray
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.textBlack
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textAlignment = .justified
        label.textColor = Colors.textGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func initViews() {
        self.selectionStyle = .none
        
        self.addSubview(comicsImage)
        comicsImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        comicsImage.heightAnchor.constraint(equalToConstant: 160).isActive = true
        NSLayoutConstraint(item: comicsImage, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: comicsImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        self.addSubview(titleLabel)
        NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: comicsImage, attribute: .right, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: comicsImage, attribute: .top, multiplier: 1, constant: 0).isActive = true

        self.addSubview(descLabel)
        NSLayoutConstraint(item: descLabel, attribute: .left, relatedBy: .equal, toItem: comicsImage, attribute: .right, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: descLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: descLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        
    }
    
    
    

}
