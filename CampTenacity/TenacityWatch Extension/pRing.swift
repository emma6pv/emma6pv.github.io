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
        
        // animate the circle
       // print("attempting to animate circle")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0.25    //I set it to 0.25 to test that the value can be adjusted to progress
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")


      // this will be the first text layer you will use that displays the big number
    // after this layer is complete, add a second text layer that displays the smaller "of 20 minutes" text
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 50, y: 50, width: 200, height: 90) // adjust these numbers to position text
        print(frame)
        let string = "Testing"
        textLayer.string = string
        textLayer.fontSize = 21
        
        // you'll probably need to make your own font for this.
        // go to FontManager.swift, and add 2 fonts. One titled "progressBarLargeText"
        // and another titled "progressBarSmallText"
        // just copy the same structure as the other fonts in the file.
        // once that's complete, then use the font like so:
        // textLayer.font = UIFont.progressBarLargeText()
        
        textLayer.foregroundColor = UIColor(named: "progressColor")?.cgColor
        textLayer.isWrapped = true
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
        print(textLayer)
    
    }
    
    
}

