//
//  myViewController.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 30/10/2021.
//

import UIKit

class myViewController: UIViewController {

    
    
    var background: UIImageView!
    
    init(imageName: String) {
        
        self.background = UIImageView(image: UIImage(named: "emilyBackground"))
        super.init(nibName: nil, bundle: nil)
        self.background.frame = self.view.frame
        
    }
    
    convenience init() {
        
        let imageName = "background.jpg"
        self.init(imageName: imageName)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(background)
        
    }
    
//    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
//        if activityType == .postToTwitter {
//            return "#EmilySaidItBetter - download from the App Store now and find your perfect personalised #EmilyDickinson #poem!"
//        } else {
//            return "#EmilySaidItBetter - download from the App Store now and find your perfect personalised #EmilyDickinson #poem!"
//        }
//    }
//    
//    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
//        return  "#EmilySaidItBetter - download from the App Store now and find your perfect personalised #EmilyDickinson #poem!"
//    }
//    
//    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
//        return "Emily said it better"
//    }
}
