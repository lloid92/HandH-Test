//
//  String.swift
//  HandH
//
//  Created by Alpaca Dev on 28.05.2018.
//  Copyright © 2018 Denis Dultsev. All rights reserved.
//

import UIKit

extension String {
    
    func urlEscaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passwordRegEx = "(?=.*[A-Z\u{0410}-\u{042F}])(?=.*[0-9])(?=.*[a-z\u{0430}-\u{044F}]).{6,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
}
