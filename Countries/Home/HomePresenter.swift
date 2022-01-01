//
//  HomePresenter.swift
//  Countries
//
//  Created Mobin Jahantark on 1/1/22.
//  Copyright © 2022 mobinjt. All rights reserved.
//

import Foundation

protocol HomePresenterInterface {
    func viewDidLoad()
    func selectCountriesDidTap()
}

class HomePresenter: NSObject {
    
    weak var view: HomeViewInterface!
    
}

extension HomePresenter: HomePresenterInterface {
    
    func viewDidLoad() {
        view.initialSetup()
    }
    
    func selectCountriesDidTap() {
        
    }
    
}
