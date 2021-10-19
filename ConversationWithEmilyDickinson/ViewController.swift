//
//  ViewController.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 09/10/2021.
//

var poemCollection = [Verse]()

import UIKit
import NaturalLanguage
import CoreML
import CreateML



class ViewController: UIViewController, UITextFieldDelegate {
    
    var textInputField = UITextField()
    var label = UILabel()
    var button = UIButton()
  
    var allTheLines = [ (String, [Double]) ]()
    var firstLinesWithPoemWeights = [ (String, [Double]) ]()
    var findThePoem = [String: Verse]()
    var firstLines = [String]()
    
   // var customEmbedding : NLEmbedding?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeANewModel()
        
        setup()
        layout()
        
        let sentenceEmbedding = NLEmbedding.sentenceEmbedding(for: .english)?.vector(for: "Hello")
        
        print(sentenceEmbedding!)
        
      //  var unpackedModel = [String : [Double]]()
       // let model = copiedVerse()
       let modelURL = Bundle.main.url(forResource: "Verse2", withExtension: "mlmodelc")
       // let modelURL = URL(string: "/Users/kate/Desktop/ConversationWithEmilyDickinson/ConversationWithEmilyDickinson/Verse2.mlmodel")
       // let model = UR
       // customEmbedding = try! NLEmbedding.init(contentsOf: modelURL!)
        //NLEmbedding.sentenceEmbedding(for: .english)
        //try! NLEmbedding.init(contentsOf: modelURL!)
        
        //let modelURL = Bundle.main.url(forResource: "Verse2", withExtension: "mlmodelc")
       // let customEmbedding = try! NLEmbedding.init(contentsOf: modelURL!)
        
        
        // this is where I get very lost. I have included in the bundle models that I pretrained on the full works of emily Dickinson, as per the WWDC demo to get better performance by have custom sentence embeddings.
        // However I am lost as to how to use these custom embeddings in my project
        // My best plan was to manually unpack the model back into a dictionary, and they use that to make a custom embedding.
        // this is also not working for me though, because the code snippet to do this weirdly only works on my laptop
     //   for i in 0 ...  firstLines.count - 1 {
            
           // let vector = customEmbedding?.vector(for: firstLines[i])
//            if i > 320{
//               // print("Whoah")
//            }
            
           // NLEmbedding.sentenceEmbedding(for: .english)!.vector(for: firstLines[i])
//            if let goodVector = customEmbedding?.vector(for: firstLines[i])
//            {
//                firstLinesWithPoemWeights.append((firstLines[i], goodVector))
//            }
//            do{
//                let dataFromModel =  try model.prediction(text: firstLines[i]).vector
//               //print(dataFromModel)
//                var vector = [Double]()
//
//                for i in 0 ... 511{
//                    vector.append(contentsOf: [dataFromModel[i].doubleValue])
//                }
//
//                firstLinesWithPoemWeights.append((firstLines[i], vector))
//
//            } catch {
//                print(error.localizedDescription)
//            }
   //     }
        
