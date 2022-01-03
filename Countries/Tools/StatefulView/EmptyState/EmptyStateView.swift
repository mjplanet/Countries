//
//  EmptyStateView.swift
//  StatefulView
//
//  Created by Mobin Jahantark on 1/2/20.
//  Copyright © 2020 Mobin Jahantark. All rights reserved.
//

import UIKit

public class EmptyStateView: UIView {

    @IBOutlet public var titleLabel: UILabel?
    @IBOutlet public var subtitleLabel: UILabel?
    @IBOutlet public var imageView: UIImageView?
    @IBOutlet public var button: UIButton?
    @IBOutlet private var textsStack: UIStackView?
    @IBOutlet private var imageStack: UIStackView?
    @IBOutlet private var buttonStack: UIStackView?
    @IBOutlet public weak var footerLabel: UILabel!
    
    @IBOutlet internal var topConstraint: NSLayoutConstraint?
    @IBOutlet internal var verticalConstraint: NSLayoutConstraint?

    
    var tapHandler: ((UIButton) -> Void)?
    
    func fill(with type: EmptyStateType?) {
        titleLabel?.isHidden = type?.title == nil
        titleLabel?.text = type?.title
        
        subtitleLabel?.isHidden = type?.subtitle == nil && type?.attributedSubtitle == nil
        if let attrSubtitle = type?.attributedSubtitle {
            subtitleLabel?.attributedText = attrSubtitle
        } else {
            subtitleLabel?.text = type?.subtitle
        }
        
        imageView?.isHidden = type?.image == nil
        imageView?.image = type?.image
        
        button?.isHidden = type?.buttonTitle == nil
        button?.setImage(type?.buttonImage, for: .normal)
        footerLabel.isHidden = type?.footerText == nil
        
        button?.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        UIView.performWithoutAnimation {
            self.button?.setTitle(type?.buttonTitle, for: .normal)
        }
        footerLabel.attributedText = type?.footerText
    }
    
    
    func setAppearance(_ appearance: EmptyStateAppearance) {
        titleLabel?.textColor = appearance.titleLabelColor
        button?.tintColor = appearance.buttonTintColor
        button?.backgroundColor = appearance.buttonBackgroundColor
        button?.layer.borderColor = appearance.buttonBorderColor.cgColor
        button?.layer.borderWidth = 1
        
//        subtitleLabel?.textColor = appearance.subtitleLabelColor
//        if let font = appearance.subtitleLabelFont { subtitleLabel?.font = font }
        
        titleLabel?.textAlignment = appearance.titleTextAlignment
        subtitleLabel?.textAlignment = appearance.subtitleTextAlignment
        
        if let font = appearance.titleLabelFont { titleLabel?.font = font }
        if let font = appearance.buttonTitleTextFont { button?.titleLabel?.font = font }
        
        button?.contentEdgeInsets = appearance.buttonContentInset
        button?.layer.cornerRadius = appearance.buttonCornerRadius
        
        textsStack?.spacing = appearance.textsVerticalSpace
        imageStack?.spacing = appearance.imageBottomInset
        buttonStack?.spacing = appearance.buttonTopInset
        if appearance.buttonSize != .zero {
            button?.heightAnchor.constraint(equalToConstant: appearance.buttonSize.height).isActive = true
            button?.widthAnchor.constraint(equalToConstant: appearance.buttonSize.width).isActive = true
            footerLabel.widthAnchor.constraint(equalToConstant: appearance.buttonSize.width).isActive = true
        }
    }
    
    
    public override func awakeFromNib() {
        button?.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    }
    
    
    @objc private func buttonAction(_ sender: UIButton) {
        tapHandler?(sender)
    }

}



extension EmptyStateView {
    static func fromNib(_ nib: UINib? = nil) -> EmptyStateView {
        if let nib = nib {
            let v = nib.instantiate(withOwner: nil, options: nil).last
            if !(v is EmptyStateView) {
                fatalError("Could not cast your custom nib to EmptyStateView. Make sure you set the nib's view subclass to EmptyStateView")
            }
            return v as! EmptyStateView
        }
        let nibName = String(describing: self)
        let bundle = Bundle(for: self.classForCoder())
        return UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: nil, options: nil).last as! EmptyStateView
    }
}
