//
//  myTextField.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 30/10/2021.
//

import UIKit

class myTextField: UITextField {
    
    let inset: CGFloat = 16
    
        // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
        // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        format()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        format()
    }
    
    func format(){
        //  contentView.layer.borderColor = CGColor.init(gray: 12, alpha: 1)
        //contentView.borderStyle = UITextField.BorderStyle.line
        self.layer.cornerRadius = 10
        //contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.textAlignment = .left
    }
    
}
