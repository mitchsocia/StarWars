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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterNameLabel.text = person?.name
        characterBirthYearLabel.text = person?.birth_year
        characterGenderLabel.text = person?.gender
        characterHomeWorldLabel.text = person?.homeworld
        
    }

    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterBirthYearLabel: UILabel!
    @IBOutlet weak var characterGenderLabel: UILabel!
    @IBOutlet weak var characterHomeWorldLabel: UILabel!
    
    
}
