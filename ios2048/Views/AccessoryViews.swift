//
//  AccessoryViews.swift
//  ios2048
//
//  Created by Prince Kumar on 2019/09/01.
//  Copyright © 2019 Prince Kumar. All rights reserved.
//

import UIKit

protocol ScoreViewProtocol {
    func scoreChanged(to s: Int)
}

// A simple view that displays the player's score.
class ScoreView: UIView, ScoreViewProtocol {
    var score :Int = 0 {
        didSet {
            label.text = "SCORE: \(score)"
        }
    }
    
    let defaultFrame = CGRect(x: 0, y: 0, width: 140, height: 40)
    var label: UILabel
    
    init(backgroundColor bgColor: UIColor, textColor tcolor: UIColor, font: UIFont, radius r:CGFloat) {
        label = UILabel(frame: defaultFrame)
        label.textAlignment = NSTextAlignment.center
        super.init(frame: defaultFrame)
        backgroundColor = bgColor
        label.textColor = tcolor
        label.font = font
        layer.cornerRadius = r
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func scoreChanged(to s: Int) {
        score = s
    }
}

// A simple view that displays several buttons for controlling the app
class ControlView {
    let defaultFrame = CGRect(x: 0, y: 0, width: 140, height: 40)
    // TODO: Implement me
}
