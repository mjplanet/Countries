//
//  EmptyStateData.swift
//  Countries
//
//  Created by Mobin Jahantark on 1/3/22.
//

import UIKit


enum EmptyStateData: EmptyStateType {
    
    case noSelectedCountry
    
    var title: String? {
        switch self {
        case .noSelectedCountry: return "No country has been selected yet"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .noSelectedCountry: return nil
        }
    }
    
    var image: UIImage? {
        switch self {
        case .noSelectedCountry: return UIImage(named: "Illustrations_noRecentAddress")
        }
    }
    
    var buttonTitle: String? {
        switch self {
        default: return nil
        }
    }

    
}

