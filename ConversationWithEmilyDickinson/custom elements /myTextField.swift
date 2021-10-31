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
        self.font = UIFont.systemFont(ofSize: 24, weight: .thin)
        
    }
    
}

class myThinLabel : UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        format()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        format()
    }
    
    func format(){
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        font = UIFont.systemFont(ofSize: 16, weight: .thin)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.6
    }
    
}

class myBoldLabel : UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        format()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        format()
    }
    
    func format(){
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        font = UIFont.systemFont(ofSize: 16, weight: .bold)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.6
    }
    
}


class myBlackButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        format()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        format()
    }
    
    func format(){
        heightAnchor.constraint(equalToConstant: 56).isActive = true
       widthAnchor.constraint(equalToConstant: 96).isActive = true
       backgroundColor = UIColor.black
       titleLabel?.textColor = UIColor.white
       titleLabel?.font = UIFont.systemFont(ofSize: 18)
       layer.cornerRadius = 30
    }
}





