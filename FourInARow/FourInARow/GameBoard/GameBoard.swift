//
//  GameBoard.swift
//  FourInARow
//
//  Created by David Ali on 14/10/24.
//

import UIKit

class GameBoard: NSObject {
    static var width = 7
    static var height = 6
    
    var slots = [Chip]()
    var currentPlayer: Player
    
    override init() {
        currentPlayer = Player.allPlayers[0]
        
        for _ in 0..<GameBoard.width * GameBoard.height {
            slots.append(.none)
        }
        
        super.init()
    }

    private func getChip(inColumn column: Int, row: Int) -> Chip {
        return slots[row + column * GameBoard.height]
    }
}
