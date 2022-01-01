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
    func getData()
}

class CountriesListPresenter: NSObject {
    
    weak var view: CountriesListViewInterface!
    
}

extension CountriesListPresenter: CountriesListPresenterInterface {
    
    func viewDidLoad() {
        view.initialSetup()
    }
    
    func getData() {
            let url = URL(string: "https://restcountries.com/v3.1/all")!

            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                print("Data size", data.count)
//                print("The response is : ",String(data: data, encoding: .utf8)!)
                //print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) as Any)
            }
            task.resume()
        }
    
}
