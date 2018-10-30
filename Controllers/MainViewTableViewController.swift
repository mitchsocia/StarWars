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
<<<<<<< HEAD:Controllers/MainViewTableViewController.swift
    var characters = [Empire]()
=======
    var characters: [Empire] = []
    
>>>>>>> populate-initial-character-data:StarWars/MainViewTableViewController.swift
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(characters)
        empire = networkCall.parse(data: networkCall.performStoreRequest(with: networkCall.empireURL())!)
        print(empire?.characters)
        //        print("\(empire?.characters)")
        
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
