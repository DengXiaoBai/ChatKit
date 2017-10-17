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
    class func getStatusBarHeight() -> CGFloat {
        if IS_IPHONE_X {
            return 44.0
        } else {
            return 20.0
        }
    }

    //获取导航栏高度
    class func getNavBarHeight() -> CGFloat {
        return 44.0//需要区分是否是大标题的状态
    }

    //获取导航栏和状态栏的高度总和
    class func getStatusBarAndNavBarHeightTotalHeight() -> CGFloat {
        return ConstantUtils.getStatusBarHeight() + ConstantUtils.getNavBarHeight()
    }

    class func getTabBarHeight() -> CGFloat {
        return IS_IPHONE_X ? 69.0 : 49.0
    }
}
