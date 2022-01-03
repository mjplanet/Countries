//
//  LoadEmptyState.swift
//  Countries
//
//  Created by Mobin Jahantark on 1/3/22.
//

import UIKit

protocol LoadEmptyState: AnyObject {
    func startLoading()
    func stopLoading()
    func showEmptyState(_ state: EmptyStateData)
    func hideEmptyState()
}

extension LoadEmptyState where Self: UIViewController {
    func startLoading() { view.loadState.startAnimating() }
    func stopLoading() { view.loadState.stopAnimating() }
    func showEmptyState(_ state: EmptyStateData) { view.emptyState.show(type: state) }
    func hideEmptyState() { view.emptyState.hide() }
}
