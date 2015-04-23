//
//  BoardSpaceView.swift
//  TicTacToe
//
//  Created by Andrew James on 1/17/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import UIKit

class BoardSpaceView: UIView
{
    weak var delegate: BoardSpaceViewDelegate!
    var tapGesture: UITapGestureRecognizer!
    let backColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
    let markerColor = UIColor.whiteColor()
    let dimmedAlpha:CGFloat = 0.3

    var marker: Marker?
    {
        didSet
        {
            updateUI()
        }
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.tapGesture = UITapGestureRecognizer(target: self, action: "didTapView")
        self.addGestureRecognizer(tapGesture)
        self.backgroundColor = backColor
        self.marker = nil
    }

    func updateUI()
    {
        alpha = 1.0
        
        if delegate.isGameOver
        {
            alpha = ( delegate.isWinningSpace(tag) ) ? 1.0 : dimmedAlpha
        }
        
        backgroundColor = (marker == nil) ? backColor : UIColor.clearColor()
        setNeedsDisplay()
    }

    func didTapView()
    {
        tapGesture.enabled = false
        if let marker:Marker = delegate.placeMarker(tag)
        {
            self.marker = marker
        }
    }

    override func drawRect(rect: CGRect)
    {
        if marker == Marker.X
        {
            var context = UIGraphicsGetCurrentContext()
            CGContextSetLineWidth(context, 5.0)
            markerColor.set()

            CGContextMoveToPoint(context, 10, 10)
            CGContextAddLineToPoint(context, frame.size.width - 10, frame.size.height - 10)
            CGContextStrokePath(context)

            CGContextMoveToPoint(context, 10, frame.size.height - 10)
            CGContextAddLineToPoint(context, frame.size.width - 10, 10)
            CGContextStrokePath(context)
        }
        if self.marker == Marker.O
        {
            var context = UIGraphicsGetCurrentContext()
            CGContextSetLineWidth(context, 5.0)
            markerColor.set()
            CGContextAddArc(context, (frame.size.width)/2, frame.size.height/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
            CGContextStrokePath(context)
        }
    }

    func fadeIn(delay:NSTimeInterval)
    {
        UIView.animateWithDuration(0.5, delay: delay, options: nil, animations: { () -> Void in
            self.alpha = 1.0
            }, completion: nil)
    }
    
    func reset()
    {
        alpha = 0.0
        tapGesture.enabled = true
        marker = nil
    }
    
    func setGameOver()
    {
        tapGesture.enabled = false
        updateUI()
    }

}
