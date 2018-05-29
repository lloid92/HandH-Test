//
//  LayerLabel.swift
//  alldms
//
//  Created by Alpaca Dev on 09.12.16.
//  Copyright © 2016 Alpaca Dev. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

/**
 
 subclass of UILabel with animation fontSize and textColor
 
 */

class LayerLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override class var layerClass : AnyClass {
        return CATextLayer.self
    }
    
    func textLayer() -> CATextLayer {
        return self.layer as! CATextLayer
    }
    
    func setup() {
        
        self.textLayer().alignmentMode = kCAAlignmentJustified
        self.textLayer().truncationMode = kCATruncationEnd
        self.textLayer().isWrapped = true
        self.layer.display()
        
    }
    
    func setLayerAttributeText(_ attriburedText: NSAttributedString) {
        super.attributedText = attributedText
        self.textLayer().string = attributedText
    }
    
    func setLayerText(_ text: String) {
        super.text = text
        self.textLayer().string = text
    }
    
    func setLayerTextColor(_ textColor: UIColor) {
        super.textColor = textColor
        self.textLayer().foregroundColor = textColor.cgColor
    }
    
    func setLayerFont(_ font: UIFont) {
        
        super.font = font
        let fontName : CFString = CFStringCreateWithCString(nil,font.fontName,CFStringBuiltInEncodings.UTF8.rawValue)
        let fontRef : CGFont = CGFont(fontName)!
        self.textLayer().font = fontRef
        self.textLayer().fontSize = font.pointSize
        
    }
    
    /**
     
     Animate change fontSize and textColor
     
     */
    
    func setLayer(font newFont: UIFont, color newColor: UIColor, duration: CGFloat) {
        
        self.textLayer().fontSize = newFont.pointSize
        self.textLayer().foregroundColor = newColor.cgColor
        
        let animationFontSize = CABasicAnimation(keyPath: "fontSize")
        animationFontSize.fromValue = font.pointSize
        animationFontSize.toValue = newFont.pointSize
        animationFontSize.duration = CFTimeInterval(duration)
        animationFontSize.isRemovedOnCompletion = false
        self.textLayer().add(animationFontSize, forKey: "label")
        
        let animationFontColor = CABasicAnimation(keyPath: "foregroundColor")
        animationFontColor.fromValue = textColor
        animationFontColor.toValue = newColor
        animationFontColor.duration = CFTimeInterval(duration)
        animationFontColor.isRemovedOnCompletion = false
        self.textLayer().add(animationFontColor, forKey: "label")
        
        self.textColor = newColor
        
    }
    
}
