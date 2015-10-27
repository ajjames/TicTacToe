//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Andrew James on 1/17/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import UIKit
import XCTest
import TicTacToe

class BoardTests: XCTestCase
{

    func testNewBoard()
    {
        let game = TicTacToeGame()

        let result = game.description
        let expected = "         "
        XCTAssertEqual(result, expected)
        XCTAssertEqual(game.marker, Marker.X)
        XCTAssertEqual(game.state, GameState.InProgress)
        XCTAssertTrue(game.winner == nil)
    }

    func testBoardMovement()
    {
        let game = TicTacToeGame()

        XCTAssertTrue(game.placeMarker(Space(.Top, .Left)))
        XCTAssertEqual(game.description, "X        ")
        XCTAssertTrue(game.marker == Marker.O)

        XCTAssertTrue(game.placeMarker(Space(.Middle, .Middle)))
        XCTAssertEqual(game.description, "X   O    ")
        XCTAssertTrue(game.marker == Marker.X)

        //should not be able to move to the same space
        XCTAssertFalse(game.placeMarker(Space(.Middle, .Middle)))
        XCTAssertEqual(game.description, "X   O    ")
        XCTAssertTrue(game.marker == Marker.X)

        XCTAssertTrue(game.placeMarker(Space(.Middle, .Left)))
        XCTAssertEqual(game.description, "X  XO    ")
        XCTAssertTrue(game.marker == Marker.O)

        XCTAssertTrue(game.placeMarker(Space(.Middle, .Right)))
        XCTAssertEqual(game.description, "X  XOO   ")
        XCTAssertTrue(game.marker == Marker.X)
        XCTAssertEqual(game.state, GameState.InProgress)
        XCTAssertTrue(game.winner == nil)

        XCTAssertTrue(game.placeMarker(Space(.Bottom, .Left)))
        XCTAssertEqual(game.description, "X  XOOX  ")
        XCTAssertTrue(game.marker == Marker.X)
        XCTAssertTrue(game.state == GameState.Winner)
        XCTAssertTrue(game.winner == Marker.X)
    }

}
