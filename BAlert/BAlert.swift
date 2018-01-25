//
//  BAlert.swift
//  BAlertDemo
//
//  Created by bai on 2017/12/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

typealias AnimationOverHandle = ()->Void;

class BAlert {

   
    
   
    lazy var defaultConfig:BAlertConfig = {
        return BAlertConfig();
        
    }();
    
    var nowConfig :BAlertConfig?;
    
    
    
    let alertWindow = BAlertWindow(frame:UIScreen.main.bounds);
//    let alertVC = BAlertViewController();
    
    
    

    var viewArrays = Array<UIView>();
    
    
    //单例
    static let sharedInstance = BAlert();
    private init() {
        self.config();
    }
    
    func config() {
//        alertWindow.rootViewController = alertVC;
    }
    
    
    
    
 
    
    /// 模态显示view
    ///
    /// - Parameters:
    ///   - view: view
    ///   - config: 用于配置显示背景 动画时间 是否点击外部隐藏等
    ///   - showHandler: 显示动画
    ///   - hideHandler: 隐藏动画
    func show(view:UIView! ,config:BAlertConfig? = nil,showHandler:BAlertHandler? = nil,hideHandler:BAlertHandler? = nil) {

        
        //防止多次添加同一个view
        if viewArrays.contains(view) {
            return;
        }
    
        //window可见
        alertWindow.makeKeyAndVisible();
        alertWindow.addSubview(view);
//        alertVC.view.addSubview(view);
        viewArrays.append(view);
        
        
        //设置显示配置信息
        if let parConfig = config {
            nowConfig = parConfig;
        }else{
            nowConfig = defaultConfig;
        }
        
        
        alertWindow.backBtn.backgroundColor = nowConfig?.b_backGroundColor;
        alertWindow.backBtn.isUserInteractionEnabled = (nowConfig?.b_shouldTapOutHidde)!;
        
      
        
        //设置动画属性
        view.b_showHandler = showHandler;
        view.b_hideHandler = hideHandler;
        
        //背景显示按钮动画
        self.alertWindow.backBtn.alpha = 0;
        UIView.animate(withDuration: (nowConfig?.b_AnimationTime)!, animations: {
            self.alertWindow.backBtn.alpha = 1;
        }) { (over) in

        }
       
        //执行动画
        if let show = view.b_showHandler {
            show(view,nowConfig!);
        }
        

    }
    
    
    
    /// 全部隐藏
    ///
    /// - Parameter finishedHandle: 完成回掉
    func hideAllView(finishedHandle:AnimationOverHandle? = nil) {
        
        for (_, view) in viewArrays.enumerated(){
            view.b_hideHandler?(view,nowConfig!);
        }
       
        
        self.alertWindow.backBtn.alpha = 1;
        UIView.animate(withDuration: (nowConfig?.b_AnimationTime)!, animations: {
            self.alertWindow.backBtn.alpha = 0;
        }) { (over) in
            for (_, view) in self.viewArrays.enumerated(){
                view .removeFromSuperview();
            }
            self.viewArrays.removeAll();
            UIApplication.shared.delegate?.window??.makeKeyAndVisible();
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
    func hide(view:UIView,hideWindow:Bool = true,finishedHandle:AnimationOverHandle? = nil){
        
        view.b_hideHandler?(view,nowConfig!);
        
        if hideWindow {
            // 如果需要隐藏window
            self.alertWindow.backBtn.alpha = 1;
            UIView.animate(withDuration: (nowConfig?.b_AnimationTime)!, animations: {
                self.alertWindow.backBtn.alpha = 0;
            }) { (over) in
                view.removeFromSuperview();
                UIApplication.shared.delegate?.window??.makeKeyAndVisible();
                if finishedHandle != nil{
                    finishedHandle!();
                }
                
            }
        }else{
            //不隐藏window 延迟预定时间后将view移除
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (nowConfig?.b_AnimationTime)!, execute: {
                view.removeFromSuperview();
                if finishedHandle != nil{
                    finishedHandle!();
                }
            });
            
           
           
        }
        
       
        
        if let index = viewArrays.index(of: view) {
             viewArrays.remove(at: index);
        }
       
       
    }
    
    
}
