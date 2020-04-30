//
//  FontManager.swift
//  CampTenacity
//
//  Created by Emma on 1/24/20.
//  Copyright © 2020 Tenacity. All rights reserved.
//

import UIKit

extension UIFont {
    
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func header() -> UIFont {
        let size = getSize(type: "header")
        return customFont(name: "Quicksand-Bold", size: size)
    }
    
    static func subtext() -> UIFont {
        let size = getSize(type: "subtext")
        return customFont(name: "Quicksand-Regular", size: size)
    }
    
    static func largeStatText() -> UIFont {
        let size = getSize(type: "largeStatText")
        return customFont(name: "Quicksand-Bold", size: size)
    }
    
    static func dateAsTitle() -> UIFont {
        let size = getSize(type: "dateAsTitle")
        return customFont(name: "Quicksand-SemiBold", size: size)
    }
    
    static func smallText() -> UIFont {
        let size = getSize(type: "smallText")
        return customFont(name: "Quicksand-Regular", size: size)
    }
    
    static func buttonText() -> UIFont {
        let size = getSize(type: "buttonText")
        return customFont(name: "Quicksand-Bold", size: size)
    }
    
    static func subheader() -> UIFont {
        let size = getSize(type: "subheader")
        return customFont(name: "Quicksand-Bold", size: size)
    }
    
    static func updateImageText() -> UIFont {
        let size = getSize(type: "updateImageText")
        return customFont(name: "Quicksand-Regular", size: size)
    }
    
    static func progressBarLargeText() -> UIFont {
        let size = getSize (type: "progressBarLargeText")
        return customFont(name: "Quicksand-Bold", size: size)
        
    }
    
    static func progressBarSmallText() -> UIFont {
        let size = getSize (type: "progressBarSmallText")
        return customFont(name: "Quicksand-Bold", size: size)
        
    }
    
    static func chartXAxis() -> UIFont {
        let size = getSize(type: "smallText")
        return customFont(name: "Quicksand-Bold", size: size)
    }
    
    static func chartDrawValue() -> UIFont {
          let size = getSize(type: "evenSmallerText")
          return customFont(name: "Quicksand-Regular", size: size)
      }
    
    private static func getSize(type: String) -> CGFloat {
        let deviceGuru = DeviceGuru()
        let model = deviceGuru.hardwareNumber()
        
        // LARGER MODELS
        if (model == 12.5 || model == 12.1 || model == 12.3) {
            //print("iPhone 11")
            
            if (type == "header") {
                return 32
            }
            if (type == "subheader") {
                return 26
            }
            if (type == "largeStatText") {
                return 64
            }
            if (type == "updateImageText") {
                return 16
            }
            if (type == "subtext") {
                return 18
            }
            if (type == "dateAsTitle") {
                return 18
            }
            if (type == "smallText") {
                return 13
            }
            if (type == "buttonText") {
                return 22
            }
            if (type == "progressBarLargeText"){
                return 50
            }
            if (type == "progressBarSmalltext"){
                return 20
            }
            if (type == "evenSmallerText"){
                return 10
            }
          
        // SMALLER MODELS
        } else {
            if (type == "header") {
                return 28
            }
            if (type == "subheader") {
                return 22
            }
            if (type == "subtext") {
                return 16
            }
            if (type == "largeStatText") {
                return 56
            }
            if (type == "updateImageText") {
                return 14
            }
            if (type == "dateAsTitle") {
                return 18
            }
            if (type == "smallText") {
                return 12
            }
            if (type == "buttonText") {
                return 20
            }
            if (type == "progressBarLargeText"){
                return 45
            }
            if (type == "progressBarSmalltext"){
                return 15
            }
            if (type == "evenSmallerText"){
                return 9
            }
        }
        
        return 16
    }
    
}
