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
        
        getJSON(urlString: Links.characterList) { (charactersData: CharactersData?) in
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
    
    
    
    func getJSON<T: Decodable>(urlString: String, completionHandler: @escaping (T?) -> Void) {
        
        let urlComp = NSURLComponents(string: urlString)!
        urlComp.queryItems = [
            URLQueryItem(name: "apikey", value: "918ef72712aa207257a1e6a8e2cba193"),
            URLQueryItem(name: "ts", value: "1"),
            URLQueryItem(name: "hash", value: "1a4a6b435cfabd30aeabefb204929542")
        ]
        
        let request = URLRequest(url: urlComp.url!)
        URLSession.shared.dataTask(with: request) { (data, responce, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completionHandler(nil)
            }
            
            guard let data = data else {
                completionHandler(nil)
                return
            }
            
//            let dataAsString = String(data: data, encoding: .utf8)!
//            print("________DATA___________")
//            print(dataAsString)
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completionHandler(decodedData)
            } catch let jsonErr {
                print("Error serializing json: ", jsonErr)
                completionHandler(nil)
            }

        }.resume()
        
    }
    
}
