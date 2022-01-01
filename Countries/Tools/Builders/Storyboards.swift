//
//  Storyboards.swift
//  Countries
//
//  Created by Mobin Jahantark on 1/1/22.
//

import UIKit

extension UIStoryboard {
    static func instantiate(_ name: Storyboard) -> UIViewController {
        let storyboard = UIStoryboard(name: name.sbName, bundle: nil)
        if let identifier = name.vcIdentifier {
            return storyboard.instantiateViewController(withIdentifier: identifier)
        } else {
            guard let controller = storyboard.instantiateInitialViewController() else {
                fatalError("Storyboard with name: \(name.sbName) has no initial view controller")
            }
            return controller
        }
    }
}

enum Storyboard {
    case home
    case countriesList
    
    var sbName: String {
        switch self {
        case .home: return "Home"
        case .countriesList: return "CountriesList"
        }
    }
    
    var vcIdentifier: String? {
        switch self {
        default: return nil
        }
    }
}

