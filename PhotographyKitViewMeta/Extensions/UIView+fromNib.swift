//
//  UIView+fromNib.swift
//  PhotographyKitViewMeta
//
//  Created by peerapat atawatana on 5/19/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import Foundation

extension UIView {
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
