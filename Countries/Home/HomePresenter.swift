//
//  HomePresenter.swift
//  Countries
//
//  Created Mobin Jahantark on 1/1/22.
//  Copyright © 2022 mobinjt. All rights reserved.
//

import Foundation
import UIKit

protocol HomePresenterInterface {
    func viewDidLoad()
    func selectCountriesButtonDidTap()
    var selectedCountries: [Country] { get }
}

class HomePresenter: NSObject {
    
    weak var view: HomeViewInterface!
    
    private(set) var selectedCountries = [Country]() {
         didSet {
             DispatchQueue.main.async {
                 self.view.applySnapShot(countries: self.selectedCountries)
             }
         }
     }
    
    private func getSelectedCountries() {
        selectedCountries = CountryManager.shared.getSelectedCountries()
        if selectedCountries.isEmpty {
            view.showEmptyState(.noSelectedCountry)
        } else {
            view.hideEmptyState()
        }
    }

}

extension HomePresenter: HomePresenterInterface {
    
    func viewDidLoad() {
        view.initialSetup()
        getSelectedCountries()
    }
    
    func selectCountriesButtonDidTap() {
        let vc = CountriesListModule().build {
            self.getSelectedCountries()
        }
        let nav = UINavigationController(rootViewController: vc)
        view.present(nav)
    }
    
}
