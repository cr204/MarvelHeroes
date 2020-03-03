//
//  MainViewModel.swift
//  MarvelHeroes
//
//  Created by Jasur Rajabov on 2/29/20.
//  Copyright © 2020 Jasur Rajabov. All rights reserved.
//

import Foundation

class MainViewModel: CharacterListViewDelegate {
    
    var comicsDetails: Box<[ComicsDetailsItem]?> = Box(nil)
    var selectCharacterName: String = ""
        
    func characterSelected(name: String, uri: URL) {
        
        NetworkService.getJSON(urlString: uri.absoluteString) { (detailsData: ComicsDetailsData?) in
            
            guard let statusCode = detailsData?.code else {
                return
            }
            
            if statusCode != 200 {
                print("Status Error Code: \(statusCode)")
            }
            
            if let data = detailsData?.data {
                print("Comics Data Loaded: \(data.count)")
                self.selectCharacterName = name
                self.comicsDetails.value = data.results
            }
        }
        
    }
    
    
    func characterSelected(id: Int) {
        //print(id)
    }

    
}
