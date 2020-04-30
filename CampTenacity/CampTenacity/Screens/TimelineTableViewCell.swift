//
//  TimelineTableViewCell.swift
//  CampTenacity
//
//  Created by Emma on 1/25/20.
//  Copyright © 2020 Tenacity. All rights reserved.
//

import UIKit

// This class represents a single cell
// in the achievement timeline aka ONE achievement.
// An achievement has an image, date, and description

class TimelineTableViewCell: UITableViewCell {
    
    var containerView = UIView()
    var achievementImage = UIImage()
    var dateText = ""
    var achievementText = ""
    
    let HEIGHT_OF_CELL = CGFloat(200)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
        addSubview(containerView)
    }
    
    func setupView() {
        containerView = UIView(frame: CGRect(x: 25, y: 0, width: self.frame.width - 50, height: HEIGHT_OF_CELL))
 
        // Achievement Photo
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 150, height: HEIGHT_OF_CELL))
        imageView.image = achievementImage
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)
        
        // Achievement Date (ie: "4 Oct")
        let dateLabel = UILabel(frame: CGRect(x: 170, y: 40, width: 150, height: 20))
        dateLabel.text = dateText
        dateLabel.font = UIFont.dateAsTitle()
        dateLabel.textColor = UIColor(named: "orangeColor")
        containerView.addSubview(dateLabel)
        
        // Achievement Description (ie: "You earned a hammock!")
        let achievementDescription =  UILabel(frame: CGRect(x: 170, y: 60, width: 180, height: 20))
        achievementDescription.text = achievementText
        achievementDescription.font = UIFont.smallText()
        achievementDescription.textColor = UIColor(named: "secondaryTextColor")
        
        containerView.addSubview(achievementDescription)
    }

}
