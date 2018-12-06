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
    var films: Film?
    var filmsArray: [Film] = []
    var filmNames: [String] = []
    
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterBirthYearLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterHomeWorldLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var starShipLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var filmsLabel: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        
        let homeworldURL = getHomeworldURL()
        if let url = homeworldURL {
            getHomeworldData(from: url)
        }
        
      
        
        getSpecies()
        getStarships()
        getFilms()
        
        characterNameLabel.text = person?.name
        characterBirthYearLabel.text = person?.birth_year
        characterGenderLabel.text = person?.gender
        characterHomeWorldLabel.text = homeWorld?.name
        massLabel.text = "\(person?.mass ?? "Unknown") kg"
        speciesLabel.text = species?.name
        
        starShipLabel.text = "\(String.self)"
      
        filmsLabel.text = "\(String.self)"
        
    }
    
    func getStarshipNames() {
        for ship in starshipsArray {
            starshipNames.append(ship.name)
        }
    }
    
    func getFilmNames() {
        for film in filmsArray {
            filmNames.append(film.title)
        }
    }
    
    func getSpecies() {
        guard let speciesURL = getSpeciesURL() else { return }
        for url in speciesURL {
            getSpeciesData(from: url)
        }
        
    }
    
    func getFilms() {
        guard let filmsURLS = getFilmURLS() else { return }
        for url in filmsURLS {
            getFilmData(from: url)
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
        
        getFilmNames()
        let filmNamesString = filmNames.joined(separator: ", ")
        filmsLabel.text = filmNamesString
        
    }
    
    func getHomeworldURL() -> URL? {
        return person?.homeworld
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
    
    func getFilmURLS() -> [URL]? {
        return person?.films
    }
    
    func getFilmData(from url: URL) {
        let defaultSession = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let dataTask = defaultSession.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                return
            }
            self.films = self.parseFilms(data: data)
            
            DispatchQueue.main.async {
                self.updateLabels()
            }
            
            self.filmsArray.append(self.films!)
        }
        dataTask.resume()
    }
    
    func parseFilms(data: Data) -> Film? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Film.self, from: data)
            
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
    
}

