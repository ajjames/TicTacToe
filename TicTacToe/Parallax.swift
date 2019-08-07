//
//  Parallax.swift
//  TicTacToe
//
//  Created by Andrew James on 1/20/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    func addBackgroundParallax(_ strength: CGFloat) {
        addParallax(-strength)
    }


    func addForegroundParallax(_ strength: CGFloat) {
        addParallax(strength)
    }


    func removeParallax() {
        for effect:UIMotionEffect in motionEffects {
            removeMotionEffect(effect)
        }
    }

    func addParallax(_ amount: CGFloat) {
        removeParallax()

        let verticalMotionEffect:UIInterpolatingMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -amount
        verticalMotionEffect.maximumRelativeValue = amount

        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -amount
        horizontalMotionEffect.maximumRelativeValue = amount

        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        self.addMotionEffect(group)
    }
}
