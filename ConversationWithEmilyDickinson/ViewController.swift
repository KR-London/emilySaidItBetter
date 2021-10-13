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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        
        var unpackedModel = [String : [Double]]()
        let model = Verse2()
        
        // this is where I get very lost. I have included in the bundle models that I pretrained on the full works of emily Dickinson, as per the WWDC demo to get better performance by have custom sentence embeddings.
        // However I am lost as to how to use these custom embeddings in my project
        // My best plan was to manually unpack the model back into a dictionary, and they use that to make a custom embedding.
        // this is also not working for me though, because the code snippet to do this weirdly only works on my laptop
        for i in 0 ...  firstLines.count - 1 {
            
            do{
                let dataFromModel =  try model.prediction(text: firstLines[i]).vector
                //print(dataFromModel)
                var vector = [Double]()
                
                for i in 0 ... 511{
                    vector.append(contentsOf: [dataFromModel[i].doubleValue])
                }
                
                firstLinesWithPoemWeights.append((firstLines[i], vector))
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        print(allTheLines)
      //  let customEmbedding = try!
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
        
        let similarity =  EMSimilarity()
        
        guard let queryVector = embedding.vector(for: string) else { return nil }
        
        var answerKey: String? = nil
        var answerDistance = 2.0
        
        /// This is what was used to make the prototype work. But issues with this:
        /// 1. I'm not sure that 'distance' is giving us the satate of the art sentence embeddings
        /// 2. Crunching every line that Emily wrote very time the user makes a query is wildly inefficient. It's essential that we pre-do the work, eitehr fed in as an embedding model - or (at a pinch) done at run time in the background while the UI occupies the user with some filler chat.
//        for line in allTheLines{
//           //let distance = embedding.distance(between: string, and: line.0)
//            let distance = similarity.compute(A: queryVector, B: line.1)
//                //let distance = NLDistanceType.cosine
//            if distance < answerDistance {
//                answerDistance = distance
//                answerKey = line.0
//            }
//        }
        
        
        
                    for line in firstLinesWithPoemWeights{
                       //let distance = embedding.distance(between: string, and: line.0)
                        let distance = similarity.compute(A: queryVector, B: line.1)
                            //let distance = NLDistanceType.cosine
                        if distance < answerDistance {
                            answerDistance = distance
                            answerKey = line.0
                        }
                    }
        
            //var setAllTheLines = Set(allTheLines)
            // print(allTheLines)
        
            //for (key, vectors) in poemCollection.compactMap{$0.lines}
            // guard let (nearestLineKey, _)
        
        return  answerKey
        
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

