//
//  InputTextField.swift
//  tranziter
//
//  Created by Alpaca Dev on 01.12.17.
//  Copyright © 2017 Alpaca Dev. All rights reserved.
//

import UIKit

class InputTextField: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var label: LayerLabel!
    @IBOutlet weak var topLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var underline: UIView!
    
    // MARK: - Variable
    
    let tap = UITapGestureRecognizer()

    var labelText: String = "" {
        didSet {
            label.setLayerText(labelText)
        }
    }
    
    var isError: Bool = false {
        didSet {
            if isError {
                underline.backgroundColor = UIColor.red
            } else {
                underline.backgroundColor = UIColor.handh.white()
            }
        }
    }
    
    weak var delegate: UITextFieldDelegate? = nil {
        didSet {
            textField.delegate = delegate
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
        setup()
    }
    
    // MARK: - Setup
    
    func setup() {
        
        setupLabel()
        setupTextField()
        setupUnderline()
        setupTap()
        
    }
    
    func setupLabel() {
       
        label.setLayerFont(UIFont.systemFont(ofSize: 16.0, weight: .regular))
        label.setLayerTextColor(UIColor.handh.black())
        label.lineBreakMode = .byTruncatingTail
        label.isUserInteractionEnabled = true

    }
    
    func setupTextField() {
        
        textField.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        textField.textColor = UIColor.handh.black()
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        
    }
    
    func setupUnderline() {
        
        underline.backgroundColor = UIColor.handh.white()
        
    }
    
    func setupTap() {
        
        tap.numberOfTapsRequired = 1
        tap.addTarget(self, action: #selector(actionTap))
        addGestureRecognizer(tap)
        
    }
    
    // MARK: - Action
    
    @objc func actionTap() {
        
        textField.becomeFirstResponder()
        
    }
    
    func showTextField() {
        
        topLabelConstraint.constant = 0.0

        label.setLayer(font: UIFont.systemFont(ofSize: 13.0, weight: .regular), color: UIColor.handh.warmGrey(),  duration: 0.4)
        
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
        
    }
    
    func hideTextField() {
        
        topLabelConstraint.constant = 21.0
        
        label.setLayer(font: UIFont.systemFont(ofSize: 16.0, weight: .regular), color: UIColor.handh.black(), duration: 0.4)
        
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
        
    }
    
    // MARK: - Method For UITextFieldDelegate 
    
    func textFieldShouldBeginEditing() {
        showTextField()
        isError = false
    }
    
    func textFieldDidEndEditing() {
        if textField.text!.isEmpty {
            hideTextField()
        }
    }
    
}

