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
        
    var countries: [Country] {
        return CountryManager.shared.getCountries()
    }
    
    private var selectedCountries: [Country] = CountryManager.shared.selectedCountries()
}

extension CountriesListPresenter: CountriesListPresenterInterface {
    
    func viewDidLoad() {
        view.initialSetup()
        
        fetchData { [weak self] result in
            switch result {
            case .success(let countries):
                self?.view.applySnapShot(countries: countries)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData(didFinish: ((Result<[Country], Error>) -> Void)?) {
        let url = URL(string: "https://restcountries.com/v3.1/all")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedCountries = try decoder.decode([Country].self, from: data)
                CountryManager.shared.cacheCountries(decodedCountries)
                didFinish?(.success(decodedCountries))
                
            } catch {
                didFinish?(.failure(error))
            }
            
            print("Data size", data.count)
        }
        task.resume()
    }
    
    
    func searchBarTextDidChange(_ text: String) {
//        countries = origianlCountries
        if text.isEmpty == false {
            self.view.applySnapShot(countries: CountryManager.shared.search(with: text))
//            countries = countries.filter({ $0.name.common.lowercased().contains(text.lowercased())})
        }
    }
    
    func didSelectItem(indexPath: IndexPath) {
        if selectedCountries.contains(countries[indexPath.row]) {
            selectedCountries.removeAll(where: {$0.name == countries[indexPath.row].name})
            view.removeCheckMark(at: indexPath)
        } else {
            selectedCountries.append(countries[indexPath.row])
            view.addCheckMark(at: indexPath)
        }
        CountryManager.shared.updateSelectedCountries(selectedCountries)
    }

    func doneDidPress() {
        onDismiss?()
        view.dismiss()
    }
    
    func refreshDidOccur() {
        fetchData { [weak self] result in
            switch result {
            case .success(let countries):
                self?.view.applySnapShot(countries: countries)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
