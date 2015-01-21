//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Andrew James on 1/17/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import UIKit

class GameViewController: UIViewController
{
    var game: TicTacToeGame!
    @IBOutlet var spaces: [BoardSpaceView]!
    @IBOutlet var topResetView: UIView!
    @IBOutlet var bottomResetView: UIView!
    @IBOutlet var backgroundImageView: UIImageView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        backgroundImageView.addBackgroundParallax(100.0)
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        clearBoard()
        startNewGame()
    }

    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }

    func clearBoard()
    {
        topResetView.hidden = true
        bottomResetView.hidden = true
        for space in spaces
        {
            space.game = nil
            space.alpha = 0.0
            space.marker = nil
            space.checkForWinner = self.checkForWinner
            space.updateDisplay()
        }
        view.window?.tintColor = UIColor.blueColor()
    }

    func startNewGame()
    {
        game = TicTacToeGame()
        for space in spaces
        {
            space.alpha = 0.0
            space.game = game
            space.tapGesture.enabled = true
        }
        animateNewBoard()
    }

    func checkForWinner()
    {
        if game.state == GameState.Winner
        {
            for space in spaces
            {
                space.updateDisplay()
            }
        }
        if game.state != GameState.InProgress
        {
            topResetView.hidden = false
            bottomResetView.hidden = false
        }
    }

    @IBAction func didTouchRestartButton(sender: UIButton)
    {
        clearBoard()
        startNewGame()
    }

    func animateNewBoard()
    {
        let index = Int(arc4random_uniform(UInt32(Animations.count)))
        var delayIncrement:NSTimeInterval = 0.1
        let animation = Animations[index]
        animateSpaces(animation.animations, animation.delayIncrement)
    }

    func animateSpaces(animationArray:[[Int]], _ delayIncrement:NSTimeInterval)
    {
        for array in animationArray
        {
            var delay = NSTimeInterval(0.2)
            for index in array
            {
                var space = spaces[index]
                UIView.animateWithDuration(0.5, delay: delay, options: nil, animations: { () -> Void in
                    space.alpha = 1.0
                    }, completion: nil)
                delay += delayIncrement
            }
        }
    }

}

