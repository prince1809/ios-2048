//
//  AppearanceProvider.swift
//  ios2048
//
//  Created by Prince Kumar on 2019/09/01.
//  Copyright © 2019 Prince Kumar. All rights reserved.
//

import UIKit

protocol AppearanceProviderProtocol: class {
    func tileColor(_ value: Int) -> UIColor
    func numberColor(_ value: Int) -> UIColor
    func fontForNumbers() -> UIFont
}

class AppearanceProvider: AppearanceProviderProtocol {
    
    
    func tileColor(_ value: Int) -> UIColor {
        switch value {
        case 2:
            return UIColor.red
        default:
            return UIColor.white
        }
    }
    
    func numberColor(_ value: Int) -> UIColor {
        switch value {
        case 2,4:
            return UIColor.red
        default:
            return UIColor.white
        }
    }
    
    func fontForNumbers() -> UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
}
