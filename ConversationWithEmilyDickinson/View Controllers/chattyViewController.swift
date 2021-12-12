//
//  chattyViewController.swift
//  chattyViewController
//
//  Created by Kate Roberts on 19/10/2021.
//
//
//  introViewController.swift
//  introViewController
//
//  Created by Kate Roberts on 19/10/2021.
//

import UIKit

class chattyViewController: myViewController, UITextFieldDelegate {
    
    var mainViewController: ViewController?
    
    lazy var hello: UILabel = {
        let contentView = UILabel()
        contentView.text = "Oh..."
        contentView.font = .titleTwo
        contentView.adjustsFontSizeToFitWidth = true
        return contentView
    }()
    
    lazy var myNameIs: UILabel = {
        let contentView = UILabel()
        contentView.text = ".. I think I understand ... "
        contentView.font = .titleTwo
        return contentView
    }()
    
    
    lazy var whatIsYour: UILabel = {
        let contentView = UILabel()
        contentView.font = .titleOne
        contentView.text = "... can I show you a poem ...?"
        return contentView
    }()
    
    
    lazy var textEntry: myTextField = {
        let contentView = myTextField()
        contentView.placeholder = "Write your name here"
        contentView.textAlignment = .center
        return contentView
    }()
    
    
    lazy var goForwardButton: UIButton = {
        let button = UIButton()
        button.alpha = 0
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
        
            /// fade it in & out with RH picture
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
            let animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut) {
                self.goForwardButton.alpha = 1
            }
            animator.startAnimation()
        }
    }
    
    func layout(){
        let margins = view.layoutMarginsGuide
        
        view.addSubview(hello)
        hello.translatesAutoresizingMaskIntoConstraints = false
        hello.alpha = 0
        NSLayoutConstraint.activate(
            [
                hello.widthAnchor.constraint(equalTo: margins.widthAnchor),
                hello.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                hello.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 78/545)
            ]
        )

        view.addSubview(myNameIs)
        myNameIs.translatesAutoresizingMaskIntoConstraints = false
        myNameIs.alpha = 0
        NSLayoutConstraint.activate(
            [
                myNameIs.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                myNameIs.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 163/545),
                myNameIs.widthAnchor.constraint(equalTo: margins.widthAnchor),
            ]
        )
        
        view.addSubview(whatIsYour)
        whatIsYour.translatesAutoresizingMaskIntoConstraints = false
        whatIsYour.alpha = 0
        NSLayoutConstraint.activate(
            [
                whatIsYour.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
                whatIsYour.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 375/545),
                whatIsYour.widthAnchor.constraint(equalTo: margins.widthAnchor)
            ]
        )
        
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
        
        NSLayoutConstraint.activate(
            [
                hello.topAnchor.constraint(lessThanOrEqualTo: margins.topAnchor, constant:spacer),
                myNameIs.topAnchor.constraint(lessThanOrEqualTo: hello.bottomAnchor, constant:spacer),
                whatIsYour.topAnchor.constraint(lessThanOrEqualTo: myNameIs.bottomAnchor, constant:spacer),
                goForwardButton.topAnchor.constraint(lessThanOrEqualTo: whatIsYour.bottomAnchor, constant:spacer),
                goForwardButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -40)
            ]
        )
    }
    
    func setup(){
        hello.alpha = 0
        myNameIs.alpha = 0
        whatIsYour.alpha = 0
        goForwardButton.alpha = 0
    }
    
    @objc func goOn(sender: UIButton!) {
        mainViewController?.animate()
        self.dismiss(animated: true, completion: nil)
        
        myNameIs.alpha = 0
        whatIsYour.alpha = 0
        goForwardButton.alpha = 0
    
        
        textEntry.alpha = 1
    }
}


