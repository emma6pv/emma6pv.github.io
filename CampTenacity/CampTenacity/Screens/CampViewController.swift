//
//  CampViewController.swift
//  CampTenacity
//
//  Created by Emma on 1/24/20.
//  Copyright © 2020 Tenacity. All rights reserved.
//

import UIKit

class AchievementModel {
    var achievementImage: UIImage?
    var dateString: String?
    var descriptionString: String?
    
    init(achievementImage: UIImage, dateString: String, descriptionString: String) {
        self.achievementImage = achievementImage
        self.dateString = dateString
        self.descriptionString = descriptionString
    }
}

class CampViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView = UITableView()
    var numberOfAchievements = 0
    let HEIGHT_OF_CELL = CGFloat(200)
    
    var achievements = [AchievementModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        setupAchievements()
        // this will be set according to user's # of achievements
        numberOfAchievements = achievements.count
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupAchievements() {
        // Add achievements to the array. This is a placeholder.
        // later we will need to read this data from the user
        // and populate the array accordingly...
        achievements.append(AchievementModel(achievementImage: UIImage(named: "level2")!, dateString: "18 Jan", descriptionString: "Unlocked an axe!"))
        achievements.append(AchievementModel(achievementImage: UIImage(named: "level3")!, dateString: "14 Jan", descriptionString: "Earned marshmallows!"))
        achievements.append(AchievementModel(achievementImage: UIImage(named: "level1")!, dateString: "20 Dec", descriptionString: "Settled into your campsite."))
    }
    
    func setup() {
        // Add the container view
        scrollView.addSubview(scrollViewContainer)
        
        // Add the subviews
        scrollViewContainer.addArrangedSubview(campsiteImageView)
        scrollViewContainer.addArrangedSubview(borderView)
        scrollViewContainer.addArrangedSubview(titleView)
        
        // Create TableView as a subview
        setupTableView()
        
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
    

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces=false
        scrollView.contentInset = UIEdgeInsets(top: -45, left: 0, bottom: 0, right: 0);
        return scrollView
    }()
    
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let campsiteImageView: UIImageView = {
        let view = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        view.image = UIImage(named: "level3campsite")
        return view
    }()
    
    let borderView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let blueBorder = UIImageView()
        containerView.addSubview(blueBorder)
        blueBorder.translatesAutoresizingMaskIntoConstraints = false
        blueBorder.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        blueBorder.heightAnchor.constraint(equalToConstant: 50).isActive = true
        blueBorder.widthAnchor.constraint(equalToConstant: 415).isActive = true
        blueBorder.image = UIImage(named: "curveGreen")
        
        return containerView
    }()
    
    let titleView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 160).isActive = true
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Campsite Timeline"
        titleLabel.textColor = UIColor(named: "blueColor")
        titleLabel.font = UIFont.header()
        
        titleLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 270).isActive = true
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Track your campsite achievements over time. Each time you hit a milestone, you earn a new campsite item."
        descriptionLabel.textColor = UIColor(named: "secondaryTextColor")
        descriptionLabel.font = UIFont.subtext()
        descriptionLabel.numberOfLines = 3
        descriptionLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 310).isActive = true
        
        return view
    }()
    
    
    func setupTableView() {
        tableView.backgroundColor = .orange
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        let constant = HEIGHT_OF_CELL * CGFloat(numberOfAchievements)
        tableView.heightAnchor.constraint(equalToConstant: constant).isActive = true
        
        scrollViewContainer.addArrangedSubview(tableView)
        tableView.register(TimelineTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfAchievements
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TimelineTableViewCell else {fatalError("Unable to create cell")}

        // populate cells with array data
        cell.achievementImage = achievements[indexPath.row].achievementImage!
        cell.achievementText = achievements[indexPath.row].descriptionString!
        cell.dateText = achievements[indexPath.row].dateString!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HEIGHT_OF_CELL
    }

}
