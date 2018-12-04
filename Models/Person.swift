//
//  Person.swift
//  StarWars
//
//  Created by Mitchell Socia on 10/30/18.
//  Copyright © 2018 Mitchell Socia. All rights reserved.
//

import Foundation

struct Person: Codable {
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [URL]
    let vehicles: [String]
    let starships: [URL]
    let created: String
    let edited: String
    let url: String
}
