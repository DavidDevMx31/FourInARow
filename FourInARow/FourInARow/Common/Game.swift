//
//  Game.swift
//  FourInARow
//
//  Created by David Ali on 14/10/24.
//

import Foundation

class Game {
    var redWins: Int = 0
    var yellowWins: Int = 0
    
    func resetVictoryCounter() {
        redWins = 0
        yellowWins = 0
    }
    
    func declareWinner(player: Player) {
        if player.chip == .red { redWins += 1 }
        else { yellowWins += 1 }
    }
}
