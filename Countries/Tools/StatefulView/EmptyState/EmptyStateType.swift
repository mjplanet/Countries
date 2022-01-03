//
//  EmptyStateType.swift
//  StatefulView
//
//  Created by Mobin Jahantark on 1/2/20.
//  Copyright © 2020 Mobin Jahantark. All rights reserved.
//

import UIKit

public protocol EmptyStateType {
    var title: String? { get }
    var subtitle: String? { get }
    var attributedSubtitle: NSAttributedString? { get }
    var image: UIImage? { get }
    var buttonTitle: String? { get }
    var buttonImage: UIImage? { get }
    var footerText: NSAttributedString? { get }
}

public extension EmptyStateType {
    var title: String? { nil }
    var subtitle: String? { nil }
    var attributedSubtitle: NSAttributedString? { nil }
    var image: UIImage? { nil }
    var buttonTitle: String? { nil }
    var buttonImage: UIImage? { nil }
    var footerText: NSAttributedString? { nil }
}
