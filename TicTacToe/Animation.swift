//
//  Animation.swift
//  TicTacToe
//
//  Created by Andrew James on 1/18/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import Foundation

struct Animation
{
    var animations: [[Int]]
    var delayIncrement: NSTimeInterval
}

// 0 1 2
// 3 4 5
// 6 7 8
let Animations = [
    Animation(animations: [[0,1,2,3,4,5,6,7,8]], delayIncrement: 0.07), // animate front to back
    Animation(animations: [[0,1,2,3,4],[8,7,6,5]], delayIncrement: 0.2), //animate from front and end
    Animation(animations: [[0,3,6],[7,4,1],[2,5,8]], delayIncrement: 0.3), //animate left middle and right
    Animation(animations: [[0,1,2],[5,4,3],[6,7,8]], delayIncrement: 0.3), //animate top middle bottom
    Animation(animations: [[0,1,2,5,8,7,6,3,4]], delayIncrement: 0.07), //animate spiral
    Animation(animations: [[4,3,0,1,2,5,8,7,6]], delayIncrement: 0.07), //animate reverse spiral
    Animation(animations: [[3,0,1,2],[3,4,5,8],[3,6,7]], delayIncrement: 0.2), //animate left to right wipe
    Animation(animations: [[1,2,5,6],[1,4,7,8],[1,0,3]], delayIncrement: 0.2), //animate top to bottom wipe
    Animation(animations: [[0,1,2,5,8],[0,3,4,7],[0,3,6]], delayIncrement: 0.2), //animate diagonal
]