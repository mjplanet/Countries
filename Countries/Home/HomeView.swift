//
//  HomeView.swift
//  Countries
//
//  Created Mobin Jahantark on 1/1/22.
//  Copyright © 2022 mobinjt. All rights reserved.
//

import UIKit

protocol HomeViewInterface: NavigationProtocol {
    func initialSetup()
    func applySnapShot(animatingDifferences: Bool)
}

class HomeView: UICollectionViewController {
    
    var presenter: HomePresenterInterface!
    
    private static let cellReuseID = "cell"

    
    // MARK: - Properties
    private enum Section: CaseIterable {
        case main
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    
    // MARK: - Setups
    private func addNavigationBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select Countries", style: .done, target: self, action: #selector(selectCountriesDidTap))
    }
    
    private func createLayout() {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.backgroundColor = UIColor(named: "BackgroundColor")
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Country> = {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Country> { cell, _, country in
            var content = cell.defaultContentConfiguration()
            content.text = country.name.common
            content.secondaryText = country.flag
            cell.contentConfiguration = content
            cell.accessories = [.checkmark()]
        }

        return UICollectionViewDiffableDataSource<Section, Country>(collectionView: collectionView) { (collectionView, indexPath, country) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: country)
        }
    }()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    
    // MARK: - Actions
    
    @objc private func selectCountriesDidTap() {
        presenter.selectCountriesButtonDidTap()
    }

}

extension HomeView: HomeViewInterface {
    
    func initialSetup() {
        createLayout()
        addNavigationBarButton()
    }
    
    func applySnapShot(animatingDifferences: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Country>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(presenter.selectedCountries)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

}
