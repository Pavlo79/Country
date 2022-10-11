//
//  Model.swift
//  Rest API
//
//  Created by Niso on 4/29/20.
//  Copyright © 2020 Niso. All rights reserved.
//

import Foundation

struct CountriesData: Codable {
    let next: String?
    var countries: [Country]
}
 
struct Country: Codable {
    let name: String
    let continent: String
    let capital: String
    let population: Int
    let descriptionSmall: String
    let description: String
    let image: String
    let country_info: Country_info
    
    private enum CodingKeys : String, CodingKey {
            case name
            case continent
            case capital
            case population
            case descriptionSmall = "description_small"
            case description
            case image
            case country_info// = "country_info"
        }
}
struct Country_info: Codable {
    let images: [String]
    let flag: String
}
