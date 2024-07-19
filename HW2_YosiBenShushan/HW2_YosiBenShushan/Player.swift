//
//  Player.swift
//  HW2_YosiBenShushan
//
//

class Player {
    private var name: String
    private var score: Int
    
    init(name: String) {
        self.name = name
        self.score = 0
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func setName(name: String) {
        self.name = name
    }
    
    public func getScore() -> Int {
        return self.score
    }
    
    public func updateScore(score: Int) {
        self.score += score
    }
}
