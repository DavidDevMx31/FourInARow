//
//  Player.swift
//  FourInARow
//
//  Created by David Ali on 14/10/24.
//

import Foundation

final class Player: NSObject {
    var chip: Chip
    var playerId: Int
    
    static var allPlayers = [Player(chip: .red), Player(chip: .yellow)]
    
    var opponent: Player {
        if chip == .red {
            return Player.allPlayers[1]
        } else {
            return Player.allPlayers[0]
        }
    }
    
    init(chip: Chip) {
        self.chip = chip
        self.playerId = chip.rawValue
        
        super.init()
    }
}
