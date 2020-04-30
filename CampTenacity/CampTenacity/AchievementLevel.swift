
class AchievementLevel {
    
    var levelNumber : Int
    var photoName : String
    var requiredNumberOfCycles : Int
    var name : String
    
    init(levelNumber: Int, photoName: String, requiredNumberOfCycles: Int, name: String) {
        self.levelNumber = levelNumber
        self.photoName = photoName
        self.requiredNumberOfCycles = requiredNumberOfCycles
        self.name = name
    }
}
