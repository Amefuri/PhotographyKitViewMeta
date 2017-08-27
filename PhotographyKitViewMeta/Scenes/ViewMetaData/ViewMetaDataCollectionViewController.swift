//
//  ViewMetaDataCollectionViewController.swift
//  PhotographyKitViewMeta
//
//  Created by peerapat atawatana on 5/17/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import UIKit
import Photos
import GreedoLayout
import NYTPhotoViewer
import Hero

extension ViewMetaDataViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GreedoCollectionViewLayoutDataSource {
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItemIndex = indexPath
        performSegue(withIdentifier: "showViewMetaDataDetail", sender: self)
        
        
        /*if let asset = assetFetchResults?[indexPath.item] {
            let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
           
            let options = PHImageRequestOptions()
            options.resizeMode = .fast
            options.deliveryMode = .opportunistic
            options.version = .current
            options.isSynchronous = false
            
            let photo = ExamplePhoto(image: nil, imageData: nil, attributedCaptionTitle: NSAttributedString(string: "Title"), indexPath: indexPath, placeholderImage: cell.imageView.image!)
            
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let vc = storyboard.instantiateViewController(withIdentifier: "TempfixPhotosViewController") as! TempfixPhotosViewController
            
            let photoViewerController = TempfixPhotosViewController(photos: [photo], initialPhoto: nil, delegate: self)
            self.present(photoViewerController, animated: true) {
                photoViewerController.shouldHideStatusBar = true
                photoViewerController.setNeedsStatusBarAppearanceUpdate()
            }
            
            PHCachingImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: options, resultHandler: { (result, info) in
                photo.image = result
                //photo.attributedCaptionSummary = NSAttributedString(string: "TEST")
                photoViewerController.updateImage(for: photo)
                
                
            })
            
        }*/
        
        
        
        /*if let asset = assetFetchResults?[indexPath.item] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
            cell.backgroundColor = .clear
            
            let options = PHImageRequestOptions()
            options.resizeMode = .fast
            options.deliveryMode = .opportunistic
            options.version = .current
            options.isSynchronous = false
            
            //let scale = min(2, UIScreen.main.scale)
            //let requestImageSize = CGSize(width: cell.bounds.width * scale, height: cell.bounds.height * scale)
            PHCachingImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: options, resultHandler: { (result, info) in
                let photo = ExamplePhoto(image: result, imageData: nil, attributedCaptionTitle: NSAttributedString(string: ""), indexPath: indexPath)
                //let photoViewerConstroller = NYTPhotosViewController(photos: [photo])
                //photoViewerConstroller.modalTransitionStyle = .flipHorizontal
                let photoViewerController = TempfixPhotosViewController(photos: [photo], initialPhoto: nil, delegate: self)
                self.present(photoViewerController, animated: true) {
                    photoViewerController.shouldHideStatusBar = true
                    photoViewerController.setNeedsStatusBarAppearanceUpdate()
                }
            })
        }*/
        
        /*let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        let photo = ExamplePhoto(image: cell.imageView.image, imageData: nil, attributedCaptionTitle: NSAttributedString(string: ""))
        let photoViewerConstroller = NYTPhotosViewController(photos: [photo])
        self.present(photoViewerConstroller, animated: true, completion: nil)*/
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assetFetchResults != nil ? assetFetchResults!.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let asset = assetFetchResults?[indexPath.item] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
            cell.backgroundColor = .clear
            
            
            if let location = asset.location {
                print(location.coordinate.latitude.description + " / " + location.coordinate.longitude.description)
            }
            // Request Geolocation
            
            let options = PHImageRequestOptions()
            options.resizeMode = .fast
            options.deliveryMode = .opportunistic
            options.version = .current
            options.isSynchronous = false
            
            let scale = min(2, UIScreen.main.scale)
            let requestImageSize = CGSize(width: cell.bounds.width * scale, height: cell.bounds.height * scale)
            PHCachingImageManager.default().requestImage(for: asset, targetSize: requestImageSize, contentMode: .aspectFit, options: options, resultHandler: { (result, info) in
                cell.imageView.image = result
                cell.imageView.heroID = "\(indexPath.item)_image"
                //cell.heroModifiers = [.timingFunction(CAMediaTimingFunction(controlPoints: 0.0, 0.0, 0.2, 1))]
                cell.imageView.heroModifiers = [.fade, .scale(0.5)]
                cell.imageView.isOpaque = true
            })
           
            
            
            //PHContentEditingInputRequestOptions
            //asset.requestMetadata(with: <#T##PHContentEditingInputRequestOptions!#>, completionBlock: <#T##PHAssetMetadataBlock!##PHAssetMetadataBlock!##([AnyHashable : Any]?) -> Void#>)
            /*asset.requestMetadata(completionBlock: { (metaDatas) in
                
                
                if let metaDatas = metaDatas {
                    if let tiff = metaDatas["{TIFF}"] as? NSDictionary {
                        if let artist = tiff["Artist"] as? String {
                            cell.artistLabel.text = artist
                        }
                        else {
                            cell.artistLabel.text = ""
                        }
                        
                        if let model = tiff["Model"] as? String {
                            cell.modelLabel.text = model
                        }
                        else {
                            cell.modelLabel.text = ""
                        }
                        
                        //print(tiff)
                    }
                    
                }
                
                
            })*/
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionViewSizeCalculator.sizeForPhoto(at: indexPath)
    }
    
    // MARK: GreedoCollectionViewLayoutDataSource
    
    func greedoCollectionViewLayout(_ layout: GreedoCollectionViewLayout!, originalImageSizeAt indexPath: IndexPath!) -> CGSize {
        if indexPath.item < (self.assetFetchResults?.count) ?? 0 {
            if let asset = self.assetFetchResults?[indexPath.item] {
                return CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
            }
        }
        return CGSize(width: 0.1, height: 0.1)
        //return CGSize(width: 1000.0, height: 1000.0)
    }
    
    /*#pragma mark - <UICollectionViewDelegateFlowLayout>
    
    - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
    {
    return [self.collectionViewSizeCalculator sizeForPhotoAtIndexPath:indexPath];
    }
    
    #pragma mark - <GreedoCollectionViewLayoutDataSource>
    
    - (CGSize)greedoCollectionViewLayout:(GreedoCollectionViewLayout *)layout originalImageSizeAtIndexPath:(NSIndexPath *)indexPath
    {
    // Return the image size to GreedoCollectionViewLayout
    if (indexPath.item < self.assetFetchResults.count) {
    PHAsset *asset = self.assetFetchResults[indexPath.item];
    return CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    }
    
    return CGSizeMake(0.1, 0.1);
    }
    
    #pragma mark - Lazy Loading
    
    - (GreedoCollectionViewLayout *)collectionViewSizeCalculator
    {
    if (!_collectionViewSizeCalculator) {
    _collectionViewSizeCalculator = [[GreedoCollectionViewLayout alloc] initWithCollectionView:self.collectionView];
    _collectionViewSizeCalculator.dataSource = self;
    }
    
    return _collectionViewSizeCalculator;
    }*/
}
