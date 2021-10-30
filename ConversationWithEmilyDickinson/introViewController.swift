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
        contentView.font = UIFont.systemFont(ofSize: 32, weight: .thin)
        return contentView
    }()
    
    lazy var myNameIs: UILabel = {
        let contentView = UILabel()
        contentView.text = "My name is Emily"
        contentView.font = UIFont.boldSystemFont(ofSize: 32.0)
        return contentView
    }()
    
    
    lazy var whatIsYour: UILabel = {
        let contentView = UILabel()
        contentView.text = "What is your name?"
        contentView.font = UIFont.systemFont(ofSize: 32, weight: .thin)
        return contentView
    }()
    
    lazy var textEntry: myTextField = {
        let contentView = myTextField()
        contentView.placeholder = "Write your name here"

        return contentView
    }()

    
    lazy var goForwardButton: UIButton = {
        let button = UIButton()
        button.setTitle("↠", for: .normal)
            //        button.backgroundColor = UIColor(red: 186/255, green: 242/255, blue: 206/255, alpha: 1)
            //
            //        button.titleLabel!.font = UIFont(name: "TwCenMT-CondensedExtraBold", size: 24 )
        button.backgroundColor = .gray
        return button
    }()
    
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
        }
        
            /// fade it in & out with RH picture
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.myNameIs.alpha = 1
            }
            animator.startAnimation()
        }
        
            /// fade it in & out with RH picture
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.whatIsYour.alpha = 1
            }
            animator.startAnimation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.textEntry.alpha = 1
            }
            animator.startAnimation()
        }
        
            /// fade it in & out with RH picture
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
//            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
//                self.goForwardButton.alpha = 1
//            }
//            animator.startAnimation()
//        }
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
        
        NSLayoutConstraint.activate(
             [
                stackView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.25),
                stackView.widthAnchor.constraint(equalTo: margins.widthAnchor, constant: -40),
                stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
                //stackView.centerYAnchor.constraint(lessThanOrEqualTo: margins.centerYAnchor, constant: -100)
             ]
       )
        
    
        
        
        //view.addSubview(hello)
        hello.translatesAutoresizingMaskIntoConstraints = false
        hello.alpha = 0
//        NSLayoutConstraint.activate(
//            [
//                hello.widthAnchor.constraint(equalTo: margins.widthAnchor),
//                hello.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
//                hello.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 78/545)
//            ]
//        )

      //  view.addSubview(myNameIs)
        myNameIs.translatesAutoresizingMaskIntoConstraints = false
        myNameIs.alpha = 0
//        NSLayoutConstraint.activate(
//            [
//                myNameIs.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
//                myNameIs.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 163/545),
//                myNameIs.widthAnchor.constraint(equalTo: margins.widthAnchor),
//            ]
//        )
//
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
        
        textEntry.delegate = self
        textEntry.addTarget(self, action: #selector(userName), for: UIControl.Event.editingDidEndOnExit)
        
        
       // view.addSubview(whatIsYour)
        whatIsYour.translatesAutoresizingMaskIntoConstraints = false
        whatIsYour.alpha = 0
//        NSLayoutConstraint.activate(
//            [
//                whatIsYour.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
//                whatIsYour.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 375/545),
//                whatIsYour.widthAnchor.constraint(equalTo: margins.widthAnchor)
//            ]
//        )
        
        self.view.addSubview(goForwardButton)
        goForwardButton.translatesAutoresizingMaskIntoConstraints = false
        goForwardButton.addTarget(self, action: #selector(goOn), for: .touchUpInside)
        goForwardButton.alpha = 0
        NSLayoutConstraint.activate(
            [
                goForwardButton.bottomAnchor.constraint(lessThanOrEqualTo: margins.bottomAnchor),
                goForwardButton.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.9),
                goForwardButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                goForwardButton.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1/6 )
            ]
        )
        
        var ratio: CGFloat = (375 + 163 + 78 + (self.view.frame.width/6) )
        ratio = ratio/545
        let contentSize = self.view.frame.width*ratio
        let spacer = ( self.view.frame.height - contentSize )/5
        print("spacer 1 = ", spacer)
        
//        NSLayoutConstraint.activate(
//            [
//                hello.topAnchor.constraint(greaterThanOrEqualTo: margins.topAnchor, constant:20),
//                myNameIs.topAnchor.constraint(equalTo: hello.bottomAnchor, constant:10),
//                whatIsYour.topAnchor.constraint(equalTo:  myNameIs.bottomAnchor, constant:10),
//                whatIsYour.bottomAnchor.constraint(lessThanOrEqualTo: textEntry.topAnchor, constant:10),
//                goForwardButton.topAnchor.constraint(lessThanOrEqualTo: whatIsYour.bottomAnchor, constant:spacer),
//                goForwardButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -40)
//            ]
//        )
        
  
       
    }
    
    func setup(){
        hello.alpha = 0
        myNameIs.alpha = 0
        whatIsYour.alpha = 0
        goForwardButton.alpha = 0
    }
    
    @objc func goOn(sender: UIButton!) {
            // performSegue(withIdentifier: "o1-o2", sender: self)
       // performSegue(withIdentifier: "toQuiz", sender: self)
        myNameIs.alpha = 0
        whatIsYour.alpha = 0
        goForwardButton.alpha = 0
        
        if hello.text == "Hello"
        { hello.text = "What is your name?" }
        else {
            
            // hello.text = "What is on your mind?
           // initialise next VC
            
            let nextVC = ViewController()
            nextVC.modalPresentationStyle = .fullScreen
        //  nextVC.YourLabel.text = "Passed Text"
          //  nextVC.YourLabel.text = YourArray[indexPath.row]
            
                // Push to next view
          //  navigationController?.pushViewController(nextVC, animated: true)
            self.present(nextVC, animated: true, completion: nil)
            
        }
       
        textEntry.alpha = 1
        
    }
    
    @objc func userName(_ textField:UITextField ){

     //   if hello.text == "What is your name?"{
            if let text = self.textEntry.text{
            
                hello.alpha = 0
                myNameIs.alpha = 0
                whatIsYour.alpha = 0
                goForwardButton.alpha = 0
                textEntry.alpha = 0
            
                hello.text = "Nice to meet you " + text
                myNameIs.text = "You look a little thoughtful..."
                whatIsYour.text = "Do you mind if ask what is on your mind ...?"
            
            
            
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)){
                    let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                        self.hello.alpha = 1
                    }
                    animator.startAnimation()
                }
            
                /// fade it in & out with RH picture
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                    let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                        self.myNameIs.alpha = 1
                    }
                    animator.startAnimation()
                }
                
                    /// fade it in & out with RH picture
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
                    let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                        self.whatIsYour.alpha = 1
                    }
                    animator.startAnimation()
                }
                
                    /// fade it in & out with RH picture
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
                    let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                        self.goForwardButton.alpha = 1
                    }
                    animator.startAnimation()
                }
            
            }
//        } else {
//
//        }
    }
}
