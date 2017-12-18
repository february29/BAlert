//
//  BAlertViewController.swift
//  BAlertDemo
//
//  Created by bai on 2017/12/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

class BAlertViewController: UIViewController {

    
//    var b_backGroundColor =  UIColor.
    let backBtn = UIButton();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backBtn.frame = self.view.bounds;
    
        backBtn.addTarget(self, action: #selector(BAlertViewController.hide) , for: .touchUpInside);
        self.view .addSubview(backBtn);
        
    }
    @objc func hide() {
        BAlert.sharedInstance.hide();
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
