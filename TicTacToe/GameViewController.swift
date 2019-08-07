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

    lazy var customImagePath: URL = {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let path = documentsDirectoryURL.appendingPathComponent("custombackground.jpg")
        return path
    }()

    //MARK: view controller

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImageFeatures()
        loadBackgroundImage()
        setupBoard()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if game == nil
        {
            startNewGame()
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    //MARK: private
    
    private func setupBoard() {
        for space in spaces {
            space.delegate = self
        }
    }

    private func startNewGame() {
        view.window?.tintColor = .blue
        game = TicTacToeGame()
        for space in spaces {
            space.reset()
        }
        animateNewBoard()
    }

    private func animateNewBoard() {
        let index = Int(arc4random_uniform(UInt32(Animations.count)))
        let animation = Animations[index]
        animateSpaces(array: animation.animations, delay: animation.delayIncrement)
    }

    private func animateSpaces(array animationArray: [[Int]], delay delayIncrement: TimeInterval) {
        for array in animationArray {
            var delay = TimeInterval(0.2)
            for index in array {
                let space = spaces[index]
                UIView.animate(withDuration: 0.5, delay: delay, options: .curveLinear, animations: {
                    space.alpha = 1.0
                }, completion: nil)
                delay += delayIncrement
            }
        }
    }
    
    private func setGameOverBoard() {
        for space in spaces {
            space.setGameOver()
        }
    }

    //MARK: BoardSpaceViewDelegate
    
    
    var isGameOver: Bool {
        return game.state != .inProgress
    }
    
    
    func isWinningSpace(index: Int) -> Bool {
        return game.winningBoard[index]
    }
    
    func placeMarker(index: Int) -> Marker? {
        var nextMarker:Marker? = game.marker
        if !game.placeMarker(atIndex: index) {
            nextMarker = nil
        }
        
        if isGameOver {
            setGameOverBoard()
        }
        
        return nextMarker
    }
    
    //MARK: Background Image Features
    
    private func setupBackgroundImageFeatures() {
        photoSelectView.alpha = 0
        whiteSelectionView.layer.cornerRadius = 10
        whiteSelectionView.layer.shadowColor = UIColor.black.cgColor
        whiteSelectionView.layer.shadowOffset = CGSize(width: -2, height: -2)
        whiteSelectionView.layer.shadowRadius = 5
        defautBackgroundButtonImage.layer.cornerRadius = 5
        backgroundImageView.addBackgroundParallax(50.0)
    }
    
    private func saveImage(_ image:UIImage) {
        let data = image.jpegData(compressionQuality: 1.0)!
        try? data.write(to: customImagePath)
    }
    
    private func loadBackgroundImage() {
        if let image = UIImage(contentsOfFile: customImagePath.path) {
            backgroundImageView.image = image
        }
    }
    
    private func hideCameraButton() {
        cameraButtonWidthConstraint.constant = 0.0
        cameraButtonLeadingConstraint.constant = 0.0
        cameraButton.isHidden = true
        photoSelectView.setNeedsUpdateConstraints()
    }

    private func showCameraButton() {
        cameraButtonWidthConstraint.constant = 60.0
        cameraButtonLeadingConstraint.constant = 8.0
        cameraButton.isHidden = false
        photoSelectView.setNeedsUpdateConstraints()
    }

    //MARK: IB
    @IBAction func didTapBackground(_ sender: UITapGestureRecognizer) {
        if game.state != .inProgress {
            startNewGame()
        }
    }

    @IBAction func didTwoTouch(_ sender: UITapGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showCameraButton()
        } else {
            hideCameraButton()
        }

        photoSelectView.alpha = 0
        photoSelectView.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)

        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: { () -> Void in
            self.photoSelectView.alpha = 1.0
            self.photoSelectView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }

    @IBAction func didTapDismiss(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: { [weak self] in
            self?.photoSelectView.alpha = 0.0
            self?.photoSelectView.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        }, completion: nil)
    }

    @IBAction func didTapPhoto(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
        didTapDismiss(self)
    }

    @IBAction func didTapDefaultBackroundImage(sender: UIButton) {
        backgroundImageView.image = UIImage(named: "background")
        didTapDismiss(self)
    }

    @IBAction func didTapCamera(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        self.present(picker, animated: true)
        didTapDismiss(self)
    }

    //MARK: UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            backgroundImageView.image = image
            saveImage(image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

