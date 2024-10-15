//
//  Chip.swift
//  FourInARow
//
//  Created by David Ali on 14/10/24.
//

import Foundation
import UIKit

enum Chip: Int {
    case none
    case red
    case yellow
    
    var name: String {
        switch self {
        case .yellow:
            return "Yellow"
        case .red:
            return "Red"
        default:
            return ""
        }
    }
    
    var imageName: String {
        switch self {
        case .yellow:
            return "YellowChip"
        case .red:
            return "RedChip"
        default:
            return ""
        }
    }
}
