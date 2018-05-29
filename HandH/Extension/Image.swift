//
//  Image.swift
//  HandH
//
//  Created by Alpaca Dev on 28.05.2018.
//  Copyright © 2018 Denis Dultsev. All rights reserved.
//

import UIKit

extension UIImage {
    
    /**
     
     init UIImage from UIColor
     
     */
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
        
    }
    
}
