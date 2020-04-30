//
//  MainTabBar.swift
//  CampTenacity
//
//  Created by Emma on 2/1/20.
//  Copyright © 2020 Tenacity. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {

    private let homeVC = HomeViewController()
    private let statsVC = StatsViewController()
    private let actionVC = ActionViewController()
    private let campVC = CampViewController()
    private let accountVC = AccountViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor(named: "blueColor")
        setTabBarFont()
        createButton()
        
        viewControllers = [
            createController(title: "Home", imageName: "home-deselected", vc: homeVC),
            createController(title: "Stats", imageName: "stats-deselected", vc: statsVC),
            createController(title: "", imageName: "", vc: actionVC),
            createController(title: "Camp", imageName: "camp-deselected", vc: campVC),
            createController(title: "Account", imageName: "user-deselected", vc: accountVC)
        ]

        
    }
    
    private func createButton() {
        let button = UIButton(type: .custom)
        var buttonMargin = 26
        var buttonWidth = 60.0
        
        if isLargeModel() {
            buttonMargin = 85
            buttonWidth = 70.0
        }
        
        button.frame = CGRect(x: 0.0, y: 0.0, width: buttonWidth, height: buttonWidth)
        button.setBackgroundImage(UIImage(named: "log-deselected"), for: .normal)
        button.setBackgroundImage(UIImage(named: "log-selected"), for: .highlighted)
        let heightDifference: CGFloat = CGFloat(buttonMargin)
        if heightDifference < 0 {
            button.center = tabBar.center
        } else {
            var center: CGPoint = tabBar.center
            center.y = center.y - heightDifference / 2.0
            button.center = center
        }
        
        button.addTarget(self, action: #selector(buttonClicked), for:.touchUpInside)
        view.addSubview(button)
    }
    
    @objc func buttonClicked(sender : UIButton){
        print("button clicked")
        //let vc =  ActionViewController()
        //vc.modalPresentationStyle = .overFullScreen
        //self.present(vc, animated: true, completion: nil)
    }
    
    // saves lots of time, reconfigures everything
    private func createController(title: String, imageName: String, vc: UIViewController) -> UINavigationController {
        let recentVC = UINavigationController(rootViewController: vc)
        recentVC.tabBarItem.title = title
        recentVC.tabBarItem.image = UIImage(named: imageName)
        return recentVC
    }

    private func setTabBarFont() {
        var fontSize = CGFloat(12)
        if isLargeModel() {
            fontSize = CGFloat(14)
        }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Quicksand-SemiBold", size: fontSize)!], for: .normal)
    }
    
    private func isLargeModel() -> Bool {
        let deviceGuru = DeviceGuru()
        let model = deviceGuru.hardwareNumber()
        
        //large, iPhone 11
        if (model == 12.5 || model == 12.1 || model == 12.3) {
            return true
        }
        return false
    }

}
