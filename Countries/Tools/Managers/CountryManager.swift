//
//  CountryManager.swift
//  Countries
//
//  Created by Mobin Jahantark on 1/2/22.
//

import Foundation

class CountryManager {
    
    static var shared = CountryManager()
    
    lazy private var dataSource = [Country]()
    lazy private var selectedCountriesVal = [Country]()
    
    
    func cacheCountries(_ countries: [Country]) {
        self.dataSource = countries
    }
    
    func updateSelectedCountries(_ countries: [Country]) {
        self.selectedCountriesVal = countries
    }
    
    func search(with text: String) -> [Country] {
        return dataSource.filter({ $0.name.common.lowercased() == text.lowercased() })
    }
    
    func getCountries() -> [Country] {
        return dataSource
    }
    
    func selectedCountries() -> [Country] {
        self.selectedCountriesVal
    }
    
}
