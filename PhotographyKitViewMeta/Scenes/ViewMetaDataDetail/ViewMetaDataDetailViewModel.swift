//
//  ViewMetaDataDetailViewModel.swift
//  PhotographyKitViewMeta
//
//  Created by peerapat atawatana on 5/23/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

@objc protocol ViewMetaDataDetailViewModelDelegate {
    @objc optional func didFinishFetchMetaData()
    @objc optional func didFinishLoadRealImage()
}

protocol ViewMetaDataDetailViewModelType {
    var delegate:ViewMetaDataDetailViewModelDelegate? { get set }
    var realImage:UIImage? { get }
    var photoAsset:PHAsset { get }
    var placeHolderImage:UIImage? { get }
    var heroID:String? { get }
    var artistName:String? { get }
    var cameraModel:String? { get }
    var lensModel:String? { get }
    var focalLength:String? { get }
    var aperture:String? { get }
    var shutterSpeed:String? { get }
    var iso:String? { get }
}

class ViewMetaDataDetailViewModel: ViewMetaDataDetailViewModelType {
    var delegate: ViewMetaDataDetailViewModelDelegate?
    var realImage: UIImage?
    var photoAsset:PHAsset
    var placeHolderImage:UIImage?
    var heroID:String?
    var artistName:String?
    var cameraModel:String?
    var lensModel:String?
    var focalLength:String?
    var aperture:String?
    var shutterSpeed:String?
    var iso:String?
    
    init(imageInfo:ImageInfo) {
        self.photoAsset         = imageInfo.photoAsset
        self.placeHolderImage   = imageInfo.placeHolderImage
        self.heroID             = "\(imageInfo.id)_image"
        fetchMetaData(photoAsset: self.photoAsset)
        loadRealImage(photoAsset: self.photoAsset)
    }
    
    private func loadRealImage(photoAsset:PHAsset) {
        let options             = PHImageRequestOptions()
        options.resizeMode      = .fast
        options.deliveryMode    = .opportunistic
        options.version         = .current
        options.isSynchronous   = false
        PHCachingImageManager.default().requestImage(for: photoAsset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: options, resultHandler: { (result, info) in
            self.realImage = result
            self.delegate?.didFinishLoadRealImage?()
        })
    }
    
    private func fetchMetaData(photoAsset:PHAsset) {
        photoAsset.requestMetadata(completionBlock: { (metaDatas) in
            if let metaDatas = metaDatas {
                print(metaDatas)
                if let tiff = metaDatas["{TIFF}"] as? NSDictionary {
                    if let model    = tiff["Model"] as? String  { self.cameraModel = model }
                    if let artist   = tiff["Artist"] as? String { self.artistName = artist }
                    print(tiff)
                }
                if let exif = metaDatas["{Exif}"] as? NSDictionary {
                    if let focalLength = exif["FocalLength"] as? NSNumber {
                        self.focalLength = focalLength.description
                    }
                    if let shutterSpeed = exif["ExposureTime"] as? NSNumber {
                        self.shutterSpeed = shutterSpeed.description
                    }
                    if let iso = exif["ISOSpeedRatings"] as? NSArray {
                        self.iso = (iso[0] as! NSNumber).description
                    }
                    if let fNumber = exif["FNumber"] as? NSNumber {
                        self.aperture = fNumber.description
                    }
                    print(exif)
                }
                if let exifAux = metaDatas["{ExifAux}"] as? NSDictionary {
                    if let lensModel = exifAux["LensModel"] as? String {
                        self.lensModel = lensModel
                    }
                }
                self.delegate?.didFinishFetchMetaData?()
            }
        })
    }
}
