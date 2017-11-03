//
//  ConstantUtils.swift
//  AtFirstSight
//
//  Created by iCrany on 2017/10/16.
//  Copyright © 2017 Stringstech. All rights reserved.
//

import Foundation
import UIKit

class ConstantUtils: NSObject {

    //获取状态栏高度
    @objc class func getStatusBarHeight() -> CGFloat {
        if IS_IPHONE_X {
            return 44.0
        } else {
            return 20.0
        }
    }

    //获取导航栏高度
    @objc class func getNavBarHeight() -> CGFloat {
        return 44.0//需要区分是否是大标题的状态
    }

    //获取导航栏和状态栏的高度总和
    @objc class func getStatusBarAndNavBarHeightTotalHeight() -> CGFloat {
        return ConstantUtils.getStatusBarHeight() + ConstantUtils.getNavBarHeight()
    }

    @objc class func getTabBarHeight() -> CGFloat {
        return 49.0 + ConstantUtils.getTabBarBottomSafeAreaHeight()
    }

    //底部的安全高度
    @objc class func getTabBarBottomSafeAreaHeight() -> CGFloat {
        return IS_IPHONE_X ? 34.0 : 0.0
    }
}
