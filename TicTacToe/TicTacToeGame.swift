//
//  TicTacToeGame.swift
//  TicTacToe
//
//  Created by Andrew James on 1/17/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import Foundation
import UIKit

public class TicTacToeGame: CustomStringConvertible
{
    // Each spot on the board has 
    // one of the possible values: 
    //      .X   .O   nil
    public var board: [Marker?]
    // 0 1 2
    // 3 4 5
    // 6 7 8
    public var marker = Marker.X  // X always go first!
    public var state = GameState.InProgress
    public var winner: Marker?
    public var winningBoard: [Bool]!
    public let lines = [
        [0,1,2], // top row
        [3,4,5], // middle row
        [6,7,8], // bottom row
        [0,3,6], // left column
        [1,4,7], // middle column
        [2,5,8], // right column
        [0,4,8], // diagonal: \
        [6,4,2]] // diagonal: /

    public init()
    {
        board = [nil,nil,nil, nil,nil,nil, nil,nil,nil]
    }
    
    public func placeMarker(space:Space) -> Bool
    {
        let index = Int(space.column.rawValue + (space.row.rawValue * 3))
        return placeMarker(index)
    }

    public func placeMarker(index:Int) -> Bool
    {
        if index < 0 || index > 8
        {
            return false
        }
        if board[index] == nil && state == .InProgress
        {
            board[index] = marker
            checkForWinner()
            nextTurn()
            return true
        }
        return false
    }

    private func checkForWinner()
    {
        winningBoard = [false,false,false, false,false,false, false,false,false]
        var foundANilSpace = false
        for line in lines
        {
            let indexOfA = line[0]
            let indexOfB = line[1]
            let indexOfC = line[2]
            let markerA = board[indexOfA]
            let markerB = board[indexOfB]
            let markerC = board[indexOfC]
            if markerA != nil && markerB != nil && markerC != nil
            {
                if marker == markerA! && markerA! == markerB! && markerB! == markerC!
                {
                    winner = marker
                    state = GameState.Winner
                    winningBoard[indexOfA] = true
                    winningBoard[indexOfB] = true
                    winningBoard[indexOfC] = true
                }
            }
            else
            {
                foundANilSpace = true
            }
        }
        if !foundANilSpace && state != .Winner
        {
            state = .Tie
        }
    }

    private func nextTurn()
    {
        if winner == nil
        {
            marker = (marker == .X) ? .O : .X
        }
    }

    public var description: String
    {
        var boardDescription = ""
        for space in board
        {
            boardDescription += space?.rawValue ?? " "
        }
        return boardDescription
    }

}