//
//  BAlert.swift
//  BAlertDemo
//
//  Created by bai on 2017/12/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit


public typealias AnimationOverHandle = ()->Void;

public class BAlert {

   
    
    
   
    lazy public var defaultConfig:BAlertConfig = {
        return BAlertConfig();
        
    }();
    
    var nowConfig :BAlertConfig?;
    var isWindowShowing = false;
    
    
    
    let alertWindow = BAlertWindow(frame:UIScreen.main.bounds);
//    let alertVC = BAlertViewController();
    
    
    

    var viewArrays = Array<UIView>();
    
    
    //单例
    static public let sharedInstance = BAlert();
    private init() {
        self.config();
    }
    
    func config() {
        nowConfig = self.defaultConfig;
    }
    
    
    
    
 
    
    /// 模态显示view
    ///
    /// - Parameters:
    ///   - view: view
    ///   - config: 用于配置显示背景 动画时间 是否点击外部隐藏等
    ///   - showHandler: 显示动画
    ///   - hideHandler: 隐藏动画
    public func show(view:UIView! ,config:BAlertConfig? = nil,showHandler:BAlertHandler? = nil,hideHandler:BAlertHandler? = nil) {

        
        //防止多次添加同一个view
        if viewArrays.contains(view) {
            return;
        }
        
        //设置显示配置信息
        if let parConfig = config {
            nowConfig = parConfig;
        }
    
        //window可见
        if !isWindowShowing {
            
            alertWindow.makeKeyAndVisible();
            
            alertWindow.backBtn.backgroundColor = nowConfig?.b_backGroundColor;
            alertWindow.backBtn.isUserInteractionEnabled = (nowConfig?.b_shouldTapOutHidde)!;
            
            //背景显示按钮动画
            self.alertWindow.backBtn.alpha = 0;
            UIView.animate(withDuration: (nowConfig?.b_AnimationTime)!, animations: {
                self.alertWindow.backBtn.alpha = 1;
            }) { (over) in
                self.isWindowShowing = true;
            }
        }
       
        alertWindow.addSubview(view);
        viewArrays.append(view);
        
        //设置动画属性
        view.b_showHandler = showHandler;
        view.b_hideHandler = hideHandler;
        
       
       
        //执行动画
        if let show = view.b_showHandler {
            show(view,nowConfig!);
        }
        

    }
    
    
    
    /// 全部隐藏
    ///
    /// - Parameter finishedHandle: 完成回掉
    public func hideAllView(finishedHandle:AnimationOverHandle? = nil) {
        
        //隐藏view
        for (_, view) in viewArrays.enumerated(){
            self.hide(view: view, hideWindow: false, finishedHandle: nil);
        }
        self.hideWindow(animation: true) {
            if finishedHandle != nil{
                finishedHandle!();
            }
        }
    }
    
    
    
    
    /// 隐藏特定view
    ///
    /// - Parameters:
    ///   - view: view
    ///   - hideWindow: 隐藏是否还原window
    ///   - finishedHandle: 完成回掉
    public func hide(view:UIView,hideWindow:Bool = true,finishedHandle:AnimationOverHandle? = nil){
        
        //隐藏view
        view.b_hideHandler?(view,nowConfig!);
        
        //隐藏window
        if hideWindow {
            // 如果需要隐藏window
            self.hideWindow(animation: true) {
                
                view.removeFromSuperview();
                if finishedHandle != nil{
                    finishedHandle!();
                }
            }
            
        }else{
            //不隐藏window 延迟一定时间后将view移除
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (nowConfig?.b_AnimationTime)!, execute: {
                view.removeFromSuperview();
                if finishedHandle != nil{
                    finishedHandle!();
                }
            });
            
           
           
        }
        if let index = self.viewArrays.index(of: view) {
            self.viewArrays.remove(at: index);
        }
       
        
       
       
       
    }
    
     func hideWindow(animation:Bool,finishedHandle:AnimationOverHandle? = nil) {
        if animation {
            self.alertWindow.backBtn.alpha = 1;
            //隐藏window的动画要比配置的动画时间稍短防止动画抖动
            UIView.animate(withDuration: (nowConfig?.b_AnimationTime)!-0.1, animations: {
                self.alertWindow.backBtn.alpha = 0;
            }) { (over) in
                 self.resetDefult();
                if finishedHandle != nil{
                    finishedHandle!();
                }
                
            }
        }else{
            self.alertWindow.backBtn.alpha = 0;
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (nowConfig?.b_AnimationTime)!, execute: {
                self.resetDefult();
                if finishedHandle != nil{
                    finishedHandle!();
                }
            });
            
        }
    
       
        
    }
    
    
    /// 还原默认值
    func resetDefult()  {
        UIApplication.shared.delegate?.window??.makeKeyAndVisible();
        self.isWindowShowing = false;
        nowConfig = self.defaultConfig;
    }
    
    
}
