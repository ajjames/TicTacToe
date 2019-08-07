//
//  BoardSpaceViewDelegate.swift
//  TicTacToe
//
//  Created by Andrew James on 4/23/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import Foundation


protocol BoardSpaceViewDelegate : class {
    var isGameOver: Bool {get}
    func isWinningSpace(index: Int) -> Bool
    func placeMarker(index: Int) -> Marker?
}
