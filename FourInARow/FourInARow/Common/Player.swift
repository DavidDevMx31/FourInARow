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
    
    init(chip: Chip) {
        self.chip = chip
        self.playerId = chip.rawValue
        
        super.init()
    }
}
