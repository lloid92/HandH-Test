//
//  InputPasswordField.swift
//  HandH
//
//  Created by Alpaca Dev on 28.05.2018.
//  Copyright © 2018 Denis Dultsev. All rights reserved.
//

import UIKit

class InputPasswordField: InputTextField {

    // MARK: - Outlets
    
    @IBOutlet weak var passwordButton: UIButton!
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    // MARK: - Setup
    
    func setupButton() {
        
        let buttonTitle = NSAttributedString.init(
            string: "Забыли пароль?",
            attributes: [.font : UIFont.systemFont(ofSize: 12.0),
                         .foregroundColor : UIColor.handh.warmGrey(),
                         .kern : -0.2]
        )
        
        passwordButton.setAttributedTitle(buttonTitle, for: .normal)
        passwordButton.layer.cornerRadius = 4.0
        passwordButton.layer.borderColor = UIColor.handh.white().cgColor
        passwordButton.layer.borderWidth = 0.4
          
    }
        
    // MARK: - Method For UITextFieldDelegate
    
    override func textFieldShouldBeginEditing() {
        super.textFieldShouldBeginEditing()
        textField.text = ""
    }
    
}
