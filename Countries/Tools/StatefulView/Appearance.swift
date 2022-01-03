//
//  Appearance.swift
//  StatefulView
//
//  Created by Mobin Jahantark on 1/1/20.
//  Copyright © 2020 Mobin Jahantark. All rights reserved.
//

import UIKit


/**
 Appearance protocol for EmptyState style.
 
 Create a struct and conform to this protocol and set its properties to your own.
 
 Here are all properties
 + # titleLabelColor
    title label color. Default is `nil`
 + # subtitleLabelColor
    subtitle label color. Default is `nil`
 + # buttonTitleTextColor
    Button title label text color. Default is its `tintColor`
 + # titleLabelStyle
    Font for title label.
 + # subtitleLabelStyle
    Font for subtitle label.
 + # buttonTitleTextStyle
    Font for button's label.
 + # buttonBackgroundColor
    Background color for button. Default is `.clear`
 + # buttonCornerRadius
    Corner radius for button. Default is `0`
 + # roundButton
    If sets to true cornerRadius will be override so that button be round. Default is `false`
 + # buttonContentInset
    Content inset for button. Default is `UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)`
 + # textsVerticalSpace
    Space between title and subtitle labels. Default is `4`
 + # imageBottomInset
    Space between title label and imageView. Default is `20`
 + # buttonTopInset
    Space between subtitle label and button. Default is `20`
 + # titleTextAlignment
    Title text alignment. Default is `.center`.
 + # subtitleTextAlignment
    Subitle text alignment. Default is `.center`.
 */
public protocol EmptyStateAppearance {
    /// title label color. Default is `nil`
    var titleLabelColor: UIColor? { get }
    /// subtitle label color. Default is `nil`
    var subtitleLabelColor: UIColor? { get }
    
    /// Font for title label.
    var titleLabelFont: UIFont? { get }
    /// Font for subtitle label.
    var subtitleLabelFont: UIFont? { get }
    
    /// Button title label text color. Default is its `tintColor`
    var buttonTintColor: UIColor? { get }
    /// Font for button's label. 
    var buttonTitleTextFont: UIFont? { get }
    /// Background color for button. Default is `.clear`
    var buttonBackgroundColor: UIColor? { get }
    /// If sets to true cornerRadius will be override so that button be round. Default is `false`
    var roundButton: Bool { get }
    /// Corner radius for button. Default is `0`
    var buttonCornerRadius: CGFloat { get }
    /// Content inset for button. Default is `UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)`
    var buttonContentInset: UIEdgeInsets { get }
    /// Button border color. Default is .clear
    var buttonBorderColor: UIColor { get }
    /// Button size, if sets to .zero it will uses instrincContentSize
    var buttonSize: CGSize { get }
    /// Space between title and subtitle labels. Default is `4`
    var textsVerticalSpace: CGFloat { get }
    /// Space between title label and imageView. Default is `20`
    var imageBottomInset: CGFloat { get }
    /// Space between subtitle label and button. Default is `20`
    var buttonTopInset: CGFloat { get }
    /// Title text alignment. Default is `.center`.
    var titleTextAlignment: NSTextAlignment { get }
    /// Subitle text alignment. Default is `.center`.
    var subtitleTextAlignment: NSTextAlignment { get }
}

public extension EmptyStateAppearance {
    var titleLabelColor: UIColor? { nil }
    var subtitleLabelColor: UIColor? { nil }
    var titleLabelFont: UIFont? { nil }
    var subtitleLabelFont: UIFont? { nil }
    var buttonTitleTextFont: UIFont? { nil }
    var buttonTintColor: UIColor? { nil }
    var buttonBackgroundColor: UIColor? { .clear }
    var roundButton: Bool { false }
    var buttonCornerRadius: CGFloat { 0 }
    var buttonContentInset: UIEdgeInsets { UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20) }
    var buttonBorderColor: UIColor { .clear }
    var buttonSize: CGSize { .zero }
    var textsVerticalSpace: CGFloat { 4 }
    var imageBottomInset: CGFloat { 20 }
    var buttonTopInset: CGFloat { 20 }
    var titleTextAlignment: NSTextAlignment { .center }
    var subtitleTextAlignment: NSTextAlignment { .center }
}


struct EmptyStateDefaultAppearance: EmptyStateAppearance { }


/**
 Appearance protocol for LoadState style.
 
 Create a struct and conform to this protocol and set its properties to your own.
 
 Here are all properties
 + # color
    UIActivityIndicatorView color.
 + # style
    UIActivityIndicatorView style. Default is `.medium`
 */
public protocol LoadStateAppearance {
    /// UIActivityIndicatorView color.
    var color: UIColor { get }
    
    /// UIActivityIndicatorView style. Default is `.medium`
    var style: UIActivityIndicatorView.Style { get }
}


public extension LoadStateAppearance {
    var style: UIActivityIndicatorView.Style {
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView.Style.medium
        } else {
            return UIActivityIndicatorView.Style.gray
        }
    }
}






