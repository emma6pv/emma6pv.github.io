//
//  CircularProgressBar.swift
//  CampTenacity
//
//  Created by Emma on 2/4/20.
//  Copyright © 2020 Tenacity. All rights reserved.
//
import UIKit


class CircularProgressBar: UIView {
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    //common func to init our view
    private func setupView() {
        //backgroundColor = .red
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let heightOfView = CGFloat(300)
        
        let center = CGPoint(x: screenWidth / 2,
                             y: self.frame.size.height + (heightOfView/2))
        print("Center point:")
        print(center)
        
       
        self.heightAnchor.constraint(equalToConstant: heightOfView).isActive = true
        self.backgroundColor = .white
        
        
          
        // The following code is based off of this tutorial
        // https://www.youtube.com/watch?v=O3ltwjDJaMk
        let shapeLayer = CAShapeLayer()
        
        // create my track layer
        let trackLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor(red:0.69, green:0.87, blue:0.84, alpha:1.0).cgColor
        trackLayer.lineWidth = 25
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        self.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor(red:0.00, green:0.57, blue:0.47, alpha:1.0).cgColor
        shapeLayer.lineWidth = 25
        shapeLayer.fillColor = UIColor.clear.cgColor
       
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeLayer.strokeEnd = 0
        
        self.layer.addSublayer(shapeLayer)
        
        
        //These are temporary testing values. the values for
        //the progress bar should come from the user's progress
        //progressvalue is the percentage of their progress
        //minutesCompleted is the total minutes they have completed
        //goalTime is the total minutes they need to meet for their goal
        //goal
        
        let minutesCompleted = 12
        let goalTime = 20
        let progressValue = (Float(minutesCompleted)/Float(goalTime))
        // animate the circle
       // print("attempting to animate circle")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = progressValue    //I set it to 0.25 to test that the value can be adjusted to progress
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")


      // this will be the first text layer you will use that displays the big number
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 105, y: 105, width: 200, height: 90) // adjust these numbers to position text
        print(frame)
        let string = String(minutesCompleted)
        textLayer.string = string

        textLayer.font = UIFont.progressBarLargeText()
        textLayer.fontSize = 50
        textLayer.foregroundColor = UIColor(red:0.00, green:0.57, blue:0.47, alpha:1.0).cgColor
        textLayer.isWrapped = true
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
        print(textLayer)
        
        
        
        //this is the text for the smaller progress bar text
        //" of 20 minutes " text
        let smallTextLayer = CATextLayer()
        smallTextLayer.frame = CGRect(x: 105, y: 165, width: 200, height: 90)
        let goal = String(goalTime)
        let string2 = "of "+goal + " min"
        smallTextLayer.string = string2
        smallTextLayer.font = UIFont.progressBarSmallText()
        smallTextLayer.fontSize = 20
        smallTextLayer.foregroundColor = UIColor(red:0.00, green:0.57, blue:0.47, alpha:1.0).cgColor
        smallTextLayer.isWrapped = true
        smallTextLayer.alignmentMode = CATextLayerAlignmentMode.center
        smallTextLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(smallTextLayer)
    }
    
    
}

