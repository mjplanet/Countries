//
//  Country.swift
//  Countries
//
//  Created by Mobin Jahantark on 1/1/22.
//

import Foundation

struct Country: Codable, Hashable, Equatable {
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name && lhs.flag == rhs.flag
    }
    
    var name: Name
    var flag: String?
    
    var isSelected: Bool {
        return CountryManager.shared.getSelectedCountries().contains(self)
    }
    
    enum CodingKeys: String, CodingKey {
        case name, flag
    }
    
    struct Name: Codable, Hashable {
        var common: String
    }
    
}
