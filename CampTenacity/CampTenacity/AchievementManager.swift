//
//  AchievementManager.swift
//  CampTenacity
//
//  Created by Emma on 2/10/20.
//  Copyright © 2020 Tenacity. All rights reserved.
//

import Foundation

class AchievementManager {
    
    var masterList = [ AchievementLevel(levelNumber: 1, photoName: "placeholder", requiredNumberOfCycles: 3, name: "Received a basic tent!")
    ]
    
    func getAchievementAt(index: Int) -> AchievementLevel {
        return masterList[index]
    }
    
}
