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
    let backColor = UIColor.white.withAlphaComponent(0.5)
    let markerColor = UIColor.white
    let dimmedAlpha:CGFloat = 0.3

    var marker: Marker? {
        didSet {
            updateUI()
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(tapGesture)
        self.backgroundColor = backColor
        self.marker = nil
    }

    func updateUI() {
        alpha = 1.0
        
        if delegate.isGameOver {
            alpha = ( delegate.isWinningSpace(index: tag) ) ? 1.0 : dimmedAlpha
        }
        
        backgroundColor = (marker == nil) ? backColor : .clear
        setNeedsDisplay()
    }

    @objc func didTapView() {
        tapGesture.isEnabled = false
        if let marker:Marker = delegate.placeMarker(index: tag) {
            self.marker = marker
        }
    }

    override func draw(_ rect: CGRect) {
        guard let marker = self.marker else { return }
        switch marker {
        case .x:
            let context = UIGraphicsGetCurrentContext()
            context?.setLineWidth(5.0)
            markerColor.set()
            
            context?.move(to: CGPoint(x: 10, y: 10))
            context?.addLine(to: CGPoint(x: frame.size.width - 10, y: frame.size.height - 10))
            context?.strokePath()
            
            context?.move(to: CGPoint(x: 10, y: frame.size.height - 10))
            context?.addLine(to: CGPoint(x: frame.size.width - 10, y: 10))
            context?.strokePath()
        case .o:
            let context = UIGraphicsGetCurrentContext()
            context?.setLineWidth(5.0)
            markerColor.set()
            context?.addArc(center: CGPoint(x: (frame.size.width)/2, y: frame.size.height/2), radius: (frame.size.width - 10)/2, startAngle: 0, endAngle: CGFloat.pi * 2.0, clockwise: true)
            context?.strokePath()
        }
    }

    func fadeIn(delay: TimeInterval) {
        UIView.animate(withDuration: 0.5, delay: delay, options: .curveLinear, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    func reset() {
        alpha = 0.0
        tapGesture.isEnabled = true
        marker = nil
    }
    
    func setGameOver() {
        tapGesture.isEnabled = false
        updateUI()
    }
}
