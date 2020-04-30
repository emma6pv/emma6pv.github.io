import Foundation

class User {
    let id = UUID()

    internal var currentLevel: Int = 0
    internal var playLog = [String: Int]()
    internal var timesPlayed = 0 //counts the number of games played
    internal var streak = 0
    internal var achievementTimeline = [Int: Date]()

    /**
        increase timesPlayed by 1
        update playLog counter for today by 1
    **/
    func addTimesPlayed() {
        let date = Date()
        let format = DateFormatter()
        format.dateStyle = .short
        let formattedDate = format.string(from: date) //saves date without time in local format

        //if today is a key, update value by 1
        if playLog[formattedDate] != nil {
            playLog[formattedDate] = playLog[formattedDate]! + 1
        }
        else { //add today as a key and set the value to 1
            playLog[formattedDate] = 1
        }

        timesPlayed += 1
    }

    /**
        update currentLevel
        update achievementTimeline
    **/
    func addAchievement(level: AchievementLevel) -> Bool {
        //if the level has already been achieved or if the requirement is unmet
        if achievementTimeline[level.levelNumber] != nil || timesPlayed < level.requiredNumberOfCycles {
            return false
        }

        currentLevel = level.levelNumber
        achievementTimeline[level.levelNumber] = Date()
        return true
    }
}
