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
    var speciesArray: [Species] = []
    var starships: Starship?
    var starshipsArray: [Starship] = []
    var starshipNames: [String] = []
    
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterBirthYearLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterHomeWorldLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var starShipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let character = person {
            let homeworldURL = getHomeworldURL(from: character.homeworld)
            if let url = homeworldURL {
                getHomeworldData(from: url)
                
            }
            
        }
        
        getSpecies()
        getStarships()
        
        characterNameLabel.text = person?.name
        characterBirthYearLabel.text = person?.birth_year
        characterGenderLabel.text = person?.gender
        characterHomeWorldLabel.text = homeWorld?.name
        speciesLabel.text = species?.name
        let starshipsString = starshipNames.joined(separator: ", ")
        print("starship names are: \(starshipsString)")
        starShipLabel.text = starshipsString
        
    }
    
    func getStarshipNames() {
        for ship in starshipsArray {
            starshipNames.append(ship.name)
        }
    }
    
    func getSpecies() {
        guard let speciesURL = getSpeciesURL() else { return }
        for url in speciesURL {
            getSpeciesData(from: url)
        }
        
    }
    
    //4 - Loop through URLs and return data
    func getStarships() {
        guard let starshipURL = getStarshipURL() else { return }
        for url in starshipURL {
            getStarshipData(from: url)
        }
    }
    
    
    func updateLabels() {
        characterHomeWorldLabel.text = homeWorld?.name
        speciesLabel.text = species?.name
        getStarshipNames()
        let starshipsString = starshipNames.joined(separator: ", ")
        starShipLabel.text = starshipsString
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
    
    //    //Species Call - 1
    func getSpeciesURL() -> [URL]? {
        return person?.species
    }
    
    //Species Call - 2
    func getSpeciesData(from url: URL) /*-> Species*/ {
        let defaultSession = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let dataTask = defaultSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            
            guard let data = data else {
                return
            }
            
            self.species = self.parseSpecies(data: data)
            self.speciesArray.append(self.species!)
            
            DispatchQueue.main.async {
                self.updateLabels()
            //Moved append species array to line 138 outside of main queue
            }
        }
        dataTask.resume()
        
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
    
    //1 - getting URL from Person object
    func getStarshipURL() -> [URL]? {
        return person?.starships
    }
    
    //2
    func parseStarships(data: Data) -> Starship? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Starship.self, from: data)
            
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
    
    //3 - sesh ( #4 call getStarships() ^ )
    func getStarshipData(from url: URL) {
        let defaultSession = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let dataTask = defaultSession.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                return
            }
            self.starships = self.parseStarships(data: data)
            
            DispatchQueue.main.async {
                self.updateLabels()
            }
            
            self.starshipsArray.append(self.starships!)
        }
        dataTask.resume()
    }
    

    
    
}

