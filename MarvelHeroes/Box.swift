//
//  Box.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 3/2/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import UIKit

class Box<T> {
    typealias Listener = (T) -> Void
    var listerner: Listener?
    
    var value: T {
        didSet {
            listerner?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listerner: Listener?) {
        self.listerner = listerner
        listerner?(value)
    }
}
