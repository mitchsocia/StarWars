//
//  MainViewTableViewController.swift
//  StarWars
//
//  Created by Mitchell Socia on 10/29/18.
//  Copyright © 2018 Mitchell Socia. All rights reserved.
//

import UIKit



class MainViewTableViewController: UITableViewController {
    
    var empire: Empire?
    var networkCall = NetworkCall()
    var characters: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkCall.fetchPeopleInEmpireStrikesBack() { people in }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        cell.textLabel?.text = "\(characters[indexPath.row])"
        return cell
    }
    
}
