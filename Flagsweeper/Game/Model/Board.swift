//
//  Board.swift
//  Flagsweeper
//
//  Created by Louis Menacho on 4/16/22.
//

import Foundation

class Board {
    
    private var rowCount: Int
    private var colCount: Int
    private var flagCount: Int
    private var grid: [[Tile]]
    
    init(rowCount: Int, colCount: Int, flagCount: Int) {
        self.rowCount = rowCount
        self.colCount = colCount
        self.flagCount = flagCount
        self.grid = Array(repeating: [], count: rowCount)
        
        //create tiles in grid
        for row in 0..<rowCount {
            for col in 0..<colCount {
                let tile = Tile(row: row, col: col)
                grid[row].append(tile)
            }
        }
        
        //set random flags
        randomTiles(count: flagCount).forEach { tile in
            tile.setFlag()
            adjacentTiles(for: tile.row, tile.col).forEach { adjacentTile in
                adjacentTile.incrementNumber()
            }
        }
    }
    
    func randomTiles(count: Int) -> [Tile] {
        var points = [(row: Int, col: Int)]()
        while points.count <= count {
            let randomNumber = Int.random(in: 0..<rowCount*colCount)
            let row = randomNumber / colCount
            let col = randomNumber % colCount
            let point = (row, col)
            if !points.contains(where: { $0 == point }) {
                points.append(point)
            }
        }
        return points.map {
            grid[$0.row][$0.col]
        }
    }
    
    func adjacentTiles(for row: Int, _ col: Int) -> [Tile] {
        [
            (row: row-1  ,col: col-1),  //topLeft
            (row: row    ,col: col-1),  //topMid
            (row: row+1  ,col: col-1),  //topRight
            (row: row-1  ,col: col),    //midLeft
            (row: row+1  ,col: col),    //midRight
            (row: row-1  ,col: col+1),  //bottomLeft
            (row: row    ,col: col+1),  //bottomMid
            (row: row+1  ,col: col+1)   //bottomRight
        ]
        .filter {
            gridContains($0.row,$0.col) //remove
        }
        .map {
            grid[$0.row][$0.col]
        }
    }
    
    func gridContains(_ row: Int, _ col: Int) -> Bool {
        return grid.indices.contains(row) && grid[row].indices.contains(col)
    }
    
    func printGrid() {
        let gridPrint = grid.map { row in
            row.map { tile in
                switch tile.attribute {
                case .none:
                    return " "
                case .numb:
                    return "\(tile.number)"
                case .flag:
                    return "X"
                }
            }.joined(separator: " ")
        }.joined(separator: "\n")
        
        print(gridPrint)
    }
}
