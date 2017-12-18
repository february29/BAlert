//
//  UIView+BAlert.swift
//  BAlertDemo
//
//  Created by bai on 2017/12/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit


typealias BAlertHandler = (_ view:UIView)->Void;

extension UIView{
    
    
//    private struct AssociatedKeys {
//        static var b_showHandler:BAlertHandler?
//        static var b_hideHandler:BAlertHandler?
//    }
//
//    var b_showHandler: BAlertHandler? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.b_showHandler) as? BAlertHandler
//        }
//        set {
//            if let newValue = newValue {
//                objc_setAssociatedObject(self, &AssociatedKeys.b_showHandler, newValue as BAlertHandler?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            }
//        }
//    }
//
//    var b_hideHandler: BAlertHandler? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.b_hideHandler) as? BAlertHandler
//        }
//        set {
//            if let newValue = newValue {
//                objc_setAssociatedObject(self, &AssociatedKeys.b_hideHandler, newValue as BAlertHandler?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            }
//        }
//    }
//
    
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
    
    
    
//    var b_showHandler:BAlertHandler?
//    var b_hideHandler:BAlertHandler?
    
    
    
}
