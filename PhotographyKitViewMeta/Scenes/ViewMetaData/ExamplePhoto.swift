//
//  ExamplePhoto.swift
//  NYTPhotoViewer
//
//  Created by Mark Keefe on 3/20/15.
//  Copyright (c) 2015 The New York Times. All rights reserved.
//

import UIKit
import NYTPhotoViewer

class ExamplePhoto: NSObject, NYTPhoto {

    var indexPath: IndexPath
    var image: UIImage?
    var imageData: Data?
    var placeholderImage: UIImage?
    let attributedCaptionTitle: NSAttributedString?
    var attributedCaptionSummary: NSAttributedString? = NSAttributedString(string: "summary string", attributes: [NSForegroundColorAttributeName: UIColor.gray])
    let attributedCaptionCredit: NSAttributedString? = NSAttributedString(string: "credit", attributes: [NSForegroundColorAttributeName: UIColor.darkGray])

    init(image: UIImage? = nil, imageData: NSData? = nil, attributedCaptionTitle: NSAttributedString, indexPath: IndexPath, placeholderImage:UIImage) {
        self.indexPath = indexPath
        self.image = image
        self.imageData = imageData as Data?
        self.attributedCaptionTitle = attributedCaptionTitle
        self.placeholderImage = placeholderImage
        super.init()
    }

}
