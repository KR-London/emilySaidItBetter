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
import SwiftUI
import Social
//import CreateML





class ViewController: myViewController, UITextFieldDelegate{
    
    var name : String?
    var emilyVoice = EmilyScript()
    
    var textInputField = myTextField()
    var label = UILabel()
    var back = UIButton()
    var share = UIButton()
    var reset = UIButton()
    var showKeyLine = UIButton()
    var signature = UIImageView()
    
    var settings = UIButton()
  
    var allTheLines = [ (String, [Double]) ]()
    var firstLinesWithPoemWeights = [ (String, [Double]) ]()
    var findThePoem = [String: Verse]()
    var firstLines = [String]()
    
    var matchedLine = String()
    var matchedPoem = String()
    
    var seenAnimationsThisTime = false
    let generatorLight = UIImpactFeedbackGenerator(style: .light)

    let stackView = UIStackView()
    let buttonStack  = UIStackView()
    
    lazy var preThinLabel: UILabel = {
        let contentView = UILabel()
            //  contentView.text = "What is your name?"
        contentView.numberOfLines = 0
        contentView.lineBreakMode = .byWordWrapping
        contentView.font = UIFont.titleTwo
        contentView.adjustsFontSizeToFitWidth = true
        return contentView
    }()
    
    
    lazy var boldLabel: UILabel = {
        let contentView = UILabel()
        //contentView.text = "My name is Emily"
        contentView.numberOfLines = 0
        contentView.lineBreakMode = .byWordWrapping
        contentView.font = UIFont.titleOne
        contentView.adjustsFontSizeToFitWidth = true
        contentView.minimumScaleFactor = 0.6
        return contentView
    }()
    
    
    lazy var thinLabel: UILabel = {
        let contentView = UILabel()
      //  contentView.text = "What is your name?"
        contentView.numberOfLines = 0
        contentView.lineBreakMode = .byWordWrapping
        contentView.font = UIFont.titleTwo
        contentView.adjustsFontSizeToFitWidth = true
        contentView.minimumScaleFactor = 0.6
        return contentView
    }()
    
//    lazy var nextButton: myBlackButton = {
//        let contentView = myBlackButton()
//        contentView.setTitle("Next", for: .normal)
//        contentView.alpha = 0
//        return contentView
//    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        share.alpha = 0
        back.alpha = 0
    
        checkIfNewUser()
        setup()
        layout()
        formatLabels()
        
        textInputField.overlayButton.addTarget(self, action: #selector(userAnswerButtonPressed), for: .touchUpInside)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animate()
    }
    
    func checkIfNewUser(){
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        name = (UserDefaults.standard.object(forKey: "Name") as? String ) ?? "friend"
        
        if launchedBefore{
            //preThinLabel.isHidden = true
            let emilySaid = emilyVoice.openingPhrase()
            boldLabel.text = emilySaid.boldLabel
            //"Hello again, \(name!)"
            thinLabel.text = emilySaid.thinLabel
            textInputField.placeholder = emilySaid.textPlaceholder
            
        }  else
        {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            boldLabel.text = "Nice to meet you, \(name!)"
            thinLabel.text = "You look like you think about things deeply"
            textInputField.placeholder = "Write one word ..."
        }
    }
    
    func animate(){
        DispatchQueue.main.asyncAfter(deadline: .now() ){ [self] in
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.boldLabel.alpha = 1
            }
            animator.startAnimation()
            self.generatorLight.impactOccurred()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.thinLabel.alpha = 1
            }
            animator.startAnimation()
            self.generatorLight.impactOccurred()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2) ){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.textInputField.alpha = 1
            }
            animator.startAnimation()
            self.generatorLight.impactOccurred()
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
        //textInputField.placeholder = "Three words for now"
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
        share.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
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
        
        back.setTitle("Again?", for: .normal)
        back.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        back.heightAnchor.constraint(equalToConstant: 56).isActive = true
        back.widthAnchor.constraint(equalToConstant: 96).isActive = true
        back.backgroundColor = UIColor.black
        back.titleLabel?.textColor = UIColor.white
        back.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        back.layer.cornerRadius = 30
        back.alpha = 0
    
        view.addSubview(settings)
        settings.isHidden = false
        settings.translatesAutoresizingMaskIntoConstraints = false
        settings.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true
        settings.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        settings.heightAnchor.constraint(equalToConstant: 16).isActive = true
        settings.widthAnchor.constraint(equalToConstant: 24).isActive = true
        settings.tintColor = UIColor(named: "gray1")
        settings.alpha = 1
        settings.setBackgroundImage(UIImage(named: "menu"), for: .normal)
        settings.clipsToBounds = true
        settings.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)


