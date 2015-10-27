//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Andrew James on 1/17/15.
//  Copyright (c) 2015 Andrew James. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, BoardSpaceViewDelegate
{
    //MARK: properties

    var game: TicTacToeGame!
    @IBOutlet var spaces: [BoardSpaceView]!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var whiteSelectionView: UIView!
    @IBOutlet var photoSelectView: UIView!
    @IBOutlet var defautBackgroundButtonImage: UIImageView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var cameraButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet var cameraButtonLeadingConstraint: NSLayoutConstraint!

    lazy var customImagePath: String = { ()->String in
        
        let documentsDirectoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        let path = documentsDirectoryURL.URLByAppendingPathComponent("custombackground.jpg").path!
        return path
        }()

    //MARK: view controller

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupBackgroundImageFeatures()
        loadBackgroundImage()
        setupBoard()
    }

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        if game == nil
        {
            startNewGame()
        }
    }

    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }

    //MARK: private
    
    private func setupBoard()
    {
        for space in spaces
        {
            space.delegate = self
        }
    }

    private func startNewGame()
    {
        view.window?.tintColor = UIColor.blueColor()
        game = TicTacToeGame()
        for space in spaces
        {
            space.reset()
        }
        animateNewBoard()
    }

    private func animateNewBoard()
    {
        let index = Int(arc4random_uniform(UInt32(Animations.count)))
        let animation = Animations[index]
        animateSpaces(animation.animations, animation.delayIncrement)
    }

    private func animateSpaces(animationArray:[[Int]], _ delayIncrement:NSTimeInterval)
    {
        for array in animationArray
        {
            var delay = NSTimeInterval(0.2)
            for index in array
            {
                let space = spaces[index]
                UIView.animateWithDuration(0.5, delay: delay, options:.CurveLinear, animations: { () -> Void in
                    space.alpha = 1.0
                    }, completion: nil)
                delay += delayIncrement
            }
        }
    }
    
    private func setGameOverBoard()
    {
        for space in spaces
        {
            space.setGameOver()
        }
    }

    //MARK: BoardSpaceViewDelegate
    
    
    var isGameOver: Bool
    {
        get
        {
            return game.state != .InProgress
        }
    }
    
    
    func isWinningSpace(index: Int) -> Bool
    {
        return game.winningBoard[index]
    }
    
    func placeMarker(index:Int) -> Marker?
    {
        var nextMarker:Marker? = game.marker
        if !game.placeMarker(index)
        {
            nextMarker = nil
        }
        
        if isGameOver
        {
            setGameOverBoard()
        }
        
        return nextMarker
    }
    
    //MARK: Background Image Features
    
    private func setupBackgroundImageFeatures()
    {
        photoSelectView.alpha = 0
        whiteSelectionView.layer.cornerRadius = 10
        whiteSelectionView.layer.shadowColor = UIColor.blackColor().CGColor
        whiteSelectionView.layer.shadowOffset = CGSize(width: -2, height: -2)
        whiteSelectionView.layer.shadowRadius = 5
        defautBackgroundButtonImage.layer.cornerRadius = 5
        backgroundImageView.addBackgroundParallax(50.0)
    }
    
    private func saveImage(image:UIImage)
    {
        let data = UIImageJPEGRepresentation(image, 1.0)!
        data.writeToFile(customImagePath, atomically: true)
    }
    
    private func loadBackgroundImage()
    {
        if let image = UIImage(contentsOfFile: customImagePath)
        {
            backgroundImageView.image = image
        }
    }
    
    private func hideCameraButton()
    {
        cameraButtonWidthConstraint.constant = 0.0
        cameraButtonLeadingConstraint.constant = 0.0
        cameraButton.hidden = true
        photoSelectView.setNeedsUpdateConstraints()
    }

    private func showCameraButton()
    {
        cameraButtonWidthConstraint.constant = 60.0
        cameraButtonLeadingConstraint.constant = 8.0
        cameraButton.hidden = false
        photoSelectView.setNeedsUpdateConstraints()
    }

    //MARK: IB

    @IBAction func didTapBackground(sender: UITapGestureRecognizer)
    {
        if game.state != .InProgress
        {
            startNewGame()
        }
    }

    @IBAction func didTwoTouch(sender: UITapGestureRecognizer)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            showCameraButton()
        } else {
            hideCameraButton()
        }

        photoSelectView.alpha = 0
        photoSelectView.transform = CGAffineTransformMakeScale(0.25, 0.25)

        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.photoSelectView.alpha = 1.0
            self.photoSelectView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }, completion: nil)
    }

    @IBAction func didTapDismiss(sender: AnyObject)
    {
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.photoSelectView.alpha = 0.0
            self.photoSelectView.transform = CGAffineTransformMakeScale(0.25, 0.25)
            }, completion: nil)
    }

    @IBAction func didTapPhoto(sender: UIButton)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(picker, animated: true) { () -> Void in
        }
        didTapDismiss(self)
    }

    @IBAction func didTapDefaultBackroundImage(sender: UIButton)
    {
        backgroundImageView.image = UIImage(named: "background")
        didTapDismiss(self)
    }

    @IBAction func didTapCamera(sender: UIButton)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Photo
        self.presentViewController(picker, animated: true) { () -> Void in
        }
        didTapDismiss(self)
    }

    //MARK: UIImagePickerControllerDelegate

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            backgroundImageView.image = image
            saveImage(image)
        }
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

}

