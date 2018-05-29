//
//  View.swift
//  tranziter
//
//  Created by Alpaca Dev on 01.12.17.
//  Copyright © 2017 Alpaca Dev. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     
     init UIView from Nib-file
     
     */
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        return contentView
    }
    
}


