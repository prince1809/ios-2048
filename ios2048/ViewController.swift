//
//  ViewController.swift
//  ios2048
//
//  Created by Prince Kumar on 2019/09/01.
//  Copyright © 2019 Prince Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startGameButtonTapped(_ sender: UIButton) {
        print("Start game.....")
        let game = GameViewController(dimension: 4, threshold: 2048)
        self.present(game, animated: true, completion: nil)
    }
}

