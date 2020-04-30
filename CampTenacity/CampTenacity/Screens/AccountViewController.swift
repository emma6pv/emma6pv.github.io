//
//  AccountViewController.swift
//  CampTenacity
//
//  Created by Emma on 2/1/20.
//  Copyright © 2020 Tenacity. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    //Segment for mood and cycle history toggle buttons
    lazy var toggleBar : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Growth", "Settings"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.frame.size.height = 50.0
        sc.addTarget (self, action: #selector (handleSegmentChanges),
                       for: .valueChanged)
        return sc
     }()
    

    //Hangles the toggle button to change
    //UI when you select it
    @objc fileprivate func handleSegmentChanges() {
        if toggleBar.selectedSegmentIndex == 0 {
            statsDescription.isHidden = false
            statsOverview.isHidden = false
            SettingsPlaceholderView.isHidden = true
        }
        else {
            statsDescription.isHidden = true
            statsOverview.isHidden = true
            SettingsPlaceholderView.isHidden = false
        }
        toggleBar.changeUnderlinePosition()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        setup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setup() {
        // Add the container view
        scrollView.addSubview(scrollViewContainer)
        
        // * IMPORTANT this is the function that setups the Pink View
        // Add the subviews
        scrollViewContainer.addArrangedSubview(accountTitleView)
        scrollViewContainer.addArrangedSubview(profileView)
        scrollViewContainer.addArrangedSubview(toggleBar)
        toggleBar.addUnderlineForSelectedSegment(multiplier: 3.0)
        
        scrollViewContainer.addArrangedSubview(statsDescription)
        scrollViewContainer.addArrangedSubview(statsOverview)
        scrollViewContainer.addArrangedSubview(SettingsPlaceholderView)
        SettingsPlaceholderView.isHidden = true
        
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
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let accountTitleView: UIView = {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: 110).isActive = true
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "My Account"
        titleLabel.textColor = UIColor(named: "blueColor")
        titleLabel.font = UIFont.header()
        titleLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 270).isActive = true
        
        return view
    }()

    let profileView: UIView = {
        let containerView = UIView()
        containerView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        // Profile Photo
        let imageView = UIImageView(frame: CGRect(x: 30, y: 15, width: 90, height: 90))
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)
        
        
        // Account Name
        let accountName = UILabel(frame: CGRect(x: 140, y: 40, width: 150, height: 20))
        accountName.text = "Janet"
        accountName.font = UIFont.subheader()
        accountName.textColor = UIColor(named: "blueColor")
        containerView.addSubview(accountName)
        
        // Upload image
        let uploadText = UILabel(frame: CGRect(x: 140, y: 67, width: 120, height: 20))
        uploadText.text = "Update image"
        uploadText.font = UIFont.updateImageText()
        uploadText.textColor = .systemBlue
        containerView.addSubview(uploadText)
        
        return containerView
    }()
    
    //settings
    let SettingsPlaceholderView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 340).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.image = UIImage(named: "settingsPhoto") // placeholder
        return imageView
    }()
    
    let statsDescription: UIView = {
        let view = UIView()
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        view.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        // Text
        let textLabel = UILabel(frame: CGRect(x: 40, y: 15, width: (screenWidth*0.85), height: 90))
        textLabel.text = "Since you started your Camp Tenacity Journey, you've achieved the following:"
        textLabel.textColor = UIColor(named: "secondaryTextColor")
        textLabel.font = UIFont.subtext()
        textLabel.numberOfLines = 3
        view.addSubview(textLabel)
        
        return view
    }()
    
    let statsOverview: UIView = {
        let view = UIView()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        view.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        // STAT 1
        let stat1 = UILabel(frame: CGRect(x: 40, y: 15, width: (screenWidth*0.75), height: 90))
        stat1.text = "201"
        stat1.textColor = UIColor(named: "secondaryTextColor")
        stat1.font = UIFont.largeStatText()
        view.addSubview(stat1)
        let stat1Label = UILabel(frame: CGRect(x: 40, y: 65, width: (screenWidth*0.75), height: 90))
        stat1Label.text = "mindful breathing minutes"
        stat1Label.textColor = UIColor(named: "secondaryTextColor")
        stat1Label.font = UIFont.subtext()
        view.addSubview(stat1Label)
        
        
        // STAT 2
        let stat2 = UILabel(frame: CGRect(x: 40, y: 140, width: (screenWidth*0.75), height: 90))
        stat2.text = "3"
        stat2.textColor = UIColor(named: "secondaryTextColor")
        stat2.font = UIFont.largeStatText()
        view.addSubview(stat2)
        let stat2Label = UILabel(frame: CGRect(x: 40, y: 190, width: (screenWidth*0.75), height: 90))
        stat2Label.text = "new campsite items"
        stat2Label.textColor = UIColor(named: "secondaryTextColor")
        stat2Label.font = UIFont.subtext()
        view.addSubview(stat2Label)
        
        
        // STAT 3
        let stat3 = UILabel(frame: CGRect(x: 40, y: 265, width: (screenWidth*0.75), height: 90))
        stat3.text = "20%"
        stat3.textColor = UIColor(named: "secondaryTextColor")
        stat3.font = UIFont.largeStatText()
        view.addSubview(stat3)
        let stat3Label = UILabel(frame: CGRect(x: 40, y: 315, width: (screenWidth*0.75), height: 90))
        stat3Label.text = "reduction in negative/stressed mood"
        stat3Label.textColor = UIColor(named: "secondaryTextColor")
        stat3Label.font = UIFont.subtext()
        view.addSubview(stat3Label)
        
        return view
    }()
}
