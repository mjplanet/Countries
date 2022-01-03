//
//  CountriesListPresenter.swift
//  Countries
//
//  Created Mobin Jahantark on 1/1/22.
//  Copyright © 2022 mobinjt. All rights reserved.
//

import Foundation

protocol CountriesListPresenterInterface {
    func viewDidLoad()
    var countries: [Country] { get }
    func searchBarTextDidChange(_ to: String)
    func didSelectItem(indexPath: IndexPath)
    func doneDidPress()
    func refreshDidOccur()
}

class CountriesListPresenter: NSObject {
    
    weak var view: CountriesListViewInterface!
    
    var onDismiss: (() -> Void)?
    
    var searchDataSource: [Country] = []

    var countries: [Country] {
        return CountryManager.shared.getCountries()
    }
    
    private var selectedCountries: [Country] = CountryManager.shared.getSelectedCountries()
    
    private var network: NetworkInterface

    init(network: NetworkInterface) {
        self.network = network
    }
    
}

extension CountriesListPresenter: CountriesListPresenterInterface {
    
    func viewDidLoad() {
        view.initialSetup()
        getCountries()
    }
    
    private func getCountries(fromRefresh: Bool = false) {
        if !fromRefresh { view.startLoading() }
        network.get(url: .all, type: [Country].self) { [weak self] result in
            DispatchQueue.main.async {
                self?.view.stopLoading()
            }
            switch result {
            case .success(let countries):
                CountryManager.shared.saveDataSource(countries)
                self?.view.applySnapShot(countries: countries)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func searchBarTextDidChange(_ text: String) {
        
        if text.isEmpty {
            searchDataSource.removeAll()
            self.view.applySnapShot(countries: CountryManager.shared.getCountries())
        } else {
            searchDataSource = CountryManager.shared.search(where: {$0.name.common.lowercased().contains(text.lowercased())})
            self.view.applySnapShot(countries: searchDataSource)
            
        }
    }
    
    func didSelectItem(indexPath: IndexPath) {
        
        var item: Country?
        
        if searchDataSource.isEmpty {
            item = countries[indexPath.row]
        } else {
            item = searchDataSource[indexPath.row]
        }
        
        if selectedCountries.contains(item!) {
            selectedCountries.removeAll(where: {$0.name == item!.name})
            view.removeCheckMark(at: indexPath)
        } else {
            selectedCountries.append(item!)
            view.addCheckMark(at: indexPath)
        }

        CountryManager.shared.saveSelectedCountries(selectedCountries)
    }
    
    func doneDidPress() {
        onDismiss?()
        view.dismiss()
    }
    
    func refreshDidOccur() {
        getCountries(fromRefresh: true)
    }
}
