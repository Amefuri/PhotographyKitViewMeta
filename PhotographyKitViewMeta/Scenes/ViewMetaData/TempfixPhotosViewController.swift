//
//  TempfixPhotosViewController.swift
//  PhotographyKitViewMeta
//
//  Created by peerapat atawatana on 5/18/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import NYTPhotoViewer

class TempfixPhotosViewController : NYTPhotosViewController {
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show statusbar after dismissal again
        UIApplication.shared.isStatusBarHidden = false
    }*/
    
    var shouldHideStatusBar = false
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
}
