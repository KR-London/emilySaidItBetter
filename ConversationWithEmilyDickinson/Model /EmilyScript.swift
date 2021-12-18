//
//  EmilyScript.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 16/12/2021.
//

import Foundation

struct EmilyScript{
    
    let name = (UserDefaults.standard.object(forKey: "Name") as? String ?? "").isEmpty ? "Friend" : (UserDefaults.standard.object(forKey: "Name") as? String ?? "")
    
    func openingPhrase() -> phrase{
        let values =    [
                            phrase(bold: "Hello again, \(name)", thin: "Did anything preoccupy you today?", placeholder: "Three words"),
                            phrase(bold: "\(name)", thin: "Grab a fleeting feeling", placeholder: "Three words of now"),
                            phrase(bold: "Nice to see you \(name)", thin: "Today might be a special day", placeholder: "3 words of hope"),
                            phrase(bold: "\(name)", thin: "What is beautiful for you?", placeholder: "Short works best"),
                            phrase(bold: "So nice to see you", thin: "What is beautiful for you?", placeholder: "… brief is best"),
                            phrase(bold: "Darling", thin: "Grab a fleeting feeling…", placeholder: "… brief is best"),
                                   phrase(bold: "\(name)", thin: "What is your happiest thought?", placeholder: "… brief is best"),
                                   phrase(bold: "My dear \(name),", thin: "Tell me today’s truth", placeholder: "… brief is best"),
                                   phrase(bold: "I am here.", thin: "Ask me a deep question.", placeholder: "… brief is best"),
                                   phrase(bold: "A new day", thin: "What is it time to see?", placeholder: "… brief is best"),
                                   phrase(bold: "Be brave", thin: "What seems possible?", placeholder: "… brief is best"),
                                   phrase(bold: "Your heart \(name)", thin: "What does it yearn for?", placeholder: "Just three words"),
                                   phrase(bold: "Ever Dear \(name)", thin: "What is the smell of home for you?", placeholder: "… brief is best"),
                                   phrase(bold: "\(name) - you’re here. ", thin: "What do you feel?", placeholder: "… brief is best"),
                                   phrase(bold: "Dear \(name)", thin: "Tell me a happy sound.", placeholder: "… brief is best"),
                                    phrase(bold: "Tell me \(name)", thin: "Which bird do you love best?", placeholder: "... do tell"),
                                    phrase(bold: "Nature is a wonder", thin: "Tell me about nature", placeholder: "… brief is best"), phrase(bold: "Nature is a wonder", thin: "Tell me about nature", placeholder: "… brief is best"),
 phrase(bold: "Nature is a wonder", thin: "Tell me about nature", placeholder: "… brief is best"),
                            phrase(bold: "Say it true", thin: "Say it slant", placeholder: "Say what you know...")
                        ]
        return  values.randomElement() ??  phrase(bold: "Hello", thin: "Shall we talk?", placeholder: "Three important words")
    }
    
    func intermezzoPhrase() -> phrase{
        
        if UserDefaults.standard.integer(forKey: "LoginCount") < 2{
            return phrase(thin: "Oh ... I think I understand ....", bold: "Let me show you a poem")
        }
        
        let values = [
                        phrase(thin: "Oh ... I think I understand ....", bold: "Let me show you a poem"),
                        phrase(thin: "Your truth ...", bold: "... dare you tell a soul?"),
                        phrase(thin: "Forever ...", bold: "... now ... "),
                        phrase(thin: "Truth is so rare", bold: "It is delightful to tell it"),
                        phrase(thin: "I am looking...", bold: "... looking for myself"),
                        phrase(thin: "A word...", bold: "... nothing has as much power."),
                        phrase(thin: "To live...", bold: "...it is so startling")
                    ]
        return values.randomElement() ?? phrase(thin: "....", bold: "....")
    }
    
    func tryAgain() -> String{
        let values = ["Write what you see", "Write short but sharp", "Say what you don't say", "Try a phrase",
                      "Write one word",
                      "Write what you see",
                      "Tell it slant",
                      "What can you hear?",
                      "Share your thought",
                      "A funny word",
                      "Short and sweet",
                      "Tell me a secret", "Try a song lyric", "Try saying nothing…"]
        
        return values.randomElement() ?? "Three words"
    }    
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
