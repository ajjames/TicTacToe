//
//  Parallax.swift
//  TicTacToe
//
//  Created by Andrew James on 1/20/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import Foundation
import UIKit

public extension UIView
{
    public func addBackgroundParallax(strength:CGFloat)
    {
        addParallax(-strength)
    }


    public func addForegroundParallax(strength:CGFloat)
    {
        addParallax(strength)
    }


    public func removeParallax()
    {
        if let effects: [UIMotionEffect] = self.motionEffects
        {
            for effect:UIMotionEffect in effects
            {
                removeMotionEffect(effect)
            }
        }
    }

    public func addParallax(amount:CGFloat)
    {
        removeParallax()

        let verticalMotionEffect:UIInterpolatingMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -amount
        verticalMotionEffect.maximumRelativeValue = amount

        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -amount
        horizontalMotionEffect.maximumRelativeValue = amount

        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        self.addMotionEffect(group)
    }
}