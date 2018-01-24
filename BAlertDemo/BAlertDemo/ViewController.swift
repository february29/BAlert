//
//  ViewController.swift
//  BAlertDemo
//
//  Created by bai on 2017/12/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton.init(frame: CGRect.init(x: 10, y: 100, width: 100, height: 40));
        btn.backgroundColor = UIColor.yellow;
        btn.addTarget(self, action: #selector(ViewController.show1), for: .touchUpInside);
        self.view.addSubview(btn);
    }
    
    @objc func show1(){
        let view = UIView();
        view.frame = CGRect(x: 100, y: 100, width: 100, height: 100);
        view.backgroundColor = UIColor.blue;
        
//        BAlert.instance.show(view: view);
        BAlert.sharedInstance.show(view: view, showHandler: { (view) in
            view.transform = CGAffineTransform(scaleX: 1, y: 0.1);
            UIView.animate(withDuration: (BAlert.sharedInstance.nowConfig?.b_AnimationTime)!, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 1);
            })
        }) { (view) in
            view.transform = CGAffineTransform(scaleX: 1, y: 1);
            UIView.animate(withDuration: (BAlert.sharedInstance.nowConfig?.b_AnimationTime)!, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 0.1);
            })
        }
        
        let view2 = UIView();
        view2.frame = CGRect(x: 50, y: 150, width: 100, height: 100);
        view2.backgroundColor = UIColor.yellow;
        
        BAlert.sharedInstance.show(view: view2, showHandler: { (view) in
            view.transform = CGAffineTransform(scaleX: 1, y: 0.1);
            UIView.animate(withDuration: (BAlert.sharedInstance.nowConfig?.b_AnimationTime)!, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 1);
            })
        }) { (view) in
            view.transform = CGAffineTransform(scaleX: 1, y: 1);
            UIView.animate(withDuration: (BAlert.sharedInstance.nowConfig?.b_AnimationTime)!, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 0.1);
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

