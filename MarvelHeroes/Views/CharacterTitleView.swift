//
//  CharacterTitleView.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 3/2/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import UIKit

class CharacterTitleView: UIView {
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textBlack
        label.text = "Hero name here"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        self.addSubview(title)
        NSLayoutConstraint(item: title, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: title, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }
    
}
