//
//  Protocols.swift
//  StatefulView
//
//  Created by Mobin Jahantark on 1/2/20.
//  Copyright © 2020 Mobin Jahantark. All rights reserved.
//

import UIKit

public protocol EmptyStateDelegate: class {
    func buttonDidPress(_ button: UIButton)
}

/**
Empty state for any UIView.

In most cases you will not use this class directly. This is how you will probably use:

```
yourView.emptyState.show(type: yourEnum.something)
```
and
```
yourView.emptyState.hide()
```
*/
open class EmptyState {
    
    public enum ActionType {
        case tapOnSubtitle, tapOnFooter
    }
    
    private var parent: UIView!
    
    // MARK: - public variables
    
    /// an object acts as button delegate. It has one method that will pass you the button when it's pressed.
    public weak var delegate: EmptyStateDelegate?
    
    /// Set this to your own nib file if you don't want the default emptyStateView.
    ///
    /// Remember to set the UIView subclass to `EmptyStateView` in your xib file then connect its outlets to your controls.
    public var customNib: UINib? {
        didSet {
            emptyStateView = EmptyStateView.fromNib(customNib)
            setEmptyStateViewAsSubView()
        }
    }
    
    /// A boolean value determines whether emptyStateView is visible in your view or not.
    public var isVisible: Bool { !emptyStateView.isHidden }
    
    /// Set this to your custom struct conforms to EmptyStateAppearance protocol for customized emptyStateView
    public var appearance: EmptyStateAppearance! = EmptyStateDefaultAppearance() {
        didSet {
            emptyStateView.setAppearance(appearance)
        }
    }
    
    
    // MARK: - private variables
    
    private var emptyStateView: EmptyStateView = EmptyStateView.fromNib()
    
    
    
    
    // MARK: - init
    
    init(in view: UIView) {
        parent = view
        setEmptyStateViewAsSubView()
    }
    
    
    private func setEmptyStateViewAsSubView() {
        emptyStateView.isHidden = true
        emptyStateView.tapHandler = { [weak self] sender in
            self?.delegate?.buttonDidPress(sender)
        }
        if let view = parent as? UITableView {
            view.backgroundView = emptyStateView
        } else if let view = parent as? UICollectionView {
            view.backgroundView = emptyStateView
        } else {
            emptyStateView.translatesAutoresizingMaskIntoConstraints = false
            parent.addSubview(emptyStateView)
            NSLayoutConstraint.activate([
                emptyStateView.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
                emptyStateView.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
                emptyStateView.centerYAnchor.constraint(equalTo: parent.centerYAnchor)
            ])
        }
        emptyStateView.layoutIfNeeded()
    }
    
    
    // MARK: - public methods
    
    
    /**
     Shows emptyStateView in your view.
     - parameter type: Create an enum that conforms to EmptyStateType and pass it as type.
     */
    public func show(type: EmptyStateType?, verticalOffset: CGFloat = 0) {
        if parent.loadState.isAnimating { parent.loadState.stopAnimating() }
        emptyStateView.topConstraint?.constant = 20 + parent.safeAreaInsets.top
        emptyStateView.isHidden = false
        emptyStateView.fill(with: type)
        if let view = parent as? UICollectionView {
            if let headerHeight = (view.collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize.height {
                emptyStateView.topConstraint?.constant = 20 + headerHeight + parent.safeAreaInsets.top
            }
        }
        emptyStateView.verticalConstraint?.constant = verticalOffset
    }
    
    /// Hides emptyStateView from your view.
    public func hide() {
        emptyStateView.isHidden = true
    }
    
    public func set(verticalOffset: CGFloat) {
        emptyStateView.verticalConstraint?.constant = verticalOffset
        emptyStateView.layoutIfNeeded()
    }
    
    public func addAction(for type: ActionType, target: Any?, action: Selector?) {
        switch type {
        case .tapOnSubtitle:
            emptyStateView.subtitleLabel?.isUserInteractionEnabled = true
            emptyStateView.subtitleLabel?.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
        case .tapOnFooter:
            emptyStateView.footerLabel.isUserInteractionEnabled = true
            emptyStateView.footerLabel.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
        }
    }
    
}
