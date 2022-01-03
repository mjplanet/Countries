//
//  CountryManager.swift
//  Countries
//
//  Created by Mobin Jahantark on 1/2/22.
//

import Foundation



protocol CacheBehavior {
    associatedtype T
    var dataSource: [T] { get }
    func saveDataSource(_ items: [T])
    func saveSelectedCountries(_ items: [T])
    func getCountries() -> [T]
    func getSelectedCountries() -> [T]
    func search(where isIncluded: (T) -> Bool) -> [T]
}

class CountryManager: CacheBehavior {
    
    static var shared = CountryManager()
    
    lazy var dataSource: [Country] = []
    lazy var selectedCountries: [Country] = []
    
    func saveDataSource(_ items: [Country]) {
        self.dataSource = items
    }
    
    func saveSelectedCountries(_ items: [Country]) {
        self.selectedCountries = items
    }
    
    func getSelectedCountries() -> [Country] {
        return selectedCountries
    }
    
    func getCountries() -> [Country] {
        return dataSource
    }
    
    func search(where isIncluded: (Country) -> Bool) -> [Country] {
        dataSource.filter(isIncluded)
    }
    
}
