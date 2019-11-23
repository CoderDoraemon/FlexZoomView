//
//  FlexZoomView.swift
//  FlexZoomView
//
//  Created by apple on 2019/11/22.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

public enum HeaderPosition {
    case fullScreenTop
    case underNavigationBar
}

class FlexZoomView: UIView {
    
    var imageView : UIImageView = UIImageView()
    fileprivate var contentSize = CGSize.zero
    fileprivate var topInset : CGFloat = 0
    fileprivate var options: HeaderPosition = .fullScreenTop
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    fileprivate func commonInit() {
        imageView.backgroundColor = UIColor.orange
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        addSubview(imageView)
    }
}

extension FlexZoomView {
    
    // MARK: Public
    
    /// 初始化当前View和ImageView的尺寸
    /// - Parameters:
    ///   - headerSize: 当前View的尺寸
    ///   - imageSize: ImageView的尺寸
    ///   - controller: 当前控制器
    ///   - position: 是否在导航下面
    func flexZoomHeaderSize(headerSize: CGSize, imageSize: CGSize, controller: UIViewController, position: HeaderPosition) {
        
        
        var status_height: CGFloat = 0
        
        if #available(iOS 13.0, *) {
            status_height = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            status_height = UIApplication.shared.statusBarFrame.height
        }
        
        let navi_height = controller.navigationController?.navigationBar.frame.size.height ?? 44
        
        self.options = position
        
        if position == HeaderPosition.fullScreenTop {
            controller.automaticallyAdjustsScrollViewInsets = false
        }
        
        if position == HeaderPosition.underNavigationBar {
            if let translucent = controller.navigationController?.navigationBar.isTranslucent {
                if translucent {
                    topInset += status_height + navi_height
                }
            }
        }
        
        imageView.frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        contentSize = imageSize
        self.frame = CGRect(x: 0, y: 0, width: headerSize.width, height: headerSize.height)
    }
    
    /// 根据UIScrollView偏移量修改图片放大
    /// - Parameter scrollView: scrollView
    func updateScrollViewOffset(_ scrollView: UIScrollView) {
        
        if imageView == nil { return }
        var scrollOffset : CGFloat = scrollView.contentOffset.y
        scrollOffset += topInset
        
        if scrollOffset < 0 {
            imageView.frame = CGRect(x: scrollOffset ,y: scrollOffset, width: contentSize.width - (scrollOffset * 2) , height: contentSize.height - scrollOffset);
        } else {
            imageView.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height);
        }
    }
    
}

