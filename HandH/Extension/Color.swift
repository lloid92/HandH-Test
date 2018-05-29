//
//  Color.swift
//  HandH
//
//  Created by Alpaca Dev on 25.05.2018.
//  Copyright © 2018 Denis Dultsev. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
    convenience init?(hexString: String) {
        if let number = Int.init(hexString.replacingOccurrences(of: "#", with: ""), radix: 16) {
            self.init(hex: number)
        } else {
            return nil
        }
    }
    
    struct handh {
        
        static func black(_ alpha: CGFloat = 1.0) -> UIColor {
            return UIColor.init(hexString: "#333333")!.withAlphaComponent(alpha)
        }
        
        static func warmGrey(_ alpha: CGFloat = 1.0) -> UIColor {
            return UIColor.init(hexString: "#797979")!.withAlphaComponent(alpha)
        }
        
        static func tangerine(_ alpha: CGFloat = 1.0) -> UIColor {
            return UIColor.init(hexString: "#ff9b00")!.withAlphaComponent(alpha)
        }
        
        static func white(_ alpha: CGFloat = 1.0) -> UIColor {
            return UIColor.init(hexString: "#ebebeb")!.withAlphaComponent(alpha)
        }
        
    }
    
}
