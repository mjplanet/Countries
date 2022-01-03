//
//  CountriesListModule.swift
//  Countries
//
//  Created Mobin Jahantark on 1/1/22.
//  Copyright © 2022 mobinjt. All rights reserved.
//

import UIKit

struct CountriesListModule {
    
    func build(onDismiss: (() -> Void)?) -> UIViewController {
        let view = UIStoryboard.instantiate(.countriesList) as! CountriesListView
        let presenter = CountriesListPresenter(network: NetworkManager())
        view.presenter = presenter
        presenter.view = view
        presenter.onDismiss = onDismiss
        return view
    }
}
