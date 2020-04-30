//
//  InterfaceController.swift
//  breathe WatchKit Extension
//
//  Created by Kaitlyn Nguyen on 2/7/20.
//  Copyright © 2020 Kaitlyn Nguyen. All rights reserved.
//

// NEXT STEP:
// Set up connection to the phone application so that the "send data" function can deliver
// the corresponding information that is needed in creating the statistics page.


import WatchKit
import Foundation
import WatchConnectivity

var FullCycle = 5
var sessionTime = 15
var time = 0.0 //used for timer, keeps track of how long in game
var correctCyclesTotal = 0
var cycleTotal = 0
var inGame = true
var totalBreaths = 0
var averageFullBreatheTime = 3.5

var breatheTheme = "classic"
var breatheColor = 0

var resetColor: UIColor = UIColor(red: 0.96, green: 0.945, blue: 0.35, alpha: 1.0)


class InterfaceController: WKInterfaceController {
    
    let startRelativeHeight = 0.7
    let startRelativeWidth = 0.55
    
    let customBlue =  UIColor(red:0.102, green: 0.788, blue: 0.827, alpha: 1.0)
    let customRed = UIColor(red: 0.77, green: 0.19, blue: 0.34, alpha: 1.0)
    let customPink = UIColor(red: 0.96, green: 0.62, blue: 0.16, alpha: 1.0) // saffron
    let customGreen = UIColor(red: 0.71, green: 0.49, blue: 0.86, alpha: 1.0) //lavender
    
    lazy var customColors = [customBlue, customPink, customRed, customGreen]
    
    var counter = 0.0
    
    var totalBreatheTimes = 3.5
    //var resetInterval = 2.5   unused right now
    
    var breatheInTimer = Timer()
    var breatheInTime = 0.0
    
    var cycleStep = 0
    
    
    @IBOutlet weak var image: WKInterfaceImage!
    @IBOutlet weak var breathGuide: WKInterfaceLabel!
    @IBOutlet weak var breathCount: WKInterfaceLabel!
    @IBOutlet weak var cycleCount: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    @IBAction func swipeAction(_ sender: Any) {
        
        animate(withDuration: 0.1){
            self.image.setRelativeWidth(CGFloat(1), withAdjustment: 0)
            self.image.setRelativeHeight(CGFloat(1), withAdjustment: 0)
        }
        animate(withDuration: 0.25){
            self.image.setRelativeWidth(CGFloat(self.startRelativeWidth), withAdjustment: 0)
            self.image.setRelativeHeight(CGFloat(self.startRelativeHeight), withAdjustment: 0)
        }
        if (cycleStep != FullCycle){
            let continueAlert = WKAlertAction(title: "Continue", style: .cancel){
            }
            presentAlert(withTitle: "Oops", message: "You Swiped When You Should Have Held", preferredStyle: .alert, actions: [continueAlert])
            sendData(what: "swipe", correct: "false")
            WKInterfaceDevice.current().play(.notification)
        }
        else{
            breathGuide.setText("inhale") //inhale cue for a new cyle
            correctCyclesTotal += 1
            sendData(what: "swipe", correct: "true")
            WKInterfaceDevice.current().play(.success)
        }
        cycleReset()
    }

