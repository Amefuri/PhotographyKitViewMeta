//
//  ViewMetaDataPhotoViewerController.swift
//  PhotographyKitViewMeta
//
//  Created by peerapat atawatana on 5/18/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import NYTPhotoViewer

extension ViewMetaDataViewController: NYTPhotosViewControllerDelegate {
    func photosViewController(_ photosViewController: NYTPhotosViewController, referenceViewFor photo: NYTPhoto) -> UIView? {
        return (self.collectionView.cellForItem(at: (photo as! ExamplePhoto).indexPath ) as! ImageCollectionViewCell).imageView
    }
    
    func photosViewController(_ photosViewController: NYTPhotosViewController, captionViewFor photo: NYTPhoto) -> UIView? {
        /*let customView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        customView.backgroundColor = .red
        return customView*/
      
        let label = UILabel()
        label.text = "Custom Caption View"
        label.textColor = .white
        label.backgroundColor = .red
        //label.intrinsicContentSize = 500
        //label.frame.size = CGSize(width: label.frame.size.width, height: 500)
        //label.bounds = CGRect(x: 0, y: 0, width: label.bounds.width, height: 500)
        return label
    }
    
    /*func photosViewController(_ photosViewController: NYTPhotosViewController, titleFor photo: NYTPhoto, at photoIndex: UInt, totalPhotoCount: UInt) -> String? {
        
        if let asset = self.assetFetchResults?[(photo as! ExamplePhoto).indexPath.item] {
            asset.requestMetadata(completionBlock: { (metaDatas) in
                if let metaDatas = metaDatas {
                    return metaDatas.count.description
                    print(metaDatas)
                }
            })
        }
        
        return ""
    }*/
}
