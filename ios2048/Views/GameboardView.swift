//
//  GameboardView.swift
//  ios2048
//
//  Created by Prince Kumar on 2019/09/01.
//  Copyright © 2019 Prince Kumar. All rights reserved.
//

import UIKit

class GameboardView: UIView {
    var dimension: Int
    var tileWidth: CGFloat
    var tilePadding: CGFloat
    var cornerRadius: CGFloat
    var tiles: Dictionary<IndexPath, TileView>
    
    let provider = AppearanceProvider()
    
    let tilePopStartScale: CGFloat = 0.1
    let tilePopMaxScale: CGFloat = 1.1
    let tilePopDelay: TimeInterval = 0.05
    let tileExpandTime: TimeInterval = 0.18
    let tileContractTime: TimeInterval = 0.08
    
    let tileMergeStartScale: CGFloat = 1.0
    let tileMergeExpandTime: TimeInterval = 0.08
    let tileMergeContractTime: TimeInterval = 0.08
    
    let perSequareSlideDuration: TimeInterval = 0.08
    
    init(dimension d: Int, tileWidth width: CGFloat, tilePadding padding: CGFloat, cornerRadius radius: CGFloat, backgroundColor: UIColor, foregroundColor: UIColor) {
        assert(d > 0)
        dimension = d
        tileWidth = width
        tilePadding = padding
        cornerRadius = radius
        tiles = Dictionary()
        let sideLength = padding + CGFloat(dimension)*(width + padding)
        super.init(frame: CGRect(x: 0, y: 0, width: sideLength, height: sideLength))
        layer.cornerRadius = radius
        setupBackground(backgroundColor: backgroundColor, tileColor: foregroundColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func positionIsValid(_ pos: (Int, Int)) -> Bool {
        let (x, y) = pos
        return (x >= 0 && x < dimension && y >= 0 && y < dimension)
    }
    
    func setupBackground(backgroundColor bgColor: UIColor, tileColor: UIColor) {
        backgroundColor = bgColor
        var xCursor = tilePadding
        var yCursor : CGFloat
        let bgRadius = (cornerRadius >= 2) ? cornerRadius - 2 : 0
        for _ in 0..<dimension {
            yCursor = tilePadding
            for _ in 0..<dimension {
                // Draw each tile
                let background = UIView(frame: CGRect(x: xCursor, y: yCursor, width: tileWidth, height: tileWidth))
                background.layer.cornerRadius = bgRadius
                background.backgroundColor = tileColor
                addSubview(background)
                yCursor += tilePadding + tileWidth
            }
            xCursor += tilePadding + tileWidth
        }
    }
    
    /// Update the gameboard by inserting a tile in a given location. The tile willl be inserted with a 'pop' animation.
    func insertTile(at pos: (Int, Int), value: Int) {
        assert(positionIsValid(pos))
        let (row, col) = pos
        let x = tilePadding + CGFloat(col)*(tileWidth + tilePadding)
        let y = tilePadding + CGFloat(row)*(tileWidth + tilePadding)
        let r = (cornerRadius >= 2) ? cornerRadius - 2 : 0
        let tile = TileView(position: CGPoint(x: x, y: y), width: tileWidth, value: value, radius: r, delegate: provider)
        tile.layer.setAffineTransform(CGAffineTransform(scaleX: tilePopStartScale, y: tilePopStartScale))
        
        addSubview(tile)
        bringSubviewToFront(tile)
        tiles[IndexPath(row: row, section: col)] = tile
        
        // Add to board
        UIView.animate(withDuration: tileExpandTime, delay: tilePopDelay, options: UIView.AnimationOptions(), animations: {
            // Make the tile 'pop'
            tile.layer.setAffineTransform(CGAffineTransform(scaleX: self.tilePopMaxScale, y: self.tilePopMaxScale))
        }, completion: { finished in
            // Shrink the tile after it 'pop'
            UIView.animate(withDuration: self.tileContractTime, animations: { () -> Void in
                tile.layer.setAffineTransform(CGAffineTransform.identity)
            })
        })
    }
    
    func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int) {
        assert(positionIsValid(from) && positionIsValid(to))
        let (fromRow, fromCol) = from
        let (toRow, toCol) = to
        let fromKey = IndexPath(row: fromRow, section: fromCol)
        let toKey = IndexPath(row: toRow, section: toCol)
        
        // Get the tiles
        guard let tile = tiles[fromKey] else {
            assert(false, "placeholder error")
        }
        let endTile = tiles[toKey]
        
        // Make the frame
        var finalFrame = tile.frame
        finalFrame.origin.x = tilePadding + CGFloat(toCol)*(tileWidth + tilePadding)
        finalFrame.origin.y = tilePadding + CGFloat(toCol)*(tileWidth + tilePadding)
        
        // Update the board state
        tiles.removeValue(forKey: fromKey)
        tiles[toKey] = tile
        
        // Animate
        let shouldPop = endTile != nil
        UIView.animate(
            withDuration: perSequareSlideDuration,
            delay: 0.0, options: UIView.AnimationOptions.beginFromCurrentState,
            animations: {
                // Slide the tile
                tile.frame = finalFrame
        }, completion: { (finished: Bool) -> Void in
            tile.value = value
            endTile?.removeFromSuperview()
            if !shouldPop || !finished {
                return
            }
            tile.layer.setAffineTransform(CGAffineTransform(scaleX: self.tileMergeStartScale, y: self.tileMergeStartScale))
            // Pop tile
            UIView.animate(
                withDuration: self.tileMergeExpandTime,
                animations: {
                    tile.layer.setAffineTransform(CGAffineTransform(scaleX: self.tilePopMaxScale, y: self.tilePopMaxScale))
            }, completion: { finished in
                // Contract tile to original size
                UIView.animate(withDuration: self.tileMergeContractTime, animations: {
                    tile.layer.setAffineTransform(CGAffineTransform.identity)
                })
            })
        })
    }
    
    // Update the gameboard by moving tiles from their original locations to a common destination. This action always
    /// represents tile collapse, and the combined tile 'pops' after both tiles move into position.
    func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
        //assert(position)
    }
}
