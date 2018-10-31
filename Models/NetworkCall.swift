//
//  NetworkCall.swift
//  StarWars
//
//  Created by Mitchell Socia on 10/29/18.
//  Copyright © 2018 Mitchell Socia. All rights reserved.
//

import Foundation

var dataTask: URLSessionDataTask?

class NetworkCall {
    
    //    let urls: [URLRequest]
    
    var characterURLs = [URL]()
    var characters = [Person]()
    
    func empireURL() -> URL {
 
        let urlString = "https://swapi.co/api/films/2/"
        
        let url = URL(string: urlString)
        return url!
    }
    
    func fetchPeopleInEmpireStrikesBack(_ completion: @escaping ([Person]) -> ()) {
        let url = empireURL()
        let defaultSession = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let dataTask = defaultSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            //parse array of URLs
            guard let data = data else {
                completion([])
                return
            }
            guard let movieInfo = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]) else {
                completion([])
                return
            }
            let urlStrings = (movieInfo?["characters"] as? [String]) ?? []
            for urlString in urlStrings {
                if let url = URL(string: urlString) {
                    self.characterURLs.append(url)
                }
            }
            self.getPeople(completion: completion)
            
        }
        dataTask.resume()
        
    }
    
    func getPeople(completion: ([Person]) -> ()) {
        
        // get characters {
    //   parse characters
    //   call completion
    // }
    }
    
    func parse(data: Data) -> Empire? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Empire.self, from: data)
            
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
}
