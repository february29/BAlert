//
//  BAlert.swift
//  BAlertDemo
//
//  Created by bai on 2017/12/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

//let b_alertBackGroundColor = UIColor.init(white: 0, alpha: 0.3);






typealias AnimationOverHandle = ()->Void;

class BAlert {
//    UIWindow *window;
//    BAlerterViewController *viewController;
//    UIView *contentView;
    
    //动画时间
//    var b_AnimationTime = 0.25;
    
   
    
   
    lazy var defaultConfig:BAlertConfig = {
        return BAlertConfig();
        
    }();
    
    var nowConfig :BAlertConfig?;
    
    
    
    let alertWindow = UIWindow(frame:UIScreen.main.bounds);
    let alertVC = BAlertViewController();
    
    
    

    var viewArrays = Array<UIView>();
    
    
    //单例
    static let sharedInstance = BAlert();
    private init() {
        self.config();
    }
    
    func config()  {
        
       
        alertWindow.rootViewController = alertVC;
        
    }
    
    
    
    
 
    func show(view:UIView! ,config:BAlertConfig? = nil,showHandler:BAlertHandler? = nil,hideHandler:BAlertHandler? = nil) {

        
        //防止多次添加同一个view
        if viewArrays.contains(view) {
            return;
        }
    
        //window可见
        alertWindow.makeKeyAndVisible();
        alertVC.view.addSubview(view);
        viewArrays.append(view);
    
        view.b_showHandler = showHandler;
        view.b_hideHandler = hideHandler;
        
        
        //设置显示配置信息
        if let parConfig = config {
            nowConfig = parConfig;
        }else{
            nowConfig = defaultConfig;
        }
        alertVC.backBtn.backgroundColor = nowConfig?.b_backGroundColor;
        alertVC.backBtn.isUserInteractionEnabled = (nowConfig?.b_shouldTapOutHidde)!;
        
        //背景显示按钮动画
        alertVC.backBtn.alpha = 0;
        UIView.animate(withDuration: (nowConfig?.b_AnimationTime)!, animations: {
            self.alertVC.backBtn.alpha = 1;
        }) { (over) in
            
        }
       
        //执行动画
        if let show = view.b_showHandler {
            show(view,nowConfig!);
        }
        

    }
    
    
    /// 全部隐藏
    func hideAllView(finishedHandle:AnimationOverHandle? = nil) {
        
        for (_, view) in viewArrays.enumerated(){
            view.b_hideHandler?(view,nowConfig!);
        }
       
        
        alertVC.backBtn.alpha = 1;
        UIView.animate(withDuration: (nowConfig?.b_AnimationTime)!, animations: {
            self.alertVC.backBtn.alpha = 0;
        }) { (over) in
            for (_, view) in self.viewArrays.enumerated(){
                view .removeFromSuperview();
            }
            self.viewArrays.removeAll();
            self.nowConfig = self.defaultConfig;
            UIApplication.shared.delegate?.window??.makeKeyAndVisible();
            if finishedHandle != nil{
                finishedHandle!();
            }
        }
    }
    
    
    
    /// 隐藏特定view
    ///
    /// - Parameter view: view
    func hide(view:UIView,hideWindow:Bool = true,finishedHandle:AnimationOverHandle? = nil){
        
        view.b_hideHandler?(view,nowConfig!);
        
        if hideWindow {
            // 如果需要隐藏window
            self.alertVC.backBtn.alpha = 1;
            UIView.animate(withDuration: (nowConfig?.b_AnimationTime)!, animations: {
                self.alertVC.backBtn.alpha = 0;
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
