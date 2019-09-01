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
}
