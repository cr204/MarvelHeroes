//
//  CharacterListViewModel.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 3/3/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import Foundation

class CharacterListViewModel {
    
    func fetchCharactersData(offset: Int, limit: Int, completion: @escaping ([CharacterItem]?) -> Void) {
        
        NetworkService.getJSON(urlString: Links.characterList, offset: offset, limit: limit) { (charactersData: CharactersData?) in
            
            guard let statusCode = charactersData?.code else {
                return
            }
            
            if statusCode != 200 {
                print("Status Error Code: \(statusCode)")
            }
            
            if let data = charactersData?.data {
                completion(data.results)
            }
        }
    }
    
    
}
