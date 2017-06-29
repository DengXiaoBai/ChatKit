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
    class func defaultFont(ofSize fontSize: CGFloat) -> UIFont {
//        if UIDevice.is_iOS_9_or_later() {
            let font = UIFont(name: "PingFangSC-Regular", size: fontSize)
            guard let _ = font else {
                return UIFont.systemFont(ofSize: fontSize)
            }

            return font!
//        } else {
//            return UIFont.systemFont(ofSize: fontSize)
//        }
    }

    class func mediumDefaultFont(ofSize fontSize: CGFloat) -> UIFont {
//        if UIDevice.is_iOS_9_or_later() {
            let font = UIFont(name: "PingFangSC-Medium", size: fontSize)
            guard let _ = font else {
                return UIFont.systemFont(ofSize: fontSize)
            }

            return font!
//        } else {
//            return UIFont.systemFont(ofSize: fontSize)
//        }

    }

    class func boldDefaultFont(ofSize fontSize: CGFloat) -> UIFont {
//        if UIDevice.is_iOS_9_or_later() {
            let font = UIFont(name: "PingFangSC-Semibold", size: fontSize)
            guard let _ = font else {
                return UIFont.boldSystemFont(ofSize: fontSize)
            }

            return font!
//        } else {
//            return UIFont.boldSystemFont(ofSize: fontSize)
//        }
    }
}
