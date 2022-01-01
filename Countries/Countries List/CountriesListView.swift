//
//  CountriesListView.swift
//  Countries
//
//  Created Mobin Jahantark on 1/1/22.
//  Copyright © 2022 mobinjt. All rights reserved.
//

import UIKit

protocol CountriesListViewInterface: class {
    func initialSetup()
}

class CountriesListView: UICollectionViewController {
    
    var presenter: CountriesListPresenterInterface!
    
    
    // MARK: - Properties
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        presenter.getData()
    }
    
    
    // MARK: - Setups
    
    
    
    // MARK: - Theme
    
    
    
    // MARK: - Actions
    
    
}



extension CountriesListView: CountriesListViewInterface {
    
    func initialSetup() {
        
    }
    
}


