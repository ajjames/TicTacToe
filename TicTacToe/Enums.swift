//
//  Enums.swift
//  TicTacToe
//
//  Created by Andrew James on 1/18/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import Foundation

public enum Row: Int {
    case top = 0
    case middle = 1
    case bottom = 2
}

public enum Column: Int {
    case left = 0
    case middle = 1
    case right = 2
}

public enum Marker: String {
    case x = "X"
    case o = "O"
}

public enum GameState {
    case inProgress
    case tie
    case winner
}
