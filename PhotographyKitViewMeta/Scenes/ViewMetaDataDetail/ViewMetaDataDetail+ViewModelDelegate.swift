//
//  ViewMetaDataDetail+ViewModelDelegate.swift
//  PhotographyKitViewMeta
//
//  Created by peerapat atawatana on 5/23/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import Foundation

extension ViewMetaDataDetailViewController: ViewMetaDataDetailViewModelDelegate {
    func didFinishFetchMetaData() {
        setupImageMetaData()
    }
    
    func didFinishLoadRealImage() {
        setupRealImage()
    }
}
