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
    var selectURI: String = ""
        
    func characterSelected(name: String, uri: URL) {
        selectURI = uri.absoluteString
        
        NetworkService.getJSON(urlString: selectURI) { (detailsData: ComicsDetailsData?) in
            
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
    
    func loadMoreData() {
        NetworkService.getJSON(urlString: selectURI, offset: self.comicsDetails.value?.count ?? 0, limit: 20) { (detailsData: ComicsDetailsData?) in
            
            DispatchQueue.main.async {
                guard let statusCode = detailsData?.code else {
                    return
                }
                
                if statusCode != 200 {
                    print("Status Error Code: \(statusCode)")
                }
                
                if let data = detailsData?.data {
                    if data.total > self.comicsDetails.value!.count {
                        self.comicsDetails.value! += data.results
                        print("Comics More Data Loaded: \(self.comicsDetails.value!.count)")
                    }
                }
            }
        }
    }
    
    
    
    func characterSelected(id: Int) {
        //print(id)
    }

    
}
