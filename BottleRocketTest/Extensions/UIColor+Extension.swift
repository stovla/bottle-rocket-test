//
//  UIColor+Extension.swift
//  BottleRocketTest
//
//  Created by Vlastimir Radojevic on 3/1/20.
//  Copyright © 2020 Vlastimir. All rights reserved.
//
//  Color assets and extensions

import UIKit

enum AssetsColor: String {
    case navBarGreen
    case tabBarDark
    case detailViewGreen
    case textLabelDark
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
         return UIColor(named: name.rawValue)
    }
    static let joinedColor = UIColor()
}
