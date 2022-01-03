//
//  UIView + Extension.swift
//  StatefulView
//
//  Created by Mobin Jahantark on 1/1/20.
//  Copyright © 2020 Mobin Jahantark. All rights reserved.
//

import UIKit

fileprivate enum AssociatedKeys {
    static var loadState = "mjt.loadState"
    static var emptyState = "mjt.emptyState"
}

extension UIView {
    
    /**
     Use this for showing activity indicator in view.
     
     To show the activity indicator use `startAnimating()` function and to hide it use `stopAnimating()`
     
     ## More Info:
     Check LoadState class documentation to get more information
     */
    public var loadState: LoadState! {
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.loadState,
                                     newValue ?? LoadState(in: self, icon: LoadState.Config.shared.iconImage),
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let loadState = objc_getAssociatedObject(self, &AssociatedKeys.loadState) as? LoadState else {
                self.loadState = LoadState(in: self, icon: LoadState.Config.shared.iconImage)
                return self.loadState
            }
            return loadState
        }
    }
    
    
    
    /**
     Use this for showing empty or error state in view.
     
     To show the view use `show(type: EmptyStateType)` function and to hide it use `hide()`
     
     ## More Info:
     Check EmptyState class documentation to get more information
     */
    
    public var emptyState: EmptyState! {
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.emptyState,
                                     newValue ?? EmptyState(in: self),
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let emptyState = objc_getAssociatedObject(self, &AssociatedKeys.emptyState) as? EmptyState else {
                self.emptyState = EmptyState(in: self)
                return self.emptyState
            }
            return emptyState
        }
    }
    
}
