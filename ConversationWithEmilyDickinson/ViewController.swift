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
//import CreateML





class ViewController: myViewController, UITextFieldDelegate {
    
    var name : String?
    
    var textInputField = myTextField()
    var label = UILabel()
    var back = UIButton()
    var share = UIButton()
    var reset = UIButton()
    var showKeyLine = UIButton()
    var signature = UIImageView()
  
    var allTheLines = [ (String, [Double]) ]()
    var firstLinesWithPoemWeights = [ (String, [Double]) ]()
    var findThePoem = [String: Verse]()
    var firstLines = [String]()
    
    var matchedLine = String()
    
    var seenAnimationsThisTime = false
    

    let stackView = UIStackView()
    let buttonStack  = UIStackView()
    
    lazy var preThinLabel: UILabel = {
        let contentView = UILabel()
            //  contentView.text = "What is your name?"
        contentView.numberOfLines = 0
        contentView.lineBreakMode = .byWordWrapping
        contentView.font = UIFont.systemFont(ofSize: 32, weight: .thin)
        return contentView
    }()
    
    
    lazy var boldLabel: UILabel = {
        let contentView = UILabel()
        //contentView.text = "My name is Emily"
        contentView.numberOfLines = 0
        contentView.lineBreakMode = .byWordWrapping
        contentView.font = UIFont.boldSystemFont(ofSize: 32.0)
        return contentView
    }()
    
    
    lazy var thinLabel: UILabel = {
        let contentView = UILabel()
      //  contentView.text = "What is your name?"
        contentView.numberOfLines = 0
        contentView.lineBreakMode = .byWordWrapping
        contentView.font = UIFont.systemFont(ofSize: 32, weight: .thin)
        return contentView
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        name = (UserDefaults.standard.object(forKey: "Name") as? String ) ?? "buddy"
        
        print("Your name is \(name!)")
        
        setup()
        layout()
        formatLabels()
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animate()
    }
    
