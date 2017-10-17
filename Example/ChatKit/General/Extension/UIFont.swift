//
//  UIFont.swift
//  ChatKit
//
//  Created by iCrany on 2017/6/20.
//  Copyright (c) 2017 iCrany. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
/**
    *  PingFang SC
    * - PingFangSC-Ultralight
    * - PingFangSC-Regular
    * - PingFangSC-Semibold
    * - PingFangSC-Thin
    * - PingFangSC-Light
    * - PingFangSC-Medium
    **/

    // APP默认字体
    @objc class func defaultFont(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "PingFangSC-Regular", size: fontSize)
        guard let _ = font else {
            return UIFont.systemFont(ofSize: fontSize)
        }

        return font!
    }

    @objc class func mediumDefaultFont(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "PingFangSC-Medium", size: fontSize)
        guard let _ = font else {
            return UIFont.systemFont(ofSize: fontSize)
        }

        return font!
    }

    @objc class func boldDefaultFont(ofSize fontSize: CGFloat) -> UIFont {
        let font = UIFont(name: "PingFangSC-Semibold", size: fontSize)
        guard let _ = font else {
            return UIFont.boldSystemFont(ofSize: fontSize)
        }

        return font!
    }
}
