//
//  NavigationProtocol.swift
//  Countries
//
//  Created by Mobin Jahantark on 1/1/22.
//

import UIKit

protocol NavigationProtocol: AnyObject {
    func push(_ vc: UIViewController)
    func present(_ vc: UIViewController)
    func dismiss()
    func dismiss(completion: (() -> Void)?)
}

extension NavigationProtocol where Self: UIViewController {
    
    func push(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func present(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismiss(completion: (() -> Void)?) {
        self.dismiss(completion: completion)
    }
    
}
