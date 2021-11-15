//
//  settingsButtonModule.swift
//  ConversationWithEmilyDickinson
//
//  Created by Kate Roberts on 15/11/2021.
//

import UIKit

class settingsButtonModule: UIView {

    var title = UILabel()
    var subtitle = UILabel()
    
    var button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
        layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
        layoutSubviews()
    }
    
//    convenience init() {
//        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//    }
//    
    func didLoad() {
            //Place your initialization code here
        
            //I actually create & place constraints in here, instead of in
            //updateConstraints
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        title.text = "Title"
        subtitle.text = "Subtitle"
        
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.alignment = .leading
        
        verticalStack.addArrangedSubview(title)
        verticalStack.addArrangedSubview(subtitle)
        
        
        
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        
        horizontalStack.addArrangedSubview(verticalStack)
        horizontalStack.addArrangedSubview(button)
        
        addSubview(verticalStack)
        
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
            //Disable this if you are adding constraints manually
            //or you're going to have a 'bad time'
            //self.translatesAutoresizingMaskIntoConstraints = false
        
            //Add custom constraint code here
    }

}
