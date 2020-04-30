//
//  HomeViewController.swift
//  CampTenacity
//
//  Created by Emma on 2/1/20.
//  Copyright © 2020 Tenacity. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var progressView = CircularProgressBar()
    var campsiteView = UIView()
    var statsButtonView = UIView()
    var tabBarCtrl = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarCtrl = self.tabBarController!
        view.backgroundColor = .white
        view.addSubview(scrollView)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
  
    func setup() {
        // Add the container view
        scrollView.addSubview(scrollViewContainer)
        
        // Helper setup functions
        setupCampView()
        setupStatsButton()
    
        // * IMPORTANT this is the function that setups the Pink View
        // Add the subviews
        scrollViewContainer.addArrangedSubview(campsiteTitleView)
        scrollViewContainer.addArrangedSubview(borderView)
        scrollViewContainer.addArrangedSubview(campsiteView)
        scrollViewContainer.addArrangedSubview(progressTitleView)
        
        // * IMPORTANT this is the function that setups the progess view
        // Add the progress view
        scrollViewContainer.addArrangedSubview(progressView)
        
        // Add the stats button
        scrollViewContainer.addArrangedSubview(statsButtonView)
        
        // IGNORE this code
        // Setup Constraints for Scrolling
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    

    // IGNORE this code
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces=false
        scrollView.contentInset = UIEdgeInsets(top: -45, left: 0, bottom: 0, right: 0);
        return scrollView
    }()
    
    // IGNORE this code
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        //view.spacing = 10
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // * IMPORTANT this is the pink view that sits at the top of the screen
    let pinkView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.backgroundColor = .systemPink
        
        return view
    }()
    
    let campsiteTitleView: UIView = {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "My Campsite"
        titleLabel.textColor = UIColor(named: "blueColor")
        titleLabel.font = UIFont.header()
        titleLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 270).isActive = true
        
        return view
    }()
    
    let borderView: UIView = {
        let containerView = UIView()
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let blueBorder = UIImageView()
        containerView.addSubview(blueBorder)
        blueBorder.translatesAutoresizingMaskIntoConstraints = false
        blueBorder.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        blueBorder.heightAnchor.constraint(equalToConstant: 50).isActive = true
        blueBorder.widthAnchor.constraint(equalToConstant: 415).isActive = true
        blueBorder.image = UIImage(named: "curveBlue")
        
        return containerView
    }()
    
    func setupCampView() {
        campsiteView.heightAnchor.constraint(equalToConstant: 453).isActive = true
        campsiteView.backgroundColor = .white
        
        let campImageView = UIImageView()
        campsiteView.addSubview(campImageView)
        campImageView.translatesAutoresizingMaskIntoConstraints = false
        campImageView.topAnchor.constraint(equalTo: campsiteView.topAnchor).isActive = true
        campImageView.heightAnchor.constraint(equalToConstant: 425).isActive = true
        campImageView.widthAnchor.constraint(equalToConstant: 415).isActive = true
        campImageView.image = UIImage(named: "level3campsite")
        
        
        let campsiteButton = OrangeButton(buttonText: "View Campsite Details", tabBarController: self.tabBarCtrl, navType: buttonNavigationType.toCampsite)
        
        campsiteView.addSubview(campsiteButton)
        campsiteButton.translatesAutoresizingMaskIntoConstraints = false
        campsiteButton.topAnchor.constraint(equalTo: campImageView.bottomAnchor, constant: -28).isActive = true
        campsiteButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        campsiteButton.widthAnchor.constraint(equalToConstant: 305).isActive = true
        campsiteButton.centerXAnchor.constraint(equalTo: campsiteView.centerXAnchor).isActive = true
    }

    let campsiteImageView: UIImageView = {
        let view = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        view.image = UIImage(named: "level3campsite")
        return view
    }()
    
    let progressTitleView: UIView = {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Today's Progress"
        titleLabel.textColor = UIColor(named: "blueColor")
        titleLabel.font = UIFont.header()
        titleLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 270).isActive = true
        
        return view
    }()
    
    func setupStatsButton() {
        statsButtonView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        statsButtonView.backgroundColor = .white
        
        let button = OrangeButton(buttonText: "View More Stats", tabBarController: self.tabBarCtrl, navType: buttonNavigationType.toStats)

        statsButtonView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.widthAnchor.constraint(equalToConstant: 305).isActive = true
        button.centerXAnchor.constraint(equalTo: statsButtonView.centerXAnchor).isActive = true

    }
}
