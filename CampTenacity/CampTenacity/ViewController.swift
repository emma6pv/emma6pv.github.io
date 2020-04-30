//
//  ViewController.swift
//  CampTenacity
//
//  Created by Emma on 1/24/20.
//  Copyright © 2020 Tenacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //let newVC = CampViewController()
        let newVC = MainTabBar()
        newVC.modalPresentationStyle = .fullScreen
        present(newVC, animated: true, completion: nil)
    }


}

