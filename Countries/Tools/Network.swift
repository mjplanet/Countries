//
//  Network.swift
//  Countries
//
//  Created by Mobin Jahantark on 1/3/22.
//

import Foundation

protocol NetworkInterface {
    func get<T: Decodable>(url: NetworkManager.AppURL, type: T.Type, didFinish: ((Result<T, Error>) -> Void)?)
}

class NetworkManager: NetworkInterface {
    
    enum AppURL: String {
        case all = "https://restcountries.com/v3.1/all"
        
        var toURL: URL? {
            return URL(string: rawValue)
        }
    }
    
    func get<T: Decodable>(url: AppURL, type: T.Type, didFinish: ((Result<T, Error>) -> Void)?) {
        guard let url = url.toURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedValue = try decoder.decode(T.self, from: data)
                

//                CountryManager.shared.saveDataSource(decodedCountries)
                didFinish?(.success(decodedValue))
                
            } catch {
                didFinish?(.failure(error))
            }
        }

        task.resume()
    }
    
}


