//
//  MainViewModel.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 2/29/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import Foundation

class MainViewModel {
    
    func fetchCharactersData(completion: @escaping ([CharacterItem]?) -> Void) {
        
        NetworkService.getJSON(urlString: Links.characterList) { (charactersData: CharactersData?) in
            print("Data Loaded!")
            
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
