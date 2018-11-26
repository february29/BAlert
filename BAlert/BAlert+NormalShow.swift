//
//  BAlert+NormalShow.swift
//  BAlertDemo
//
//  Created by bai on 2018/1/24.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

// MARK: 常用动画
extension BAlert{
    
   
    public enum BAlertLocatoin{
        case BNoneLoaction;
        case BCenterLocation;
        case BBottomLoaction;
    }
    
    public enum BAlertAnimation {
        case BScaleAnimaion;
        case BTopMoveAnimation;
        case BBottomMoveAnimation;
        case BLeftMoveAnimation;
        case BRightMoveAnimation;
        
    }
    
    
    /// 通用显示
    ///
    /// - Parameters:
    ///   - view: view
    ///   - location: 显示位置 默认中间
    ///   - showAnimation: 显示动画 默认缩放
    ///   - hideAnimation: 隐藏动画 默认缩放
    public func normalShow(view:UIView,location:BAlertLocatoin = .BCenterLocation ,showAnimation:BAlertAnimation = .BScaleAnimaion,hideAnimation:BAlertAnimation = .BScaleAnimaion) {
        
        
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

// MARK: 控件下拉显示
extension BAlert{
    
}
// MARK: 吐司显示
extension BAlert{
    
    public enum BAlertToastLocatoin{
        case BToastBottomLoaction;
        case BToastCenterLocation;
        case BToastTopLoaction;
        case BToastNoneLoaction;
       
    }
    
    class TosatLable:UILabel  {
        override func drawText(in rect: CGRect) {
            let insets = UIEdgeInsetsMake(5, 5, 5, 5);
            super.drawText(in: UIEdgeInsetsInsetRect(rect,insets))
            
        }
    }
    
    
    public func makeToast(message:String,showTime:TimeInterval = 2,location:BAlertToastLocatoin = .BToastBottomLoaction) {
        let lable = TosatLable();
        lable.text = message;
        lable.font = UIFont.systemFont(ofSize: 14);
        lable.textAlignment = .center;
        lable.textColor = UIColor.white;
        lable.backgroundColor = UIColor.black;
        lable.layer.cornerRadius = 3;
        lable.layer.masksToBounds = true;
        lable.lineBreakMode = .byWordWrapping;
        lable.numberOfLines = 0;
        lable.sizeToFit();
       
        lable.bAlert_size = self.sizeForString(text: message, font: lable.font);
        lable.bAlert_centerX = self.alertWindow.center.x;
        if location == .BToastCenterLocation{
            lable.bAlert_centerY = self.alertWindow.center.y;
        }else if location == .BToastTopLoaction{
            //iphonex serious
            if UIScreen.main.bounds.height >= 812{
                lable.bAlert_y =  84 + 100;
            }else{
                lable.bAlert_y = 64 + 100;
            }
            
            
        }else if location == .BToastBottomLoaction{
            //iphonex serious
            if UIScreen.main.bounds.height >= 812{
                lable.bAlert_y = UIScreen.main.bounds.height * 0.9 - 23 - lable.frame.size.height;
            }else{
                lable.bAlert_y =  UIScreen.main.bounds.height * 0.9 - lable.frame.size.height;
            }
        }
        
        
    
        
        
        let config = BAlertConfig();
        config.b_backGroundColor = UIColor.clear;
        config.b_shouldTapOutHidde = false;
        config.b_AnimationTime = 1;
        
        
    
        
        
        self.show(view: lable, config: config, showHandler: { (view, config) in
            view.alpha = 0;
            UIView.animate(withDuration: 0.25, animations: {
                view.alpha = 1;
               
            })
        }) { (view, config) in
            view.alpha = 1;
            UIView.animate(withDuration: 1, animations: {
                view.alpha = 0;
            })
        }
        
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + showTime - 1 , execute: {
            self.hide(view: lable);
        });
        
        
        
    }
    
    
    func sizeForString(text:String,font:UIFont) -> CGSize {

        let statusLabelText: NSString = text as NSString
        
        var size = CGSize(width: CGFloat(MAXFLOAT), height: 30)
        var strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil).size

        if strSize.width > UIScreen.main.bounds.width - 30 {
             size = CGSize(width:UIScreen.main.bounds.width - 30, height: CGFloat(MAXFLOAT))
             strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil).size
        }

        
       
       //str计算的是文本大小，lable的实际大小要加上内边距
        return  CGSize(width: strSize.width+10, height: strSize.height+10);
    }
}
