//
//  HomeModule.swift
//  Countries
//
//  Created Mobin Jahantark on 1/1/22.
//  Copyright © 2022 mobinjt. All rights reserved.
//

import UIKit

struct HomeModule {
    
    func build() -> UIViewController {
        let view = UIStoryboard.instantiate(.home) as! HomeView
        let presenter = HomePresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
