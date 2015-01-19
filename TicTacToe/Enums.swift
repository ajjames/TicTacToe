//
//  Enums.swift
//  TicTacToe
//
//  Created by Andrew James on 1/18/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import Foundation

public enum Row: Int
{
    case Top = 0, Middle = 1, Bottom = 2
}

public enum Column: Int
{
    case Left = 0, Middle = 1, Right = 2
}

public enum Marker: String
{
    case X = "X", O = "O"
}

public enum GameState
{
    case InProgress, Tie, Winner
}