//
//  UITabBar+Extension.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 01/01/2020.
//  Copyright © 2020 Vlastimir. All rights reserved.
//

import UIKit

@IBDesignable
class BRUITabBar: UITabBar {
    
    @IBInspectable
    var tabBarHeight: CGFloat = 50.0
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.windows.first else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        if tabBarHeight > 0.0 {
            sizeThatFits.height = tabBarHeight + window.safeAreaInsets.bottom
        }
        return sizeThatFits
    }
}

@IBDesignable
class BRBarButtonItem: UIBarButtonItem {
    
//    @IBInspectable
//    var barItemFont: UIFont {
//        set {
//            
//            func setTabBarFont() {
//                guard let font = UIFont.init(name: "AvenirNext-Regular", size: 10) else { return }
//                UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
//            }
//            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: newValue], for: .normal)
//        }
//        get {
//            return UITabBarItem.titleTextAttributes(self).font        }
//    }
}
