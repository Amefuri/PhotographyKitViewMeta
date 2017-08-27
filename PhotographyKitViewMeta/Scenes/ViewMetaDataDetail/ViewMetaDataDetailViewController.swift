//
//  ViewMetaDataDetailViewController.swift
//  PhotographyKitViewMeta
//
//  Created by peerapat atawatana on 5/21/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import UIKit
import Hero
import MaterialMotion

// define a small helper function to add two CGPoints
func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

class ViewMetaDataDetailViewController: UIViewController {
    
    // MARK: Property
    
    var viewModel:ViewMetaDataDetailViewModelType!
    var panGR: UIPanGestureRecognizer!
    var pinchGR: UIPinchGestureRecognizer!
    var runtime:MotionRuntime!
    
    // MARK: IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var artistLabel:UILabel!
    @IBOutlet weak var cameraModelLabel:UILabel!
    @IBOutlet weak var lensModelLabel:UILabel!
    @IBOutlet weak var focalLengthLabel:UILabel!
    @IBOutlet weak var apertureLabel:UILabel!
    @IBOutlet weak var shutterSpeedLabel:UILabel!
    @IBOutlet weak var isoLabel:UILabel!
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitial()
        
        panGR = UIPanGestureRecognizer(target: self,
                                       action: #selector(handlePan(gestureRecognizer:)))
        view.addGestureRecognizer(panGR)
        
        pinchGR = UIPinchGestureRecognizer(target: self,
                                           action: #selector(handlePinch(gestureReconizer:)))
        //view.isUserInteractionEnabled = true
        view.addGestureRecognizer(pinchGR)
        
        // Store me for as long as the interactions should take effect.
        runtime = MotionRuntime(containerView: view)
        runtime.add(Scalable(), to: imageView)
        //runtime.add(Draggable(), to: imageView)
        //let draggable = Draggable()
        //runtime.add(draggable, to: imageView) {
            //$0.xLocked(to: 0)
            //$0.anchorPointAdjustment(in: self.view)
        //}
    }
    
    // MARK: Function
    
    func setupInitial() {
        guard let viewModel = viewModel else { return }
        if let placeHolderImage = viewModel.placeHolderImage {
            imageView.image     = placeHolderImage
            imageView.heroID    = viewModel.heroID
            
            print("View Frame = " + view.frame.debugDescription)
            let containerWidth  = view.frame.width
            let containerHeight = view.frame.height
            let newSize         = aspectFit(aspectRatio: CGSize(width: placeHolderImage.size.width, height: placeHolderImage.size.height),
                                            boundingSize: CGSize(width: containerWidth, height: containerHeight))
            
            print("New Size = " + newSize.debugDescription)
            
            imageView.frame     = CGRect(x: 0,
                                         y: 0,
                                         width: newSize.width,
                                         height: newSize.height)
            imageView.center    = (imageView.superview?.center)!
        }
        self.viewModel.delegate = self
    }
    
    func aspectFit(aspectRatio : CGSize, boundingSize: CGSize) -> CGSize {
        var boundingSize = boundingSize
        let mW = boundingSize.width / aspectRatio.width;
        let mH = boundingSize.height / aspectRatio.height;
        
        if( mH < mW ) {
            boundingSize.width = boundingSize.height / aspectRatio.height * aspectRatio.width;
        }
        else if( mW < mH ) {
            boundingSize.height = boundingSize.width / aspectRatio.width * aspectRatio.height;
        }
        
        return boundingSize;
    }
    
    func setupImageMetaData() {
        guard let viewModel     = viewModel else { return }
        if let artistName       = viewModel.artistName      { artistLabel.text          = "Artist Name: " + artistName }
        if let cameraModel      = viewModel.cameraModel     { cameraModelLabel.text     = "Camera Model: " + cameraModel }
        if let lensModel        = viewModel.lensModel       { lensModelLabel.text       = "Lens Model: " + lensModel }
        if let focalLength      = viewModel.focalLength     { focalLengthLabel.text     = "FocalLength: \(focalLength) mm" }
        if let aperture         = viewModel.aperture        { apertureLabel.text        = "Aperture: F/\(aperture)" }
        if let shutterSpeed     = viewModel.shutterSpeed    { shutterSpeedLabel.text    = "ShutterSpeed: " + shutterSpeed }
        if let iso              = viewModel.iso             { isoLabel.text             = "ISO: \(iso)" }
    }
    
    func setupRealImage() {
        guard let viewModel     = viewModel else { return }
        if let realImage = viewModel.realImage {
            imageView.image = realImage
        }
    }
    
    func handlePan(gestureRecognizer:UIPanGestureRecognizer) {
        // calculate the progress based on how far the user moved
        let translation = panGR.translation(in: nil)
        let progress = translation.y / 2 / view.bounds.height
        print(progress)
        switch panGR.state {
        case .began:
            // begin the transition as normal
            dismiss(animated: true, completion: nil)
        case .changed:
            // calculate the progress based on how far the user moved
            
            Hero.shared.update(progress: abs(Double(progress)))
            
            // update views' position (limited to only vertical scroll)
            let imagePosition = CGPoint(x: imageView.center.x,
                                        y: translation.y + imageView.center.y)
            /*let namePosition = CGPoint(x: nameLabel.center.x,
                                       y: translation.y + nameLabel.center.y)
            let descPosition = CGPoint(x: descriptionLabel.center.x,
                                       y: translation.y + descriptionLabel.center.y)*/
            // update views' position based on the translation
            Hero.shared.apply(modifiers: [.position(imagePosition)], to: imageView)
            //Hero.shared.apply(modifiers: [.position(namePosition)], to: nameLabel)
            //Hero.shared.apply(modifiers: [.position(descPosition)], to: descriptionLabel)
        default:
            // end or cancel the transition based on the progress and user's touch velocity
            if abs(progress + panGR.velocity(in: nil).y / view.bounds.height) > 0.3 {
                Hero.shared.end()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
    func handlePinch(gestureReconizer:UIPinchGestureRecognizer) {
        print("pinch")
        
        switch pinchGR.state {
        case .changed:
            //TODO
            print(gestureReconizer.scale)
            Hero.shared.apply(modifiers: [.scale(gestureReconizer.scale)], to: imageView)
            break
        default:
            break
        }
    }
    
}
