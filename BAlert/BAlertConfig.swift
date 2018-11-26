//
//  File.swift
//  BAlertDemo
//
//  Created by bai on 2018/1/24.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

public class BAlertConfig {
    
    /// 背景颜色
    var b_backGroundColor:UIColor?
   
    /// 动画时间 此动画时间代表 背景显示和隐藏的时间,改时间应大于view的动画之行时间。
    var b_AnimationTime:TimeInterval?
    
    /// 点击背景是否隐藏
    var b_shouldTapOutHidde:Bool?
    
    
    
    
    init() {
        b_AnimationTime = 0.25;
        b_backGroundColor =   UIColor.init(white: 0, alpha: 0.3);
        b_shouldTapOutHidde = true;
        
    }
    
   
    
}
