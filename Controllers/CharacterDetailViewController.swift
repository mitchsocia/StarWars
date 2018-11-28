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
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterBirthYearLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterHomeWorldLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterNameLabel.text = person?.name
        characterBirthYearLabel.text = person?.birth_year
        characterGenderLabel.text = person?.gender
        characterHomeWorldLabel.text = person?.homeworld
        
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
    
    
}
