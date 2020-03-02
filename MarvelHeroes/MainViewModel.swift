//
//  MainViewModel.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 2/29/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import Foundation

class MainViewModel {
    
    var comicsDetails: Box<[ComicsDetailsItem]?> = Box(nil)
    var lastSelectId: Int = 0
    
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

extension MainViewModel: CharacterListViewDelegate {
        
    func characterSelected(id: Int, uri: URL) {
//        print("characterSelectedURI: \(uri)")
        
        NetworkService.getJSON(urlString: uri.absoluteString) { (detailsData: ComicsDetailsData?) in
            
            guard let statusCode = detailsData?.code else {
                return
            }
            
            if statusCode != 200 {
                print("Status Error Code: \(statusCode)")
            }
            
            if let data = detailsData?.data {
                print("Details Data Loaded: \(data.count)")
                self.lastSelectId = id
                self.comicsDetails.value = data.results
            }
        }
        
    }
    
    
    func characterSelected(id: Int) {
        //print(id)
    }

    
}
