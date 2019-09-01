//
//  NumberTileGameViewController.swift
//  ios2048
//
//  Created by Prince Kumar on 2019/09/01.
//  Copyright © 2019 Prince Kumar. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // How many tiles in both directions the gameboard contains
    var dimension: Int
    // The value of the winning tile
    var threshold: Int
    
    var board: GameboardView?
    //var model: GameModel?
    
    // Width of the gameboard
    let boardWidth: CGFloat = 230.0
    
    // How much padding to place between the tiles
    let thinPadding: CGFloat = 3.0
    let thickPadding: CGFloat = 6.0
    
    // Amount of space to place between the different component views (gameboard, score view, etc)
    let viewPadding: CGFloat = 0.0
    
    // Amount that the vertical alignment of the component views should differ from if they were centered
    let verticalViewOffset: CGFloat = 0.0
    
    init(dimension d: Int, threshold t: Int) {
        dimension = d > 2 ? d : 2
        threshold = t > 8 ? t : 8
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }
    
    func setupGame() {
        let vcHeight = view.bounds.size.height
        let vcWidth = view.bounds.size.width
        
        // Create the scrore view
        
        let padding: CGFloat = dimension > 5 ? thinPadding : thickPadding
        let v1 = boardWidth - padding*(CGFloat(dimension + 1))
        let width: CGFloat = CGFloat(floorf(CFloat(v1)))/CGFloat(dimension)
        let gameboard = GameboardView(dimension: dimension,
                                      tileWidth: width,
                                      tilePadding: padding,
                                      cornerRadius: 6,
                                      backgroundColor: UIColor.black,
                                      foregroundColor: UIColor.darkGray)
        
        // Add to game state
        view.addSubview(gameboard)
        
    }
}
