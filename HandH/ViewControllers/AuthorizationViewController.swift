//
//  AuthorizationViewController.swift
//  HandH
//
//  Created by Alpaca Dev on 22.05.2018.
//  Copyright © 2018 Denis Dultsev. All rights reserved.
//

import UIKit
import Alamofire

class AuthorizationViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var loginInputView: InputTextField!
    @IBOutlet var passwordInputView: InputTextField!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Variable
    
    var password: String = ""
    
    // MARK: - View Controller Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loginInputView.labelText = "Почта"
        loginInputView.isPassword = false
        loginInputView.delegate = self
        
        passwordInputView.labelText = "Пароль"
        passwordInputView.isPassword = true
        passwordInputView.delegate = self
        passwordInputView.passwordButton.addTarget(self, action: #selector(touchForgetPassword), for: .touchUpInside)
        
        
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setBackgroundImage(UIImage.init(color: UIColor.handh.tangerine()), for: .normal)
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 22.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    // MARK: - Keyboard
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardEndSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double {
            
            bottomConstraint.constant = keyboardEndSize.height
            
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
            
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        if let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double {
            
            bottomConstraint.constant = 0.0
            
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
            
        }
        
    }
    
    // MARK: - Action
    
    @IBAction func touchLoginButton() {
        
        var isError = false
        
        if !(loginInputView.textField.text?.isValidEmail() ?? false) {
            loginInputView.isError = true
            isError = true
        }
        
        if !password.isValidPassword() {
            passwordInputView.isError = true
            isError = true
        }
        
        if !isError {
            Weather.weather(city: "Новосибирск") { temperature in
                if let temperature = temperature {
                    let alert = UIAlertController.init(title: "Температура", message: temperature, preferredStyle: .alert)
                    let ok = UIAlertAction.init(title: "ОК", style: .default, handler: nil)
                    alert.addAction(ok)
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true, completion: nil)
                    })
                }
            }
        }
 
    }
    
    @objc func touchForgetPassword() {
        
        let alert = UIAlertController.init(title: "Забыли пароль?", message: "Пароль должен содержать:\n минимум 6 символов,\nминимум 1 строчную букву,\nминимум 1 заглавную букву,\nминимум 1 цифру.", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "ОК", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
    

}

// MARK: - UITextFieldDelegate

extension AuthorizationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let inputTextView = textField.superview?.superview as? InputTextField {
            inputTextView.textFieldShouldBeginEditing()
            if inputTextView.isPassword {
                textField.text = ""
                password = ""
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let inputTextView = textField.superview?.superview as? InputTextField {
            inputTextView.textFieldDidEndEditing()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let inputTextView = textField.superview?.superview as? InputTextField {
           
            inputTextView.isError = false
            
            // Replace dot with asterisk in password
            
            if inputTextView.isPassword {
                
                let char = string.cString(using: .utf8)
                let isBackspaceChar = strcmp(char, "\\b")

                if isBackspaceChar == -92 {

                    password = String(password.dropLast())
                    return true

                } else {

                    let nsPassword = password as NSString
                    password = nsPassword.replacingCharacters(in: range, with: string)
                    inputTextView.textField.text = String.init(repeating: "*", count: password.count)
                    return false

                }
 
            }
            
        }
        
        return true
        
    }
    
}
