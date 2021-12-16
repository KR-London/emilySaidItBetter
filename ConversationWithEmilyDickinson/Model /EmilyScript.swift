//
//  EmilyScript.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 16/12/2021.
//

import Foundation

struct EmilyScript{
    
    let name = (UserDefaults.standard.object(forKey: "Name") as? String ) ?? "friend"
   
   // private var boldLabelOne:  String = "Hello friend"
    //var thinLabelOne:  String
    //var textPlaceholderOne:  String
    
   // var intermezzoThin:  String
   // var intermezzoBold:  String
    
    
   // var boldLabelTwo:  String
   // var thinLabelTwo:  String
   // var textPlaceholderTwo:  [String]
    
//    func getboldLabelOne() -> String{
//        let values = ["Hello again \(name)"]
//        return values.randomElement() ?? "Hello friend"
//    }
//
//    func getthinLabelOne() -> String{
//        let values = ["Hello again \(name)"]
//        return values.randomElement() ?? "Hello friend"
//    }
//
//    func getTextPlaceholderOne() -> String{
//        let values = ["Three words for now)"]
//        return values.randomElement() ?? "Hello friend"
//    }
    
    func openingPhrase() -> phrase{
        let values =    [
                            phrase(bold: "Hello again, \(name)", thin: "Did anything preoccupy you today?", placeholder: "Three important words"),
                            phrase(bold: " \(name)", thin: "Grab a fleeting feeling", placeholder: "Three words for now"),
                            phrase(bold: "Nice to see you \(name)", thin: "Today might be a special day", placeholder: "Three words of hope"),
                            phrase(bold: "\(name)", thin: "What is beautiful for you", placeholder: "Short works best")
                        ]
        return values.randomElement() ??  phrase(bold: "Hello", thin: "Shall we talk?", placeholder: "Three important words")
    }
    
    func intermezzoPhrase() -> phrase{
        let values = [
                        phrase(thin: "Oh ... I think I understand ....", bold: "Let me show you a poem")
                    ]
        return values.randomElement() ?? phrase(thin: "....", bold: "....")
    }
    
    func tryAgain() -> String{
        let values = ["Write something you see?", "Adjective, noun, verb?", "Write short but sharp", "Write something you don't want to say"]
        
        return values.randomElement() ?? "Three words"
    }
    
//    func getintermezzoThin() -> String{
//        let values = ["intermezzoThin"]
//        return values.randomElement() ?? "Hello friend"
//    }
//
//    func getintermezzoBold() -> String{
//        let values = ["IntermezzoBold"]
//        return values.randomElement() ?? "Hello friend"
//    }
//
//    func getTextPlaceholderTwo() -> [String]{
//        return ["Three words for hope"]
//    }
    
}

struct phrase{
    var boldLabel:  String
    var thinLabel:  String
    var textPlaceholder:  String
    
    init(bold: String, thin: String, placeholder: String){
        boldLabel = bold
        thinLabel = thin
        textPlaceholder = placeholder
    }
    
    init(thin: String, bold: String){
        boldLabel = bold
        thinLabel = thin
        textPlaceholder = ""
    }
}
