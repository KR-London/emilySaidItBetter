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
    var resetTest = UIButton()
    var askAgain = UIButton()
  
    var allTheLines = [ (String, [Double]) ]()
    var firstLinesWithPoemWeights = [ (String, [Double]) ]()
    var findThePoem = [String: Verse]()
    var firstLines = [String]()
    
   // var customEmbedding : NLEmbedding?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)){
//            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
//                self.label.alpha = 1
//            }
//            animator.startAnimation()
//        }
//    }
    
    func animate(){
        DispatchQueue.main.asyncAfter(deadline: .now() ){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.label.alpha = 1
            }
            animator.startAnimation()
        }
    }

    func layout(){
        
        self.view.backgroundColor = .white
        
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
        
        askAgain.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(askAgain)
        askAgain.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        askAgain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        askAgain.setTitle("Ask again", for: .normal)
        askAgain.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        askAgain.heightAnchor.constraint(equalToConstant: 50).isActive = true
        askAgain.widthAnchor.constraint(equalToConstant: 150).isActive = true
        askAgain.backgroundColor = UIColor.lightGray
        askAgain.isHidden = true
        
        resetTest.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resetTest)
        resetTest.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        resetTest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        resetTest.setTitle("Reset", for: .normal)
        resetTest.addTarget(self, action: #selector(restart), for: .touchUpInside)
        resetTest.heightAnchor.constraint(equalToConstant: 50).isActive = true
        resetTest.widthAnchor.constraint(equalToConstant: 150).isActive = true
        resetTest.backgroundColor = UIColor.lightGray
        resetTest.isHidden = true

    }
    
    @objc func restart(_ textField:UIButton ){
//        label.isHidden = true
//        textInputField.text = ""
//        textInputField.placeholder = "What's on your mind?"
//        textInputField.isHidden = false
//        button.isHidden = true
        
      
        UserDefaults.standard.set(true, forKey: "launchedBefore")
        
        let introVC = introViewController()
        introVC.modalPresentationStyle = .fullScreen
        
        self.present(introVC, animated: true, completion: nil)

    }
    
    @objc func tryAgain(_ textField:UIButton ){
        label.isHidden = true
        textInputField.text = ""
        textInputField.placeholder = "What's on your mind?"
        textInputField.isHidden = false
        resetTest.isHidden = true
        askAgain.isHidden = true
    }

    @objc func userAnswer(_ textField:UITextField ){
        
        /// present chatty screen
        ///
        self.view.endEditing(true)
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore == false {
            let nextVC = chattyViewController()
            nextVC.mainViewController = self
           // nextVC.modalPresentationStyle = .fullScreen
                //  nextVC.YourLabel.text = "Passed Text"
                //  nextVC.YourLabel.text = YourArray[indexPath.row]
            
                // Push to next vizew
                //  navigationController?.pushViewController(nextVC, animated: true)
            self.present(nextVC, animated: true, completion: nil)
        }
        
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
            
            self.label.alpha = 0
            self.label.text = poemText
            resetTest.isHidden = false
            askAgain.isHidden = false
        
        if launchedBefore {
            animate()
        }
    }
    
    func answerKeyCustom(for string: String) -> String? {
        guard let embedding = NLEmbedding.sentenceEmbedding(for: .english) else { return nil }

        let modelURL = Bundle.main.url(forResource: "EmilyVerse", withExtension: "mlmodelc")
        let customEmbedding = try! NLEmbedding.init(contentsOf: modelURL!)
        guard let queryVector = embedding.vector(for: string) else { return nil }

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
            }
        }
    }
}

