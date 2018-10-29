//
//  NetworkCall.swift
//  StarWars
//
//  Created by Mitchell Socia on 10/29/18.
//  Copyright © 2018 Mitchell Socia. All rights reserved.
//

import Foundation

class NetworkCall {
    
//    var placesApi = PlacesApi()
    
    
    func empireURL() -> URL {
        
        //only returns one result
        let urlString = "https://swapi.co/api/films/2/"
        
        let url = URL(string: urlString)
        return url!
}


func performStoreRequest(with url: URL) -> Data? {
    do {
        print("Success")
        return try Data(contentsOf: url)
    } catch {
        print("Error \(error)")
        return nil
    }
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
