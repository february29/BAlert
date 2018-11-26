//
//  UIView+BAlert.swift
//  BAlertDemo
//
//  Created by bai on 2017/12/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit


public typealias BAlertHandler = (_ view:UIView,_ config:BAlertConfig)->Void;

extension UIView{
    
   

    struct BRuntimeKey {
        static let b_showHandler = UnsafeRawPointer.init(bitPattern: "b_showHandler".hashValue);
        static let b_hideHandler = UnsafeRawPointer.init(bitPattern: "b_hideHandler".hashValue);
        /// ...其他Key声明
    }
    
    var b_showHandler: BAlertHandler? {
        set {
            objc_setAssociatedObject(self, BRuntimeKey.b_showHandler!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, BRuntimeKey.b_showHandler!) as? BAlertHandler
        }
    }
    
    var b_hideHandler: BAlertHandler? {
        set {
            objc_setAssociatedObject(self, BRuntimeKey.b_hideHandler!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return  objc_getAssociatedObject(self, BRuntimeKey.b_hideHandler!) as? BAlertHandler
        }
    }
    
    
    
    
    /// x
    var bAlert_x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var bAlert_y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var bAlert_height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var bAlert_width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var bAlert_size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var bAlert_centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var bAlert_centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }

    
    
    
}
