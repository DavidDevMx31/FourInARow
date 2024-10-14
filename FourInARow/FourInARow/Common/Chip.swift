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
    
    var color: UIColor {
        switch self {
        case .yellow:
            return UIColor.yellow
        case .red:
            return UIColor.red
        default:
            return UIColor.white
        }
    }
}
