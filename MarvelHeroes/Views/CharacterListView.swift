//
//  CharacterListView.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 2/29/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import UIKit

protocol CharacterListViewDelegate: class {
    func characterSelected(id: Int)
    func characterSelected(uri: URL)
}

class CharacterListView: UIView, UICollectionViewDelegate {
    
    var characters: [CharacterItem] = []
    private var prevSelected: CharacterCell?
    weak var delegate: CharacterListViewDelegate?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.showsHorizontalScrollIndicator = true
        cv.isScrollEnabled = true
        return cv
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "CharacterCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    func initViews() {
        self.addSubview(collectionView)
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    
        if self.prevSelected == nil {
            self.perform(#selector(performAction), with: nil, afterDelay: 0.3)
        }
    }
    
    @objc private func performAction() {
        let cell  = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! CharacterCell
        cell.isSelected(true)
        prevSelected = cell
        delegate?.characterSelected(id: 0)
        delegate?.characterSelected(uri: characters[0].comics.collectionURI)
    }
    
    
    

}

extension CharacterListView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        cell.image.loadImageUsingURLString(urlString: characters[indexPath.row].imageURL, fade: true, cornerRadius: 8)
        cell.name.text = characters[indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell  = collectionView.cellForItem(at: indexPath) as! CharacterCell
        if prevSelected === cell {
            return
        } else {
            prevSelected?.isSelected(false)
        }
        cell.isSelected(true)
        prevSelected = cell
        delegate?.characterSelected(uri: characters[indexPath.item].comics.collectionURI)
    }
    
    // line spacing for vertical
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
   
    // line spacing for horizontal
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}

