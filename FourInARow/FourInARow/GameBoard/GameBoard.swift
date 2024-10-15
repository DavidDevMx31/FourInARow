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
    
    private func set(chip: Chip, in column: Int, row: Int) {
        slots[row + column * GameBoard.height] = chip
    }
    
    func nextEmptySlot(in column: Int) -> Int? {
        for row in 0 ..< GameBoard.height {
            if getChip(inColumn: column, row: row) == .none {
                return row
            }
        }
        return nil
    }
    
}
