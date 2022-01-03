//
//  CountriesListView.swift
//  Countries
//
//  Created Mobin Jahantark on 1/1/22.
//  Copyright © 2022 mobinjt. All rights reserved.
//

import UIKit

protocol CountriesListViewInterface: NavigationProtocol {
    func initialSetup()
    func applySnapShot(countries: [Country])
    func addCheckMark(at indexPath: IndexPath)
    func removeCheckMark(at indexPath: IndexPath)
}

class CountriesListView: UICollectionViewController {
    
    var presenter: CountriesListPresenterInterface!
    
    private static let cellReuseID = "cell"
    
    // MARK: - Properties
    private lazy var searchBar = UISearchBar(frame: .zero)
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(reloadAction), for: .valueChanged)
        return refresh
    }()
    
    private enum Section: CaseIterable {
        case main
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    
    // MARK: - Setups
    
    private func setupNavigationBarItems() {
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
    }
    
    private func createLayout() {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Country> = {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Country> { cell, _, country in
            
            var content = cell.defaultContentConfiguration()
            content.text = country.name.common
            content.secondaryText = country.flag
            cell.contentConfiguration = content
            
            if country.isSelected {
                cell.accessories = [.checkmark()]
            } else {
                cell.accessories = []
            }
            
        }
        
        return UICollectionViewDiffableDataSource<Section, Country>(collectionView: collectionView) { (collectionView, indexPath, country) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: country)
        }
    }()

    
    // MARK: - Actions
    
    @objc private func reloadAction() {
        presenter.refreshDidOccur()
        refreshControl.endRefreshing()
        searchBar.text?.removeAll()
    }
    
    @objc private func doneAction() {
        presenter.doneDidPress()
    }
        
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelectItem(indexPath: indexPath)
    }
    
}


extension CountriesListView: CountriesListViewInterface {
    func applySnapShot(countries: [Country]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Country>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(countries)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func initialSetup() {
        createLayout()
        setupNavigationBarItems()
        collectionView.refreshControl = refreshControl
        searchBar.delegate = self
    }
    
    func addCheckMark(at indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewListCell else { return }
        cell.accessories = [.checkmark()]
    }
    
    func removeCheckMark(at indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewListCell else { return }
        cell.accessories = []
    }
    
}

// MARK: - SearchBar Delegate

extension CountriesListView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchBarTextDidChange(searchText)
    }
}
