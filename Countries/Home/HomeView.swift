//
//  HomeView.swift
//  Countries
//
//  Created Mobin Jahantark on 1/1/22.
//  Copyright © 2022 mobinjt. All rights reserved.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func initialSetup()
}

class HomeView: UIViewController {
    
    var presenter: HomePresenterInterface!
    
    
    // MARK: - Properties
    @IBOutlet weak var selectCountries: UIButton!
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        presenter.viewDidLoad()
        
    }
    
    
    // MARK: - Setups
    
    
    
    // MARK: - Theme
    
    
    
    // MARK: - Actions
    
    @IBAction func selectCountriesDidTap(_ sender: Any) {
        presenter.selectCountriesDidTap()
    }
    
}



extension HomeView: HomeViewInterface {
    
    func initialSetup() {
        
    }
    
}


