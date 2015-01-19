//
//  Space.swift
//  TicTacToe
//
//  Created by Andrew James on 1/18/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import Foundation

public struct Space
{
    var row: Row
    var column: Column

    public init(_ row:Row, _ column:Column)
    {
        self.row = row
        self.column = column
    }
}
