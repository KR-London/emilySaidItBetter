//
//  settingsViewController.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 31/10/2021.
//

import UIKit
class settingsViewController: myViewController {
    
    var module1 = settingsButtonModule()
    var module2 = settingsButtonModule()
    var module3 = settingsButtonModule()
    var module4 = settingsButtonModule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
   func layout(){
       let moduleStack = UIStackView()
       moduleStack.axis = .vertical
       
       moduleStack.addArrangedSubview(module1)
       moduleStack.addArrangedSubview(module2)
       moduleStack.addArrangedSubview(module3)
       moduleStack.addArrangedSubview(module4)
       
       view.addSubview(moduleStack)
       
//       NSLayoutConstraint.activate([
//        moduleStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -40),
//        moduleStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//        moduleStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -200),
//        moduleStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
//       ])
       
       NSLayoutConstraint.activate([
            moduleStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -40),
            moduleStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            moduleStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -200),
            moduleStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
     }
   }

//class settingsViewController: myViewController {
//
//    var stackView = UIStackView()
//    var creditLabel = myBoldLabel()
//    var emilyButton = UIButton()
//    var gutButton = UIButton()
//
//    var privacyLabel = myThinLabel()
//    var developerWebsite = UIButton()
//    var sendFeedback = UIButton()
//
//    var thanksLabel = myBoldLabel()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        layout()
//        words()
//        // Do any additional setup after loading the view.
//    }
//
//    func layout(){
//
//        view.addSubview(stackView)
//
//        let buttonStack1 = UIStackView()
//        buttonStack1.axis = .horizontal
//
//        buttonStack1.addArrangedSubview(emilyButton)
//        buttonStack1.addArrangedSubview(gutButton)
//        buttonStack1.distribution = .equalSpacing
//
////        emilyButton.widthAnchor.constraint(equalToConstant: 96)
////        gutButton.widthAnchor.constraint(equalToConstant: 96)
////        developerWebsite.widthAnchor.constraint(equalToConstant: 96)
////        sendFeedback.widthAnchor.constraint(equalToConstant: 96)
////
////        emilyButton.backgroundColor = UIColor.lightGray
////        gutButton.backgroundColor = UIColor.lightGray
////
//        let buttonStack2 = UIStackView()
//        buttonStack2.axis = .horizontal
//
//        buttonStack1.distribution = .equalSpacing
//
//        buttonStack2.addArrangedSubview(developerWebsite)
//        buttonStack2.addArrangedSubview(sendFeedback)
//
////        developerWebsite.backgroundColor = UIColor.lightGray
////        sendFeedback.backgroundColor = UIColor.lightGray
//
//        stackView.axis = .vertical
//
//        stackView.addArrangedSubview(creditLabel)
//        stackView.addArrangedSubview(buttonStack1)
//        stackView.addArrangedSubview(privacyLabel)
//        stackView.addArrangedSubview(buttonStack2)
//        stackView.addArrangedSubview(thanksLabel)
//
//        stackView.distribution = .fillProportionally
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
//            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
//        ])
//    }
//
//    func words(){
//        creditLabel.text = "Powered by the words of Emily Dickinson, with thanks to Guttenberg Project for the source text."
//
//        emilyButton.titleLabel?.text = "Emily Dickinson"
//        gutButton.titleLabel?.text = "Guttenberg Project"
//
//        privacyLabel.text = "Your thoughts belong to you. This app does not send any personal information off your device. The AI matching is done locally. It saves name, poems and logon stats on your handset, but not your original words. \n \n  Please click below to learn more about this app, to feedback your impressions and to request new features. "
//
//        developerWebsite.titleLabel?.text = "Homepage"
//        sendFeedback.titleLabel?.text = "Feedback"
//
//        thanksLabel.text = "A gift for Heidi - who heard my words, and gave me so many new ones"
//    }
//
//}