    func animate(){
        DispatchQueue.main.asyncAfter(deadline: .now() ){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.boldLabel.alpha = 1
            }
            animator.startAnimation()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.thinLabel.alpha = 1
            }
            animator.startAnimation()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2) ){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.textInputField.alpha = 1
            }
            animator.startAnimation()
        }
    }

    func layout(){
        
        self.view.backgroundColor = .white
        let margins = view.layoutMarginsGuide
        
        textInputField.alpha = 0
        textInputField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textInputField)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        textInputField.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        textInputField.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        textInputField.placeholder = "Share your thoughts ...?"
        textInputField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textInputField.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        textInputField.delegate = self
        textInputField.addTarget(self, action: #selector(userAnswer), for: UIControl.Event.editingDidEndOnExit)
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font =  UIFont.systemFont(ofSize: 24, weight: .thin)
        label.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        label.isHidden = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(signature)
        signature.image = UIImage(named: "signature")
        signature.translatesAutoresizingMaskIntoConstraints = false
        
        signature.topAnchor.constraint(greaterThanOrEqualTo: label.bottomAnchor, constant: 20).isActive = true
        signature.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
        signature.heightAnchor.constraint(equalToConstant: 56).isActive = true
        signature.widthAnchor.constraint(equalToConstant: 92).isActive = true
        signature.alpha = 0
        
        buttonStack.addArrangedSubview(reset)
        buttonStack.addArrangedSubview(back)
        buttonStack.addArrangedSubview(share)
        buttonStack.addArrangedSubview(showKeyLine)
        view.addSubview(buttonStack)
        
        reset.backgroundColor = .clear
        showKeyLine.backgroundColor = .clear
        
        reset.addTarget(self, action: #selector(restart), for: .touchUpInside)
        showKeyLine.addTarget(self, action: #selector(showMatchedLine), for: .touchUpInside)
        
        buttonStack.axis = .horizontal
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        buttonStack.heightAnchor.constraint(equalToConstant: 56).isActive = true
        buttonStack.spacing = 16
        buttonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        buttonStack.isHidden = true
        
        share.translatesAutoresizingMaskIntoConstraints = false
      
      //  share.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
      //  askAgain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        share.setTitle("Share", for: .normal)
        share.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        share.heightAnchor.constraint(equalToConstant: 56).isActive = true
        share.widthAnchor.constraint(equalToConstant: 96).isActive = true
        share.backgroundColor = UIColor.lightGray
        share.titleLabel?.textColor = UIColor.black
        share.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        share.layer.cornerRadius = 30
        share.alpha = 0
        
        back.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(back)
        back.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        //back.trailingAnchor.constraint(equalTo: share.leadingAnchor, constant: 16).isActive = true
        
        back.setTitle("Another?", for: .normal)
        back.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        back.heightAnchor.constraint(equalToConstant: 56).isActive = true
        back.widthAnchor.constraint(equalToConstant: 96).isActive = true
        back.backgroundColor = UIColor.black
        back.titleLabel?.textColor = UIColor.white
        back.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        back.layer.cornerRadius = 30
        back.alpha = 0
    

    }
    
    func formatLabels(){
        
        let margins = view.layoutMarginsGuide
        
        boldLabel.text = "Nice to meet you, \(name!)"
        thinLabel.text = "You look like you think about things deeply"
        
        preThinLabel.isHidden = true
   
        stackView.addArrangedSubview(preThinLabel)
        stackView.addArrangedSubview(boldLabel)
        stackView.addArrangedSubview(thinLabel)
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.leading
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate(
            [
                stackView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.25),
                stackView.widthAnchor.constraint(equalTo: margins.widthAnchor, constant: -40),
                stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
                stackView.bottomAnchor.constraint(lessThanOrEqualTo: textInputField.topAnchor, constant: -20)
            ]
        )
        
        boldLabel.translatesAutoresizingMaskIntoConstraints = false
        boldLabel.alpha = 0
        thinLabel.translatesAutoresizingMaskIntoConstraints = false
        thinLabel.alpha = 0
        
        view.addSubview(stackView)

    }
    
    @objc func showMatchedLine(){
        label.text = matchedLine
    }
    
    @objc func restart(_ textField:UIButton ){
//        label.isHidden = true
//        textInputField.text = ""
//        textInputField.placeholder = "What's on your mind?"
//        textInputField.isHidden = false
//        button.isHidden = true
        
      
        UserDefaults.standard.set(false, forKey: "launchedBefore")
        
        let introVC = introViewController()
        introVC.modalPresentationStyle = .fullScreen
        
        self.present(introVC, animated: true, completion: nil)

    }
    
    @objc func tryAgain(_ textField:UIButton ){
        label.isHidden = true
        textInputField.text = ""
        textInputField.placeholder = "Grab a fleeting feeling"
        textInputField.isHidden = false
        buttonStack.isHidden = true
       // share.isHidden = true
        signature.isHidden = true
    }

    @objc func userAnswer(_ textField:UITextField ){
        

        self.view.endEditing(true)
                
        answerAnimate()

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
           // resetTest.isHidden = false
          //  askAgain.isHidden = false
        
//        if launchedBefore {
         //   animate()
  //      }
    }
    
    func answerAnimate(){
        preThinLabel.alpha = 0
        label.alpha = 0
        boldLabel.alpha = 0
        thinLabel.alpha = 0
        
        back.alpha = 0
        share.alpha = 0
        signature.alpha = 0
        
        buttonStack.isHidden = false
        signature.isHidden = false
        
        if seenAnimationsThisTime{
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ){
                self.stackView.isHidden = true
                
                let animator = UIViewPropertyAnimator(duration: 5, curve: .easeOut) {
                    self.label.alpha = 1
                }
                animator.startAnimation()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3) ){
                self.stackView.isHidden = true
                
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.signature.alpha = 1
                }
                animator.startAnimation()
            }
        }
        else {
            preThinLabel.isHidden = false
            
            preThinLabel.text = "Oh ... I think I understand .... "
            
            boldLabel.text = "Can I show you a poem?"
            
            //thinLabel.text = "I wish I could help .. "
            thinLabel.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() ){
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.preThinLabel.alpha = 1
                }
                animator.startAnimation()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ){
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.thinLabel.alpha = 1
                }
                animator.startAnimation()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2) ){
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.boldLabel.alpha = 1
                }
                animator.startAnimation()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5) ){
                self.stackView.isHidden = true
                
                let animator = UIViewPropertyAnimator(duration: 5, curve: .easeOut) {
                    self.label.alpha = 1
                }
                animator.startAnimation()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8) ){
                self.stackView.isHidden = true
                
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.signature.alpha = 1
                }
                animator.startAnimation()
            }
            
            seenAnimationsThisTime = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(15) ){
            self.buttonStack.isHidden = false
            
            let animator = UIViewPropertyAnimator(duration: 5, curve: .easeOut) {
                self.back.alpha = 1
                self.share.alpha = 1
            }
            animator.startAnimation()
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
        
        matchedLine = nearestLineKey
        
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

