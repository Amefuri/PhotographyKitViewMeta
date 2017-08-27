//
//  ImageInfo.swift
//  PhotographyKitViewMeta
//
//  Created by peerapat atawatana on 5/21/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import UIKit
import Photos

class ImageInfo {
    let id:String
    let photoAsset:PHAsset
    let placeHolderImage:UIImage?
    
    init(id:String, photoAsset:PHAsset, placeHolderImage:UIImage?) {
        self.id                 = id
        self.photoAsset         = photoAsset
        self.placeHolderImage   = placeHolderImage
    }
}
