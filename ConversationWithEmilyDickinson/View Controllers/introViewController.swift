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
                textEntry.widthAnchor.constraint(equalTo: margins.widthAnchor, constant: -40),
                textEntry.centerYAnchor.constraint(equalTo:  margins.centerYAnchor),
                stackView.bottomAnchor.constraint(lessThanOrEqualTo: textEntry.topAnchor, constant: -40)
            ]
        )
        
        textEntry.delegate = self
        textEntry.addTarget(self, action: #selector(userName), for: UIControl.Event.editingDidEndOnExit)

        whatIsYour.translatesAutoresizingMaskIntoConstraints = false
        whatIsYour.alpha = 0
    }
    
    func setup(){
        hello.alpha = 0
        myNameIs.alpha = 0
        whatIsYour.alpha = 0
        textEntry.overlayButton.addTarget(self, action: #selector(nextScreen), for: .touchUpInside)
    }
    
    @objc func nextScreen(){
        if let text = self.textEntry.text{
            generator.impactOccurred()
            
            UserDefaults.standard.set(text.capitalized, forKey: "Name")
            
            let nextVC = ViewController()
            
            nextVC.name = text
            
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: false, completion: nil)
            
        }
    }
    
    @objc func userName(_ textField: myTextField ){

            if let text = self.textEntry.text{
//                let generatorSuccess = UINotificationFeedbackGenerator()
//                generatorSuccess.notificationOccurred(.success)
                generator.impactOccurred()
 
                UserDefaults.standard.set(text.capitalized, forKey: "Name")
                
                let nextVC = ViewController()
                
                nextVC.name = text.capitalized
                nextVC.modalPresentationStyle = .fullScreen
                self.present(nextVC, animated: false, completion: nil)
            
            }
    }
}
