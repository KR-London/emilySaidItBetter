//
//  Fonts.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 12/12/2021.
//

import Foundation
import UIKit
import SwiftUI


extension UIFont {
    
        /// Create a font with the large title text style.
    public static var titleOne: UIFont {
        return systemFont(ofSize: 32, weight: .medium)
    }
    
        /// Create a font with the title text style.
    public static var titleTwo: UIFont {
        return systemFont(ofSize: 32, weight: .thin)
    }
    
    public static var bodyBold: UIFont {
        return systemFont(ofSize: 18, weight: .semibold)
    }
    
    public static var body: UIFont {
        return systemFont(ofSize: 18)
    }
    
    public static var caption: UIFont {
        return systemFont(ofSize: 14)
    }
}

extension Font {
    public static var titleOne: Font {
        return Font.system(size: 32, weight: .medium)
    }
    
        /// Create a font with the title text style.
    public static var titleTwo: Font {
        return Font.system(size: 32, weight: .thin)
    }
    
    public static var bodyBold: Font {
        return Font.system(size: 18, weight: .semibold)
    }
    
    public static var body: Font {
        return Font.system(size: 18)
    }
    
    public static var caption: Font {
        return Font.system(size: 14)
    }
}


extension UILabel {
    func setTextWithLineSpacing(text: String, lineHeightMultiply: CGFloat = 1.3) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiply
        paragraphStyle.alignment = .center
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}


extension String {
    func firstLetterUppercased() -> String {
        guard let first = first, first.isLowercase else { return self }
        return String(first).uppercased() + dropFirst()
    }
}
