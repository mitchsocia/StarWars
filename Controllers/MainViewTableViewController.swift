//
//  MainViewTableViewController.swift
//  StarWars
//
//  Created by Mitchell Socia on 10/29/18.
//  Copyright © 2018 Mitchell Socia. All rights reserved.
//

import UIKit



class MainViewTableViewController: UITableViewController {

    var characterURLs = [URL]()
    var characters: [Person] = []
//    var homeWorld: Homeworld?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characters = fetchPeopleInEmpireStrikesBack()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "CharacterDetail" {
            if let destination = segue.destination as?  CharacterDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let personAtSelectedRow = characters[indexPath.row]
                    destination.person = personAtSelectedRow
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        cell.textLabel?.text = "\(characters[indexPath.row].name)"
        return cell
    }
    
}

// Network Manager

extension MainViewTableViewController {
    
    func empireURL() -> URL {
        
        let urlString = "https://swapi.co/api/films/2/"
        
        let url = URL(string: urlString)
        return url!
    }
    
    func fetchPeopleInEmpireStrikesBack() -> [Person] {
        let url = empireURL()
        let defaultSession = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let dataTask = defaultSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            //parse array of URLs
            guard let data = data else {
                return
            }
            
            // converts data to JSON object (String: Any key-value pairs)
            guard let movieInfo = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]) else {
                return
            }
            let urlStrings = (movieInfo?["characters"] as? [String]) ?? []
            for urlString in urlStrings {
                if let url = URL(string: urlString) {
                    self.characterURLs.append(url)
                }
            }
            self.getCharacters(from: self.characterURLs)
            
        }
        dataTask.resume()
        
        return characters
        
    }
    
    func getCharacters(from urlArray: [URL]) {
        for url in urlArray {
            getPersonData(from: url)
        }
    }
    
    func getPersonData(from url: URL) {
        let defaultSession = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let dataTask = defaultSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            
            guard let data = data else {
                return
            }
            
            let currentPerson = self.parse(data: data)
            self.characters.append(currentPerson!)
            if self.characters.count == self.characterURLs.count {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        dataTask.resume()
    }
    
    func parse(data: Data) -> Person? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Person.self, from: data)
            
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
    
}
