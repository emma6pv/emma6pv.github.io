//
//  StatsViewController.swift
//  CampTenacity
//
//  Created by Emma on 2/1/20.
//  Copyright © 2020 Tenacity. All rights reserved.
//
import UIKit



class StatsViewController: UIViewController {
    //MOOD VIEW
    let weekSelected = UIImageView()
    let moodView = UIImageView()
    var statsView = StatisticsView()
    var progressView = CircularProgressBar()
    var statsButtonView = UIView()
    var containerView = UIView()
    var tabBarCtrl = UITabBarController()
    
    //Segment for mood and cycle history toggle buttons
    lazy var toggleBar : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Mood Tracker", "Cycles History"])
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
            moodView.isHidden = false
            statsView.isHidden = true
        }
        else {
            moodView.isHidden = true
            statsView.isHidden = false
        }
        toggleBar.changeUnderlinePosition()
    }
    
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
        setupStatsButton()
    
        // * IMPORTANT this is the function that setups the Pink View
        // Add the subviews
        scrollViewContainer.addArrangedSubview(statsTitleView)
        
        
        scrollViewContainer.addArrangedSubview(toggleBar)
        toggleBar.addUnderlineForSelectedSegment(multiplier: 1.75)
        
        // create some container view that has togglebar as subview
        // putt that container view here
        scrollViewContainer.addArrangedSubview(userStatsViewContainer)
        userStatsViewContainer.addArrangedSubview(weekSelected)
        userStatsViewContainer.addArrangedSubview(moodView)
        userStatsViewContainer.addArrangedSubview(statsView)
        statsView.isHidden = true
        
        weekSelected.topAnchor.constraint(equalTo: userStatsViewContainer.topAnchor).isActive = true
        weekSelected.leftAnchor.constraint(equalTo: userStatsViewContainer.leftAnchor, constant: -15).isActive = true
        weekSelected.image = UIImage(named: "weekSelected")
        weekSelected.translatesAutoresizingMaskIntoConstraints = false
        
        moodView.translatesAutoresizingMaskIntoConstraints = false
        
        moodView.leftAnchor.constraint(equalTo: userStatsViewContainer.leftAnchor, constant: 30).isActive = true
        moodView.rightAnchor.constraint(equalTo: userStatsViewContainer.rightAnchor, constant: -30).isActive = true
        moodView.heightAnchor.constraint(equalToConstant: 310).isActive = true
        moodView.widthAnchor.constraint(equalToConstant: 340).isActive = true
        moodView.image = UIImage(named: "moodChart")
        
        statsView.centerXAnchor.constraint(equalTo: userStatsViewContainer.centerXAnchor).isActive = true
        statsView.leftAnchor.constraint(equalTo: userStatsViewContainer.leftAnchor, constant: 35).isActive = true
        
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
    let userStatsViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let statsTitleView: UIView = {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: 110).isActive = true
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "My Stats"
        titleLabel.textColor = UIColor(named: "blueColor")
        titleLabel.font = UIFont.header()
        titleLabel.adjustsFontSizeToFitWidth = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 270).isActive = true
        
        return view
    }()
    

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

extension UISegmentedControl{
    func removeBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)

        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.dateAsTitle()], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "orangeColor")!, NSAttributedString.Key.font: UIFont.dateAsTitle()], for: .selected)
    }

    func addUnderlineForSelectedSegment(multiplier: CGFloat){
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments) * multiplier
        let underlineHeight: CGFloat = 5.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 4.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor(named: "orangeColor")!
        underline.tag = 1
        self.addSubview(underline)
    }

    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}

extension UIImage{

    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}

