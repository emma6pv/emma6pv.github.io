//
//  OrangeButton.swift
//  CampTenacity
//
//  Created by Emma on 2/15/20.
//  Copyright © 2020 Tenacity. All rights reserved.
//

import UIKit

enum buttonNavigationType {
    case toCampsite
    case toStats
    case toMood
}

class OrangeButton: UIButton {
    
    var buttonText: String
    var tbController: UITabBarController
    var navType: buttonNavigationType
    
    required init(buttonText: String="", tabBarController: UITabBarController, navType: buttonNavigationType) {
        self.buttonText = buttonText
        self.tbController = tabBarController
        self.navType = navType
        
        super.init(frame: .zero)
        configeBtn()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.setTitleColor(.white, for: .normal)
        self.setTitle(self.buttonText, for: .normal)
        
        self.backgroundColor      = UIColor(named: "orangeColor")
        self.titleLabel?.font     = UIFont.buttonText()
        self.layer.cornerRadius   = 30
    }
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.systemOrange : UIColor(named: "orangeColor")
        }
    }
    
    func configeBtn() {
        self.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
    }

    @objc func btnClicked(_ sender:UIButton) {
        print("orange button clicked")
        
        if self.navType == buttonNavigationType.toCampsite {
            self.tbController.selectedIndex = 3
        }
        else if self.navType == buttonNavigationType.toStats {
            self.tbController.selectedIndex = 1
        }
        else if self.navType == buttonNavigationType.toMood {
            print("mood functionality")
        }
    }

}
