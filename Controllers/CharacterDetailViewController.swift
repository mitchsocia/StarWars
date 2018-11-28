//
//  CharacterDetailViewController.swift
//  StarWars
//
//  Created by Mitchell Socia on 10/30/18.
//  Copyright © 2018 Mitchell Socia. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var person: Person?
    var homeWorld: Homeworld?
    var species: Species?
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterBirthYearLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterHomeWorldLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let character = person {
            let homeworldURL = getHomeworldURL(from: character.homeworld)
            if let url = homeworldURL {
                getHomeworldData(from: url)
         
        //Species Call - 4
            let speciesURL = getSpeciesURL(from: character.species)
                print("SPECIES URL IS: \(speciesURL)")
                if let url = speciesURL {
                    getSpeciesData(from: url)
                }
            }
        }
        characterNameLabel.text = person?.name
        characterBirthYearLabel.text = person?.birth_year
        characterGenderLabel.text = person?.gender
        characterHomeWorldLabel.text = homeWorld?.name
    }
    
    func updateLabels() {
        characterHomeWorldLabel.text = homeWorld?.name
    }
    
    func getHomeworldURL(from homeworldString: String) -> URL? {
        guard let url = URL(string: homeworldString) else { return nil }
        
        return url
    }
    
    func getHomeworldData(from url: URL) {
        let defaultSession = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let dataTask = defaultSession.dataTask(with: urlRequest) { (data, urlResponse, error) in

            guard let data = data else {
                return
            }

            self.homeWorld = self.parse(data: data)

            DispatchQueue.main.async {
                self.updateLabels()
            }
        }
        dataTask.resume()
    }
    
    func parse(data: Data) -> Homeworld? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Homeworld.self, from: data)
            
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
    
    //Species Call - 1
    func getSpeciesURL(from speciesArrayURL: String) -> URL? {
        guard let url = URL(string: speciesArrayURL) else { return nil }
        
        return url
    }
    
    //Species Call - 2
    func getSpeciesData(from url: URL) -> Species {
        let defaultSession = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let dataTask = defaultSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            
            guard let data = data else {
                return
            }
            
            self.species = self.parseSpecies(data: data)
            
//            DispatchQueue.main.async {
//                self.updateLabels()
//            }
        }
        dataTask.resume()
        
        return species!
    }
    
    
    //Species Call - 3
    func parseSpecies(data: Data) -> Species? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Species.self, from: data)
            
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
    
    
}

