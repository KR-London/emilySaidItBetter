//
//  introViewController.swift
//  introViewController
//
//  Created by Kate Roberts on 19/10/2021.
//

import UIKit

class introViewController: myViewController, UITextFieldDelegate {
    
    lazy var hello: UILabel = {
        let contentView = UILabel()
        contentView.text = "Hello!"
        contentView.adjustsFontSizeToFitWidth = true
        contentView.numberOfLines = 0
        contentView.lineBreakMode = .byWordWrapping
        contentView.font = UIFont.titleTwo
        return contentView
    }()
    
    lazy var myNameIs: UILabel = {
        let contentView = UILabel()
        contentView.text = "My name is Emily"
        contentView.numberOfLines = 0
        contentView.lineBreakMode = .byWordWrapping
        contentView.font = UIFont.titleTwo
        return contentView
    }()
    
    
    lazy var whatIsYour: UILabel = {
        let contentView = UILabel()
        contentView.text = "What is your name?"
        contentView.numberOfLines = 0
        contentView.lineBreakMode = .byWordWrapping
        contentView.font = UIFont.titleOne
        return contentView
    }()
    
    lazy var textEntry: myTextField = {
        let contentView = myTextField()
        contentView.placeholder = "Write your name here ..."
       // contentView.alpha = 1
       // contentView.backgroundColor = .white
        return contentView
    }()
    
    lazy var nextButton: myBlackButton = {
        let contentView = myBlackButton()
        contentView.setTitle("Next", for: .normal)
        contentView.alpha = 0
        return contentView
    }()
    
    let generator = UIImpactFeedbackGenerator(style: .light)

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     
        
        view.backgroundColor = UIColor(red: 224, green: 250, blue: 233, alpha: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.hello.alpha = 1
                
            }
            animator.startAnimation()
            self.generator.impactOccurred()
        }
        
            /// fade it in & out with RH picture
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.myNameIs.alpha = 1
            }
            animator.startAnimation()
            self.generator.impactOccurred()
        }
        
            /// fade it in & out with RH picture
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.whatIsYour.alpha = 1
            }
            animator.startAnimation()
            self.generator.impactOccurred()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.textEntry.alpha = 1
            }
            animator.startAnimation()
            self.generator.impactOccurred()
        }
    
    }
    
    func layout(){
        let margins = view.layoutMarginsGuide
        
        let stackView = UIStackView()
        
        stackView.addArrangedSubview(hello)
        stackView.addArrangedSubview(myNameIs)
        stackView.addArrangedSubview(whatIsYour)
        
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
                ]
            )
        } else{
            NSLayoutConstraint.activate(
                [
                    stackView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.3),
                    stackView.widthAnchor.constraint(equalTo: margins.widthAnchor, constant: -40),
                    stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
                ]
            )
        }

        hello.translatesAutoresizingMaskIntoConstraints = false
        hello.alpha = 0
        myNameIs.translatesAutoresizingMaskIntoConstraints = false
        myNameIs.alpha = 0
        whatIsYour.translatesAutoresizingMaskIntoConstraints = false
        whatIsYour.alpha = 0

        view.addSubview( textEntry)
        textEntry.translatesAutoresizingMaskIntoConstraints = false
        textEntry.alpha = 0
        NSLayoutConstraint.activate(
            [
                textEntry.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                textEntry.heightAnchor.constraint(equalToConstant: 64),
              //  textEntry.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 163/545),
                textEntry.widthAnchor.constraint(equalTo: margins.widthAnchor, constant: -40),
                textEntry.centerYAnchor.constraint(equalTo:  margins.centerYAnchor),
                stackView.bottomAnchor.constraint(lessThanOrEqualTo: textEntry.topAnchor, constant: -40)
            ]
        )
        
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextScreen), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                nextButton.topAnchor.constraint(equalTo: textEntry.bottomAnchor, constant: 24),
                nextButton.centerXAnchor.constraint(equalTo:  margins.centerXAnchor)
            ]
        )
        
        textEntry.delegate = self
        textEntry.addTarget(self, action: #selector(userName), for: UIControl.Event.editingDidEndOnExit)
        
        
       // view.addSubview(whatIsYour)
        whatIsYour.translatesAutoresizingMaskIntoConstraints = false
        whatIsYour.alpha = 0
        
      //  var ratio: CGFloat = (375 + 163 + 78 + (self.view.frame.width/6) )
      //  ratio = ratio/545
       // let contentSize = self.view.frame.width*ratio
       // let spacer = ( self.view.frame.height - contentSize )/5
       
    }
    
    func setup(){
        hello.alpha = 0
        myNameIs.alpha = 0
        whatIsYour.alpha = 0
    }
    
    @objc func nextScreen(){
        print("tapped")
        if let text = self.textEntry.text{
            generator.impactOccurred()
            
            UserDefaults.standard.set(text.capitalized, forKey: "Name")
            
            let nextVC = ViewController()
            
            nextVC.name = text
            
            nextVC.modalPresentationStyle = .fullScreen
            nextButton.alpha = 0
            self.present(nextVC, animated: false, completion: nil)
            
        }
    }
    
    @objc func userName(_ textField: myTextField ){

            if let text = self.textEntry.text{
//                let generatorSuccess = UINotificationFeedbackGenerator()
//                generatorSuccess.notificationOccurred(.success)
                generator.impactOccurred()
                
               // var name = text.capitalized
                
                UserDefaults.standard.set(text.capitalized, forKey: "Name")
                
                let nextVC = ViewController()
                
                nextVC.name = text.capitalized
                nextButton.alpha = 0 
                nextVC.modalPresentationStyle = .fullScreen
                self.present(nextVC, animated: false, completion: nil)
            
            }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
            let animator = UIViewPropertyAnimator(duration: 5, curve: .easeOut) {
                self.nextButton.alpha = 1
                
            }
            animator.startAnimation()
        }
    }
    
}
