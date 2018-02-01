//
//  BAlert+NormalShow.swift
//  BAlertDemo
//
//  Created by bai on 2018/1/24.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit


extension BAlert{
    
    enum BAlertLocatoin{
        case BNoneLoaction;
        case BCenterLocation;
        case BBottomLoaction;
    }
    
    enum BAlertAnimation {
        case BScaleAnimaion;
        case BTopMoveAnimation;
        case BBottomMoveAnimation;
        case BLeftMoveAnimation;
        case BRightMoveAnimation;
        
    }
    
    
    func normalShow(view:UIView,location:BAlertLocatoin = .BCenterLocation ,showAnimation:BAlertAnimation = .BScaleAnimaion,hideAnimation:BAlertAnimation = .BScaleAnimaion) {
        
        
        //位置设置
        switch location {
        case .BCenterLocation:
            view.center = alertWindow.center;
        case .BBottomLoaction:
            view.bAlert_y = alertWindow.bAlert_height-view.bAlert_height;
            
        default:

            view.alpha = 1;
            
        }
        
        var showHandler:BAlertHandler?
        var hideHandler:BAlertHandler?
        
        //显示动画设置
        switch showAnimation {
       
        case .BTopMoveAnimation:
            showHandler = { (view, config) in
                
               
                
                
                let origin = view.bAlert_y;
                view.bAlert_y = -view.bAlert_height;
                UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                     view.bAlert_y = origin;
                });
            }
        case .BBottomMoveAnimation:
            showHandler = { (view, config) in

                let origin = view.bAlert_y;
                view.bAlert_y = self.alertWindow.bAlert_height;
                UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                    view.bAlert_y = origin;
                });
            }
            
        case .BLeftMoveAnimation:
            showHandler = { (view, config) in
                
                
                let origin = view.bAlert_x;

                view.bAlert_x = -view.bAlert_width;

//                view.backgroundColor = UIColor.green;
                UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                    view.bAlert_x = origin;
//                    view.backgroundColor = UIColor.brown;
                    
                });
                
                
               
                
            }
        case .BRightMoveAnimation:
            
            showHandler = { (view, config) in
                let origin = view.bAlert_x;
                view.bAlert_x = self.alertWindow.bAlert_width;
                UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                    view.bAlert_x = origin;
                });
            }
        
            
        default:
            showHandler = { (view, config) in
                view.transform = CGAffineTransform(scaleX: 0.4, y: 0.4);
                UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                    view.transform = CGAffineTransform(scaleX: 1, y: 1);
                });
            }
        }
        
        
        
        //隐藏动画设置
        switch hideAnimation {
            
        case .BTopMoveAnimation:
            hideHandler = { (view, config) in
                let origin = view.bAlert_y;
                view.bAlert_y = origin;
                UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                     view.bAlert_y = -view.bAlert_height;
                }, completion: { (over) in
                    view.bAlert_y = origin;
                })
               
            };
            
        case .BBottomMoveAnimation:
            hideHandler = { (view, config) in
                let origin = view.bAlert_y;
                view.bAlert_y = origin;
                UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                    view.bAlert_y = self.alertWindow.bAlert_height;
                }, completion: { (over) in
                    view.bAlert_y = origin;
                });
            };
            
        case .BLeftMoveAnimation:
            
            hideHandler = { (view, config) in
                let origin = view.bAlert_x;
                view.bAlert_x = origin;
                
                UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                     view.bAlert_x = -view.bAlert_width;
                }, completion: { (over) in
                    view.bAlert_x = origin;
                });
            };
        case .BRightMoveAnimation:
            hideHandler = { (view, config) in
                let origin = view.bAlert_x;
                view.bAlert_x = origin;
                
                UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                    view.bAlert_x = self.alertWindow.bAlert_width;
                }, completion: { (over) in
                    view.bAlert_x = origin;
                });
            };
            
            
            
        default:
            hideHandler = { (view, config) in
                view.transform = CGAffineTransform(scaleX: 1, y: 1);
                UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                    view.transform = CGAffineTransform(scaleX: 0.4, y: 0.4);
                }, completion: { (over) in
                    
                    view.transform = CGAffineTransform.identity;
                });
            };
        }
        
        
        self.show(view: view, config: nil, showHandler: showHandler, hideHandler: hideHandler);
        
    }
    
    
   
    
    
  
    
}