//        view.addSubview(nextButton)
//        nextButton.addTarget(self, action: #selector(userAnswerButtonPressed), for: .touchUpInside)
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate(
//            [
//                nextButton.topAnchor.constraint(equalTo: textInputField.bottomAnchor, constant: 24),
//                nextButton.centerXAnchor.constraint(equalTo:  margins.centerXAnchor)
//            ]
//        )
        

    }
    
    func formatLabels(){
        
        let margins = view.layoutMarginsGuide
        
        preThinLabel.isHidden = true
   
        stackView.addArrangedSubview(preThinLabel)
        stackView.addArrangedSubview(boldLabel)
        stackView.addArrangedSubview(thinLabel)
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.leading
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        if UIScreen.main.bounds.height > 850{
        NSLayoutConstraint.activate(
            [
                stackView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.2),
                stackView.widthAnchor.constraint(equalTo: margins.widthAnchor, constant: -40),
                stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
                stackView.bottomAnchor.constraint(lessThanOrEqualTo: textInputField.topAnchor, constant: -20)
            ]
        )
        } else {
            NSLayoutConstraint.activate(
                [
                    stackView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.3),
                    stackView.widthAnchor.constraint(equalTo: margins.widthAnchor, constant: -40),
                    stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
                    stackView.bottomAnchor.constraint(lessThanOrEqualTo: textInputField.topAnchor, constant: -20)
                ]
            )
        }
        
        boldLabel.translatesAutoresizingMaskIntoConstraints = false
        boldLabel.alpha = 0
        thinLabel.translatesAutoresizingMaskIntoConstraints = false
        thinLabel.alpha = 0
        
        view.addSubview(stackView)

    }
    

    @objc func settingsButtonPressed(){
        
        let vc = UIHostingController(rootView: SettingsView())
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

    @objc func shareButtonPressed(){
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
       
        let shareImage = textToImage(drawText: matchedPoem, inImage: UIImage(named: "shareBackground")!)
        
       // let ac = UIActivityViewController(activityItems: [matchedPoem], applicationActivities: nil)
        let ac = UIActivityViewController(activityItems: [shareImage, "#EmilySaidItBetter - download from the App Store now and find your perfect personalised #EmilyDickinson #poem!"], applicationActivities: nil)
        present(ac, animated: true)
        
//        if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
//            vc.setInitialText("Look at this great picture!")
//            vc.add(UIImage(named: "myImage.jpg")!)
//            vc.add(URL(string: "https://www.hackingwithswift.com"))
//            present(vc, animated: true)
//        }
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
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
      
        UserDefaults.standard.removeObject(forKey: "launchedBefore")
        UserDefaults.standard.removeObject(forKey: "lastLoginDate")
        UserDefaults.standard.removeObject(forKey: "LoginCount")
        
        let introVC = introViewController()
        introVC.modalPresentationStyle = .fullScreen
        
        self.present(introVC, animated: true, completion: nil)

    }
    
    @objc func tryAgain(_ textField:UIButton ){
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        
        label.isHidden = true
        buttonStack.isHidden = true
        settings.isHidden = false
        settings.alpha = 1
        textInputField.text = ""
        textInputField.placeholder = emilyVoice.tryAgain()
        textInputField.isHidden = false
       
       // share.isHidden = true
        signature.isHidden = true
    }
    
    @objc func userAnswerButtonPressed(){
      //  nextButton.isHidden = true
        buttonStack.isHidden = true
        self.view.endEditing(true)
            //        let generatorSuccess = UINotificationFeedbackGenerator()
            //        generatorSuccess.notificationOccurred(.success)
        generatorLight.impactOccurred()
       
        
        var closestEmilyDickinsonLine = ""
        if let text = self.textInputField.text{
            if let closestline = self.answerKeyCustom(for: text){
                closestEmilyDickinsonLine = closestline
            }
        }
        answerAnimate()
        textInputField.isHidden = true
        self.label.isHidden = false
      
        let poem = findThePoem[closestEmilyDickinsonLine] ?? poemCollection.randomElement()
        matchedPoem = ""
        
        for lines in poem!.lines{
            matchedPoem.append(contentsOf: lines)
            matchedPoem.append("\n")
        }
        
        self.label.text = matchedPoem
       // nextButton.alpha = 0
            // resetTest.isHidden = false
            //  askAgain.isHidden = false
        
            //        if launchedBefore {
            //   animate()
            //      }
    }

    @objc func userAnswer(_ textField: myTextField ){
//        nextButton.isHidden = true
//        nextButton.alpha = 0
        buttonStack.isHidden = true
        self.view.endEditing(true)
//        let generatorSuccess = UINotificationFeedbackGenerator()
//        generatorSuccess.notificationOccurred(.success)
        generatorLight.impactOccurred()
      

        var closestEmilyDickinsonLine = ""
            if let text = self.textInputField.text{
                if let closestline = self.answerKeyCustom(for: text){
                    closestEmilyDickinsonLine = closestline
                }
            }
            
            textField.isHidden = true
            self.label.isHidden = false
            
            let poem = findThePoem[closestEmilyDickinsonLine]
       
            matchedPoem = ""
            
            for lines in poem!.lines{
                matchedPoem.append(contentsOf: lines)
                matchedPoem.append("\n")
            }
            answerAnimate()
            self.label.text = matchedPoem
           // resetTest.isHidden = false
          //  askAgain.isHidden = false
    }

    func answerAnimate(){
        preThinLabel.alpha = 0
        label.alpha = 0
        boldLabel.alpha = 0
        thinLabel.alpha = 0
        
        back.alpha = 0
        share.alpha = 0
        signature.alpha = 0
        signature.isHidden = false
        settings.isHidden = true
        
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
            
            let emilySaid = emilyVoice.intermezzoPhrase()
            preThinLabel.text = emilySaid.thinLabel
            boldLabel.text = emilySaid.boldLabel
            thinLabel.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() ){ [self] in
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.preThinLabel.alpha = 1
                }
                animator.startAnimation()
                self.generatorLight.impactOccurred()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ){
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.thinLabel.alpha = 1
                }
                animator.startAnimation()
                self.generatorLight.impactOccurred()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2) ){
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.boldLabel.alpha = 1
                }
                animator.startAnimation()
                self.generatorLight.impactOccurred()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5) ){
                self.stackView.isHidden = true
                
                let animator = UIViewPropertyAnimator(duration: 5, curve: .easeOut) {
                    self.label.alpha = 1
                }
                animator.startAnimation()
                let generatorHeavy = UIImpactFeedbackGenerator(style: .heavy)
                generatorHeavy.impactOccurred()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8) ){
                self.stackView.isHidden = true
                
                let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                    self.signature.alpha = 1
                }
                animator.startAnimation()
                self.generatorLight.impactOccurred()
            }
            
            seenAnimationsThisTime = true
        }
      
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10) ){
            
            self.buttonStack.isHidden = false
            self.settings.isHidden = true
            
            let animator = UIViewPropertyAnimator(duration: 5, curve: .easeOut) {
                self.back.alpha = 1
                self.share.alpha = 1
            }
            animator.startAnimation()
            self.generatorLight.impactOccurred()
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
        
        let matchedVerse = self.findThePoem[ nearestLineKey ]
        return matchedVerse?.lines.first
        
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
        
        print("Number of verses = \(poemCollection.count)")
        
        for poem in poemCollection{
            for line in poem.lines{
                findThePoem[line] = poem
            }
        }
    }
    
    func textToImage(drawText text: String, inImage image: UIImage) -> UIImage {
        let textColor = UIColor(named: "gray1")
        let textFont = UIFont.systemFont(ofSize: 14, weight: .thin)
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        var rect = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
        rect = rect.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 10))
        text.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension ViewController : UIActivityItemSource  {
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        if activityType == .postToTwitter {
            return "#EmilySaidItBetter - download from the App Store now and find your perfect personalised #EmilyDickinson #poem!"
        } else {
            return "#EmilySaidItBetter - download from the App Store now and find your perfect personalised #EmilyDickinson #poem!"
        }
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return  "#EmilySaidItBetter - download from the App Store now and find your perfect personalised #EmilyDickinson #poem!"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "Emily said it better"
    }
}

