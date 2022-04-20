//
//  Tile.swift
//  Flagsweeper
//
//  Created by Louis Menacho on 4/16/22.
//

import Foundation

class Tile {
    
    enum Attribute: Int {
        case none = 0
        case numb = 1
        case flag = 2
    }
    
    var row: Int
    var col: Int
    var number: Int
    var attribute: Attribute
    
    init(row: Int, col: Int, number: Int = 0, attribute: Attribute = .none) {
        self.row = row
        self.col = col
        self.number = number
        self.attribute = attribute
    }
    
    func reset() {
        number = 0
        attribute = .none
    }
    
    func setFlag() {
        attribute = .flag
    }
    
    func incrementNumber() {
        number += 1
        attribute = (attribute == .flag) ? .flag : .numb
    }
}
