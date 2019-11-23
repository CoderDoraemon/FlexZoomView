//
//  Global.swift
//  FlexZoomView
//
//  Created by apple on 2019/11/22.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

var isIPhoneX: Bool {
    if #available(iOS 11, *) {
          guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
              return false
          }
          
          if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
              print(unwrapedWindow.safeAreaInsets)
              return true
          }
    }
    return false
}

/// iPhone X 系列 顶部适配
//statusBar Height
let kTopStatusBarHeight: CGFloat = (isIPhoneX ? 44 : 20)
//nav Height
let  kSafeArea_TopHeight: CGFloat = (kTopStatusBarHeight + 44)

/// iPhone X 系列底部适配
//底部安全距离
let kSafeArea_BottomHeight: CGFloat = (isIPhoneX ? 34 : 0)
//TabBar Height
let kBottomTabBarHeight: CGFloat = 49
