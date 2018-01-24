//
//  BAlertWindow.swift
//  BAlertDemo
//
//  Created by bai on 2018/1/24.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

class BAlertWindow: UIWindow {
    
     let backBtn = UIButton();

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        backBtn.frame = self.bounds;
        backBtn.addTarget(self, action: #selector(hide) , for: .touchUpInside);
        self .addSubview(backBtn);
        
    }
    
    @objc func hide() {
        BAlert.sharedInstance.hideAllView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
