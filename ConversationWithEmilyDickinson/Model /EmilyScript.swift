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
                            phrase(bold: "Hello again, \(name)", thin: "Did anything preoccupy you today?", placeholder: "Three words"),
                            phrase(bold: " \(name)", thin: "Grab a fleeting feeling", placeholder: "Three words of now"),
                            phrase(bold: "Nice to see you \(name)", thin: "Today might be a special day", placeholder: "3 words of hope"),
                            phrase(bold: "\(name)", thin: "What is beautiful for you", placeholder: "Short works best"),
                            phrase(bold: "So nice to see you", thin: "What is beautiful for you", placeholder: "Short works best"),
                            phrase(bold: "Darling", thin: "Grab a fleeting feeling…", placeholder: "… brief is best"),
                                   phrase(bold: "\(name)", thin: "What is your happiest thought…", placeholder: "… brief is best"),
                                   phrase(bold: "My dear \(name),", thin: "tell me today’s truth", placeholder: "… brief is best"),
                                   phrase(bold: "I am here.", thin: "Ask me a deep question", placeholder: "… brief is best"),
                                   phrase(bold: "I sometimes wonder ", thin: "what is by ear unheard?", placeholder: "… brief is best"),
                                   phrase(bold: "A new day", thin: "what is it time to see?", placeholder: "… brief is best"),
                                   phrase(bold: "Be brave", thin: "What seems possible?", placeholder: "… brief is best"),
                                   phrase(bold: "Your heart \(name)", thin: "what does it yearn for?", placeholder: "Just three words"),
                                   phrase(bold: "Ever dear \(name)", thin: "What is the smell of home for you", placeholder: "… brief is best"),
                                   phrase(bold: "\(name) - you’re here ", thin: "What do you feel?", placeholder: "… brief is best"),
                                   phrase(bold: "Dear \(name)", thin: "Tell me a happy sound", placeholder: "… brief is best"),
                                    phrase(bold: "Tell me \(name)", thin: "which bird are you?", placeholder: "… brief is best"),
                        ]
        return values.randomElement() ??  phrase(bold: "Hello", thin: "Shall we talk?", placeholder: "Three important words")
    }
    
    func intermezzoPhrase() -> phrase{
        let values = [
                        phrase(thin: "Oh ... I think I understand ....", bold: "Let me show you a poem"),
                        phrase(thin: "Your truth ...", bold: "... dare you tell a soul?"),
                        phrase(thin: "Forever ...", bold: "... now ... "),
                        phrase(thin: "Truth is so rare", bold: "it is delightful to tell it"),
                        phrase(thin: "I am looking...", bold: "... looking for myself"),
                        phrase(thin: "Nothing...", bold: "... has as much power as a word"),
                        phrase(thin: "To live", bold: "it is so startling")
                    ]
        return values.randomElement() ?? phrase(thin: "....", bold: "....")
    }
    
    func tryAgain() -> String{
        let values = ["Write what you see?", "Write short but sharp", "Say what you don't say", "Try a phrase",
                      "Write one word",
                      "Write what you see",
                      "Tell it slant",
                      "What can you hear?",
                      "Share your thought",
                      "A funny word",
                      "Say it slant",
                      "Short and sweet",
                      "Tell me a secret",
                      "What sums up today"]
        
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
