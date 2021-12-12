//
//  Fonts.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 12/12/2021.
//

import Foundation
import UIKit


extension UIFont {
    
        /// Create a font with the large title text style.
    public static var titleOne: UIFont {
        return systemFont(ofSize: 32, weight: .medium)
    }
    
        /// Create a font with the title text style.
    public static var titleTwo: UIFont {
        return systemFont(ofSize: 32)
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