    @IBAction func longPressHold(_ gestureRecognizer:
        WKLongPressGestureRecognizer) {
            if gestureRecognizer.state == .began{
                resetImage()
                breathGuide.setText("inhale")
                counter = 0
                breatheInTime = 0
                if (cycleStep == FullCycle){
                    sendData(what: "start hold", correct: "false")
                }
                else{
                    sendData(what: "start hold", correct: "true")
                }
                breatheInTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector (InterfaceController.breatheInCounter), userInfo: nil, repeats: true)
                cycleStep += 1
            }
            else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled{
                if (cycleStep == FullCycle){
                    breathGuide.setText("swipe!")
                }
                else{
                    breathGuide.setText("exhale")
                }
                breatheInTimer.invalidate()
                print("breathe in time: " + String(format: "%.3f", breatheInTime))
                totalBreaths += 1
                breathCount.setText(String(totalBreaths))
                print("total breaths: " + String(totalBreaths))
                
                addToAverageBreatheTime(time: breatheInTime)
                print("new avg: " + String(format: "%.3f", averageFullBreatheTime))
                
                //Can use "(breatheInTime - offset)" or global var "resetInterval" for "withDuration"
                var shrinkInterval = (0.8)*(breatheInTime)
                
                if (shrinkInterval > 2.5){
                    shrinkInterval = 2.5
                }
                
                animate(withDuration: shrinkInterval){
                    self.image.setRelativeWidth(CGFloat(self.startRelativeWidth), withAdjustment: 0)
                    self.image.setRelativeHeight(CGFloat(self.startRelativeHeight), withAdjustment: 0)
                }
                if (cycleStep == (FullCycle + 1)){
                    cycleReset()
                    sendData(what: "stop hold", correct: "false")
                    let continueAlert = WKAlertAction(title: "Continue", style: .cancel){
                    }
                    presentAlert(withTitle: "Oops", message: "You Held When You Should Have Swiped", preferredStyle: .alert, actions: [continueAlert])
                }
                else{
                    animate(withDuration: 1){
                        self.image.setTintColor(self.customColors[breatheColor])
                    }
                    
                    sendData(what: "stop hold", correct: "true")
                }
            }
        }
    
    func addToAverageBreatheTime(time : Double){
        totalBreatheTimes = totalBreatheTimes + time
        averageFullBreatheTime = totalBreatheTimes/Double((totalBreaths + 1))
    }
    
    @objc func breatheInCounter(){
        if (counter < averageFullBreatheTime){
            animate(withDuration: 0.1){
                //self.alpha = (self.counter/self.averageFullBreatheTime)
                //self.image.setAlpha(CGFloat(self.alpha))
                let addHeight = (1 - self.startRelativeWidth)*(self.counter/averageFullBreatheTime)
                let addWidth = (1 - self.startRelativeHeight)*(self.counter/averageFullBreatheTime)
                self.image.setRelativeWidth(CGFloat(self.startRelativeWidth + addWidth), withAdjustment: 0)
                self.image.setRelativeHeight(CGFloat(self.startRelativeHeight + addHeight), withAdjustment: 0)
                self.counter += 0.1
            }
        }
        WKInterfaceDevice.current().play(.directionUp)
        breatheInTime += 0.1
    }
    
    func resetImage(){
        self.image.setRelativeWidth(CGFloat(startRelativeWidth), withAdjustment: 0)
        self.image.setRelativeHeight(CGFloat(startRelativeHeight), withAdjustment: 0)
    }
    
    func cycleReset(){ //goes back to step one
        cycleTotal += 1
        cycleCount.setText(String(cycleTotal))
        cycleStep = 0
        animate(withDuration: 1){
            self.image.setTintColor(resetColor)
        }
    }
    
    func sendData(game : String = "breathe focus", what : String, correct : String, cycleSettings : Int = FullCycle, timeSettings : Int = sessionTime, timePlayed : Double = 0.0, avgBreathLength : Double = 0.0, totalSets : Int = 0, correctSets : Int = 0){
        let session = WCSession.default
        if session.activationState == .activated{
            let timestamp = NSDate().timeIntervalSince1970
            let date = Date()
            
            let data = ["game": game,
                        "what": what,
                        "correct": correct,
                        "date": date,
                        "time": timestamp,
            "breatheFCycleSettings": cycleSettings,
            "breatheFTimeSettings": timeSettings,
            "breatheFTimePlayed": timePlayed,
            "breatheFBreathLength": avgBreathLength,
            "breatheFTotalSets": totalSets,
            "breatheFCorrectSets": correctSets] as [String : Any]
            session.transferUserInfo(data)
        }}
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
