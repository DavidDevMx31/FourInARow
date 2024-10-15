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
    
    private func canMove(in column: Int) -> Bool {
        return nextEmptySlot(in: column) != nil
    }
    
    func addChip(_ chip: Chip, in column: Int) {
        if let row = nextEmptySlot(in: column) {
            set(chip: chip, in: column, row: row)
        }
    }
    
    func isGameBoardFull() -> Bool {
        for column in 0..<GameBoard.width {
            if canMove(in: column) {
                return false
            }
        }
        return true
    }
    
    func playerWins(column: Int, row: Int) -> Bool {
        let chip = currentPlayer.chip
        if checkVerticalRun(chip: chip, row: row, column: column) {
            return true
        }
        else if checkHorizontalRun(chip: chip, row: row, column: column) {
            return true
        }
        else if checkDiagonalRun(chip: chip, row: row, column: column) {
            return true
        }
        else if checkInverseDiagonalRun(chip: chip, row: row, column: column) {
            return true
        }
        return false
    }
    
    private func checkVerticalRun(chip: Chip, row: Int, column: Int) -> Bool {
        debugPrint("checkVerticalRun")
        if row <= 2 { return false }
        var counter = 1, x = row
        while x > 0, counter < 4 {
            if chip != getChip(inColumn: column, row: x - 1) {
                return false
            } else {
                counter += 1
                x -= 1
            }
        }
        return counter == 4
    }
    
    private func checkHorizontalRun(chip: Chip, row: Int, column: Int) -> Bool {
        var searchLeft = true, searchRight = true
        var counter = 1
        var xOffset = 1
        
        while searchLeft, counter < 4, column - xOffset >= 0 {
            if chip == getChip(inColumn: column - xOffset, row: row) {
                counter += 1
                xOffset += 1
            } else {
                searchLeft = false
            }
        }
        xOffset = 1
        while searchRight, counter < 4, column + xOffset <= GameBoard.width - 1 {
            if chip == getChip(inColumn: column + xOffset, row: row) {
                xOffset += 1
                counter += 1
            }
            else {
                searchRight = false
            }
        }
        
        return counter == 4
    }
    
    private func checkDiagonalRun(chip: Chip, row: Int, column: Int) -> Bool {
        var searchLeftUp = true, searchRightDown = true, counter = 1, xOffset = 1, yOffset = 1
        
        while searchLeftUp, column - xOffset >= 0, row + yOffset <= GameBoard.height - 1,
                counter < 4  {
            if chip == getChip(inColumn: column - xOffset, row: row + yOffset) {
                xOffset += 1
                yOffset += 1
                counter += 1
            }
            else {
                searchLeftUp = false
            }
        }
        xOffset = 1
        yOffset = 1
        
        while searchRightDown, column + xOffset <= GameBoard.width - 1, row - yOffset >= 0,
                counter < 4 {
            if chip == getChip(inColumn: column + xOffset, row: row - yOffset) {
                xOffset += 1
                yOffset += 1
                counter += 1
            }
            else {
                searchRightDown = false
            }
        }
        
        return counter == 4
    }
    
    private func checkInverseDiagonalRun(chip: Chip, row: Int, column: Int) -> Bool {
        var searchUp = true, searchDown = true, counter = 1, xOffset = 1, yOffset = 1
        
        while searchDown, column - xOffset >= 0, row - yOffset >= 0, counter < 4 {
            if chip == getChip(inColumn: column - xOffset, row: row - yOffset) {
                xOffset += 1
                yOffset += 1
                counter += 1
            }
            else {
                searchDown = false
            }
        }
        
        xOffset = 1
        yOffset = 1
        
        while searchUp, column + xOffset <= GameBoard.width - 1,
                row + yOffset <= GameBoard.height - 1,
              counter < 4  {
            if chip == getChip(inColumn: column + xOffset, row: row + yOffset) {
                xOffset += 1
                yOffset += 1
                counter += 1
            }
            else {
                searchUp = false
            }
        }
        
        return counter == 4
    }
}