      //  print(firstLinesWithPoemWeights.first!)
    }
    
    func makeANewModel(){
        var sentenceEmbeddingModel = [String : [Double]]()
        let sentenceEmbedding = NLEmbedding.sentenceEmbedding(for: .english)
        
        var rawString = ""
        
        if let filepath = Bundle.main.url(forResource: "Emily", withExtension: "tsv")
        {
            do {
                rawString = try String(contentsOf: filepath)
            } catch{
                print( error.localizedDescription)
            }
        }
        else{
            print("Your filepath failed")
        }
        
            /// Break it into individual verses and tidy up some typographocal strangness
            /// source: Project Gutenberg's Poems: Three Series, Complete, by Emily Dickinson
            var unprocessedVerses = rawString.components(separatedBy: "\r\n\r\n")
            for unprocessedVerse in unprocessedVerses {
                var lines = unprocessedVerse.components(separatedBy: "\r\n")

            if lines.count < 0
            {
                for i in 0 ... lines.count-1
                {
                    lines[i] = lines[i].replacingOccurrences(of: "\"", with: "")
                    lines[i] = lines[i].replacingOccurrences(of: "T ", with: "It ")
                    lines[i] = lines[i].trimmingCharacters(in: .whitespaces)
                    print(lines[i])
                  //  if let sentenceEmbedding = NLEmbedding.sentenceEmbedding(for: .english){
                       // print("B")
                        if let vector = sentenceEmbedding?.vector(for: lines[i]){
                            sentenceEmbeddingModel[ lines[i] ] = vector
                          //  print("C")
                       // }
                    }
                }
                
            
                
                //let verse = Verse(lines: lines)
               // poemCollection.append(verse)
            }
        }
        
        //let url = URL(fileURLWithPath: "/Desktop/MLMdata.dat")
            // write to file
       // NSKeyedArchiver.archiveRootObject(sentenceEmbeddingModel, toFile: "/Desktop/MLMdata.dat" )
        
        let myPath:String = userDesktop() + "/"
      //  if let customPlistURL = URL(string: "~/Desktop/XcodeDump/text.plist") {
                //writing
            do {
                try "Hello".write(to: URL(string: myPath)!, atomically: false, encoding: .utf8)
            }
            catch {
                
                print(error.localizedDescription)
            }
           // NSDictionary(dictionary: sentenceEmbeddingModel).write(to: customPlistURL, atomically: true)
      //  }
    }
    
    public func userDesktop() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        let userDesktopDirectory = paths[0]
        return userDesktopDirectory
    }
  
    
    func layout(){
        textInputField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textInputField)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        textInputField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textInputField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textInputField.placeholder = "What is on your mind?"
        textInputField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textInputField.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        textInputField.delegate = self
        textInputField.addTarget(self, action: #selector(userAnswer), for: UIControl.Event.editingDidEndOnExit)
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font.withSize(36)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        label.isHidden = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.setTitle("🔄", for: .normal)
        button.addTarget(self, action: #selector(restart), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 150).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.isHidden = true
    }
    
    @objc func restart(_ textField:UIButton ){
        label.isHidden = true
        textInputField.text = ""
        textInputField.placeholder = "What's on your mind?"
        textInputField.isHidden = false
        button.isHidden = true
    }

    @objc func userAnswer(_ textField:UITextField ){
        
        var closestEmilyDickinsonLine = ""
            if let text = self.textInputField.text{
                if let closestline = self.answerKeyCustom(for: text){
                    closestEmilyDickinsonLine = closestline
                }
            }
            
            textField.isHidden = true
            self.label.isHidden = false
            
            let poem = findThePoem[closestEmilyDickinsonLine]
            
            var poemText = ""
            
            for lines in poem!.lines{
                poemText.append(contentsOf: lines)
                poemText.append("\n")
            }
            
            
            self.label.text = poemText
       // }
        
        button.isHidden = false
        
      //  self.label.text = "Oh ... "
        
       
        
//        commentsDriver.userComment(userComment: textField.text!)
//
//        textField.placeholder =  textField.text!
//        textField.text = ""
    }
    
    func answerKeyCustom(for string: String) -> String? {
        guard let embedding = NLEmbedding.sentenceEmbedding(for: .english) else { return nil }
        
     //   let similarity =  EMSimilarity()
        let modelURL = Bundle.main.url(forResource: "Verse2", withExtension: "mlmodelc")
        let customEmbedding = try! NLEmbedding.init(contentsOf: modelURL!)
        guard let queryVector = embedding.vector(for: string) else { return nil }
            //  guard let queryVector = customEmbedding!.vector(for: string) else { return nil }
        
//        guard let emilyVector = self.customEmbedding?.vector(for: "This is my letter to the world,")  else {
//            return nil
//        }
                //self.customEmbedding?.vector(for: "This is my letter to the world,") else {
//            return nil
//        }
        
        
        guard let (nearestLineKey, distance ) = customEmbedding.neighbors(for: queryVector, maximumCount: 1).first else
        {
            return nil
            
        }
        let myAnswer = self.findThePoem[ nearestLineKey ]
        return myAnswer?.lines.first
        
    }

    // This loads in the collected works of Emily Dickinson from a TSV file included in the bundle
    func setup() {
        
        var rawString = ""
        
        if let filepath = Bundle.main.url(forResource: "Emily", withExtension: "tsv")
        {
            do {
                rawString = try String(contentsOf: filepath)
            } catch{
                print( error.localizedDescription)
            }
        }
        else{
            print("Your filepath failed")
        }

       /// Break it into individual verses and tidy up some typographocal strangness
       /// source: Project Gutenberg's Poems: Three Series, Complete, by Emily Dickinson
        var unprocessedVerses = rawString.components(separatedBy: "\r\n\r\n")
        for unprocessedVerse in unprocessedVerses {
             var lines = unprocessedVerse.components(separatedBy: "\r\n")

            // initialise the verse object
            if lines.count > 1
            {
                for i in 0 ... lines.count-1
                {
                    lines[i] = lines[i].replacingOccurrences(of: "\"", with: "")
                    lines[i] = lines[i].replacingOccurrences(of: "T ", with: "It ")
                    lines[i] = lines[i].trimmingCharacters(in: .whitespaces)
                }
                
                let verse = Verse(lines: lines)
                poemCollection.append(verse)
            }
         }
        
        for poem in poemCollection{
            for line in poem.lines{
                findThePoem[line] = poem
                allTheLines.append(contentsOf: [(line, [0.0])])
                
                // TO DO: Think about best implementation.
              //  if let sentenceEmbedding = NLEmbedding.sentenceEmbedding(for: .english){
                    
               //     if let vector = sentenceEmbedding.vector(for: line){
                 //       allTheLines.append(contentsOf: [(line, vector)])
                 //                    }
                 //                }
                    //allTheLines.append(contentsOf: [line])
            }
        }
        
        // pick of the first lines - for the approach where we iterate through verses and take the average weight of the verses as pre calculated and fed in by the ml model
        for i in 0 ...  allTheLines.count - 1{
            let firstLine = findThePoem[ allTheLines[i].0 ]?.lines.first
            firstLines.append(firstLine!)
        }
        
    }
}

