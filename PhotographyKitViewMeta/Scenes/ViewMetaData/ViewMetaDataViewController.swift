//
//  ViewMetaDataViewController.swift
//  PhotographyKitViewMeta
//
//  Created by peerapat atawatana on 5/16/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import UIKit
import ImageIO
import Photos
import GreedoLayout

class ViewMetaDataViewController: UIViewController {
    
    // MARK: Property
    
    var assetFetchResults:PHFetchResult<PHAsset>? = nil
    var selectedItemIndex:IndexPath = IndexPath.init()
    
    lazy var collectionViewSizeCalculator:GreedoCollectionViewLayout = {
        if let calculator = GreedoCollectionViewLayout(collectionView: self.collectionView) {
            calculator.dataSource = self
            return calculator
        }
        return GreedoCollectionViewLayout()
    }()
    
    // MARK: IBOutlet
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    // MARK: IBAction
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*if let url = NSURL(string: "http://jwphotographic.co.uk/Images/1.jpg") {
            if let imageSource = CGImageSourceCreateWithURL(url, nil) {
                let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil)
                if let dict = imageProperties as? [String: Any] {
                    print(dict)
                }
            }
        }*/
        
        self.collectionViewSizeCalculator.rowMaximumHeight = self.collectionView.bounds.height / 3
        self.collectionViewSizeCalculator.fixedHeight = false
        //automaticallyAdjustsScrollViewInsets = false
        
        // Configure spacing between cells
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 5.0, right: 5.0)
        collectionView.collectionViewLayout = layout

        print("xx = " + collectionView.bounds.width.description)
        
        collectionView.dataSource = self
        
        
        // Request permission
        
        // Get the current authorization state.
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            // Access has been granted.
            self.retrieveImagesFromDevice()
        }
            
        else if (status == PHAuthorizationStatus.denied) {
            // Access has been denied.
        }
            
        else if (status == PHAuthorizationStatus.notDetermined) {
            
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized) {

                    // Retrive image from gallery
                    self.retrieveImagesFromDevice()
                }
                else {
                    
                }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewMetaDataDetailViewController {
            if let asset = assetFetchResults?[selectedItemIndex.item] {
                if let cell = collectionView.cellForItem(at: selectedItemIndex) as? ImageCollectionViewCell {
                    let imageInfo = ImageInfo(id: selectedItemIndex.item.description, photoAsset: asset, placeHolderImage: cell.imageView.image)
                    vc.viewModel = ViewMetaDataDetailViewModel(imageInfo: imageInfo)
                }
            }
            
        }
    }
    
    // MARK: Private
    
    func retrieveImagesFromDevice() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        assetFetchResults = PHAsset.fetchAssets(with: allPhotosOptions)
        collectionView.reloadData()
    }
   
}

