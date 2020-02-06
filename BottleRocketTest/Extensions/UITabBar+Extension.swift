//
//  UITabBar+Extension.swift
//  BottleRocketTest
//
//  Created by Vlastimir on 01/01/2020.
//  Copyright © 2020 Vlastimir. All rights reserved.
//
//  UITabBar custom class

import UIKit

@IBDesignable
class BRUITabBar: UITabBar {
    
    @IBInspectable
    var tabBarHeight: CGFloat = 50.0
    
    @IBInspectable
    var unselectedItemColor: UIColor {
        set {
            unselectedItemTintColor = newValue
        }
        get {
            return unselectedItemTintColor!
        }
    }
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCustomTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCustomTabBar()
    }
    
    private func setupCustomTabBar() {
        guard let font = UIFont.init(name: "AvenirNext-Regular", size: 10) else { return }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }
}
