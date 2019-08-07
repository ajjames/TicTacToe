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

    func test_NewBoard()
    {
        let game = TicTacToeGame()

        let result = game.description
        let expected = "         "
        XCTAssertEqual(result, expected)
        XCTAssertEqual(game.marker, .x)
        XCTAssertEqual(game.state, .inProgress)
        XCTAssertTrue(game.winner == nil)
    }

    func test_BoardMovement()
    {
        let game = TicTacToeGame()

        XCTAssertTrue(game.placeMarker(onSpace: Space(.top, .left)))
        XCTAssertEqual(game.description, "X        ")
        XCTAssertTrue(game.marker == .o)

        XCTAssertTrue(game.placeMarker(onSpace: Space(.middle, .middle)))
        XCTAssertEqual(game.description, "X   O    ")
        XCTAssertTrue(game.marker == .x)

        //should not be able to move to the same space
        XCTAssertFalse(game.placeMarker(onSpace: Space(.middle, .middle)))
        XCTAssertEqual(game.description, "X   O    ")
        XCTAssertTrue(game.marker == .x)

        XCTAssertTrue(game.placeMarker(onSpace: Space(.middle, .left)))
        XCTAssertEqual(game.description, "X  XO    ")
        XCTAssertTrue(game.marker == .o)

        XCTAssertTrue(game.placeMarker(onSpace: Space(.middle, .right)))
        XCTAssertEqual(game.description, "X  XOO   ")
        XCTAssertTrue(game.marker == .x)
        XCTAssertEqual(game.state, GameState.inProgress)
        XCTAssertTrue(game.winner == nil)

        XCTAssertTrue(game.placeMarker(onSpace: Space(.bottom, .left)))
        XCTAssertEqual(game.description, "X  XOOX  ")
        XCTAssertTrue(game.marker == .x)
        XCTAssertTrue(game.state == .winner)
        XCTAssertTrue(game.winner == .x)
    }

}
