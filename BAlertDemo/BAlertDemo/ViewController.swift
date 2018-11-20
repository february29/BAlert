//
//  ViewController.swift
//  BAlertDemo
//
//  Created by bai on 2017/12/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let dataArray = ["自定义动画显示多个","自定义动画显示config设置","二次弹窗","中间缩放显示","中间左侧移入","吐司"]
    
    
    lazy var tableView:UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .grouped);
        table.showsVerticalScrollIndicator = false;
        table.showsHorizontalScrollIndicator = false;
        table.estimatedRowHeight = 30;
        table.delegate = self;
        table.dataSource = self;
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = UITableViewAutomaticDimension;
        //        table.separatorStyle = .none;
//        table.backgroundColor  = BGlobalGrayColor();
        table.tableFooterView = UIView();
        return table;
    }();
    
    
    lazy var myLayer:CALayer = {
        let layer = CALayer();
        layer.frame = yellowView.bounds;
        layer.backgroundColor = UIColor.brown.cgColor;
        return layer;
    }();
    
    
    lazy var whriteView:UIView = {
        let view = UIView();
        view.frame = CGRect(x: 150, y: 200, width: 100, height: 100);
        view.backgroundColor = UIColor.white;
        return view;
    }();
    
    lazy var blueView:UIView = {
        let view = UIView();
        view.frame = CGRect(x: 100, y: 100, width: 100, height: 100);
        view.backgroundColor = UIColor.blue;
        //添加点击事件
        let tabges = UITapGestureRecognizer(target: self, action: #selector(hideBlueViewAndWindow));
        view .addGestureRecognizer(tabges);
        return view;
    }();
    
    @objc func hideBlueViewAndWindow() {
        BAlert.sharedInstance.hide(view: blueView);
    }
    
    lazy var yellowView:UIView = {
        let view2 = UIView();
        view2.frame = CGRect(x: 50, y: 150, width: 100, height: 100);
        view2.backgroundColor = UIColor.yellow;
        let tabges = UITapGestureRecognizer(target: self, action: #selector(hideYellowViewOnly));
        view2 .addGestureRecognizer(tabges);
        return view2;
    }();
    
    
    
    @objc func hideYellowViewOnly() {
        BAlert.sharedInstance.hide(view: yellowView, hideWindow: false);
    }
    
    lazy var perpleView:UIView = {
        let view = UIView();
        view.frame = CGRect(x: 200, y: 200, width: 100, height: 100);
        view.backgroundColor = UIColor.purple;
        let tabges = UITapGestureRecognizer(target: self, action: #selector(perpleViewTap));
        view .addGestureRecognizer(tabges);
        return view;
    }();
    
    
    
    @objc func perpleViewTap() {
        BAlert.sharedInstance.show(view: whriteView);
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.frame = self.view.bounds;
        self.view.addSubview(self.tableView);
        
        
//         self.view.addSubview(yellowView);
//
//        self.view.addSubview(blueView);
//        self.view.addSubview(perpleView);
        
    }
    
    
    
    
    //    MARK: table代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell");
        cell.textLabel?.text = dataArray[indexPath.row];
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            self.show1();
        }else if indexPath.row == 1{
            self.show2();
        }else if indexPath.row == 2{
            self.show3();
        }else if indexPath.row == 3{
            self.show4();
        }else if indexPath.row == 4{
            self.show5();
        }else if indexPath.row == 5{
            self.show6();
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45;
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView();
    }
    
    
    //    MARK: 各种显示设置
    
    
    
    /// 多个view
    func show1(){
       
        BAlert.sharedInstance.show(view: blueView, showHandler: { (view,config) in
            view.transform = CGAffineTransform(scaleX: 1, y: 0.1);
            UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 1);
            })
        }) { (view,config) in
            view.transform = CGAffineTransform(scaleX: 1, y: 1);
            UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 0.1);
            })
        }
        
       
        
        BAlert.sharedInstance.show(view: yellowView, showHandler: { (view,config) in
            view.transform = CGAffineTransform(rotationAngle: 0);
            UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                view.transform = CGAffineTransform(rotationAngle: 1);
            })
        }) { (view,config) in
            view.transform = CGAffineTransform(rotationAngle: 1);
            UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                view.transform = CGAffineTransform(rotationAngle: 0);
            })
        }
        
    }
    
    //利用config配置显示样式
    func show2(){
        
        let config =  BAlertConfig();
        //是否点击外部隐藏
        config.b_shouldTapOutHidde = false;
        //外部颜色
        config.b_backGroundColor = UIColor.lightGray;
        //动画时间
        config.b_AnimationTime = 1;
        
        
        
        BAlert.sharedInstance.show(view: blueView,config: config, showHandler: { (view,config) in
            view.transform = CGAffineTransform(scaleX: 1, y: 0.1);
            UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 1);
            })
        }) { (view,config) in
            view.transform = CGAffineTransform(scaleX: 1, y: 1);
            UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 0.1);
            })
        }
        
       
        
    }
    
    //二次弹窗
    func show3(){
        BAlert.sharedInstance.show(view: perpleView,config: nil, showHandler: { (view,config) in
            view.transform = CGAffineTransform(scaleX: 1, y: 0.1);
            UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 1);
            })
        }) { (view,config) in
            view.transform = CGAffineTransform(scaleX: 1, y: 1);
            UIView.animate(withDuration: config.b_AnimationTime!, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 0.1);
            })
        }
        
        
        
    }
    
    //中间缩放显示
    func show4(){
       
        BAlert.sharedInstance.normalShow(view: whriteView);
        
        
    }
    
    //中间左侧移入
    func show5(){
        
        BAlert.sharedInstance.normalShow(view: whriteView, location: .BCenterLocation, showAnimation: .BLeftMoveAnimation, hideAnimation: .BLeftMoveAnimation);
        
        
    }
    //toast用法
    func show6(){
        
//        BAlert.sharedInstance.makeToast(message: "ffadrrr--------------------------------------rrrrrrrv\nsf");
        BAlert.sharedInstance.makeToast(message: "我是🍞")
        
        
    }
    
    func test() {
        
//        let origin = view.bAlert_x;
//
//        let animation = CABasicAnimation();
//        animation.keyPath = "position.y";
//        animation.fromValue = -view.bAlert_width;
//        animation.toValue = 0;
//        animation.duration = 0.25;
//        //                animation.fu
//
//
//
//
//        //
//        UIView.beginAnimations("FrameAni", context: nil);//开始动画
//        UIView.setAnimationDelay(0);//动画延迟多少执行
//        UIView.setAnimationDuration(0.25);//动画持续时间
//        UIView.setAnimationDelegate(self);//动画代理
//        UIView.setAnimationWillStart(#selector(self.startHandler));
//        UIView.setAnimationDidStop(#selector(self.stopHandler));
//        //动画曲线类型 （氛围 慢进慢出 ，慢进，慢出，线性）
//        UIView.setAnimationCurve(.easeOut);
//        UIView.setAnimationRepeatCount(1);//重复次数
//        //是否从当前状态开始执行 true当前状态 false上一个动画结束时的状态
//        UIView.setAnimationBeginsFromCurrentState(true);
//        UIView.setAnimationRepeatAutoreverses(false);//是否执行相反动画
//        UIView.setAnimationsEnabled(false);//是否禁用动画，只改变属性没有动画效果
//        //设置过度效果，
//        //效果 不使用  翻页
//        //需要过度效果的view
//        //是否用试图缓存 true 开始结束渲染  false每一帧渲染
//        UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true);
//
//        //实际动画要改变的属性等 这里是改变view的x坐标位置
//        view.bAlert_x = -view.bAlert_width;
//
//        UIView.commitAnimations();//结束动画
        
        
        
        //
        //普通动画
//
//
//
        let origin = yellowView.bAlert_x;
//
//        yellowView.bAlert_x = -yellowView.bAlert_width;
//        UIView.animate(withDuration:0.25, animations: {
//            self.yellowView.bAlert_x = origin;
//        });

//
        //spring动画 iOS7 以后
        //  参数：时常，延迟，震动效果（范围0~1，数值越小震动效果越明显），弹簧动画速度（数值越大速度越慢），过度效果，执行动画回掉，完成回掉
//         yellowView.bAlert_x = -yellowView.bAlert_width;
        
        
        
//        UIView.animate(withDuration: 3, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
//
//
//
//
//            var frame =  self.yellowView.layer.frame;
//            frame.size.height = 10;
//            self.yellowView.layer.frame = frame;
//            // 等同于上面的代码
//            var frame =  self.yellowView.layer.frame;
//            frame.size.height = 10;
//            self.yellowView.layer.frame = frame;
            
        
            //也会导致view 和layer 的frame的高度变化
//            self.yellowView.transform = CGAffineTransform(scaleX: 1, y: 0.4);
//        }, completion: { (over) in
//
//            print("layer %d",self.yellowView.layer.frame.size.height);
//            print("view %d",self.yellowView.frame.size.height);
//
//        });

        //关键帧动画 iOS7 以后
        //参数：时常，延迟，过度效果，执行动画回掉，完成回掉
//        yellowView.bAlert_x = -yellowView.bAlert_width;
//        UIView.animateKeyframes(withDuration: 1, delay: 0.1, options: UIViewKeyframeAnimationOptions.layoutSubviews, animations: {
//            //添加关键帧
//            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.1) {
//                self.yellowView.bAlert_x = origin/2;
//            };
//            self.yellowView.bAlert_x = origin;
//        }, completion: { (over) in
//
//        });

//
//
//        //视图替换动画 fromView会从父视图中移除，并且toView添加到父视图中
//        //针对父识图做动画 子视图只是单纯的移除和添加
//        UIView.transition(from: yellowView, to: blueView, duration: 5, options: .transitionFlipFromLeft, completion: { (over) in
//
//
//        });
//
//
//        //单个视图动画，
//        UIView.transition(with: yellowView, duration: 3, options: .transitionFlipFromLeft, animations: {
//            self.yellowView.transform = CGAffineTransform(scaleX: 2, y: 2);
//        }, completion: { (over) in
//
//        });
        
        self.yellowView.alpha = 1;
        self.blueView.alpha = 1;
        self.perpleView.alpha = 1;
        
        
        print("outblock\(String(describing: self.blueView.layer.delegate))")
        
        
        UIView.animate(withDuration: 2, delay: 0.0, options: [.overrideInheritedCurve,.curveLinear,.overrideInheritedDuration,.repeat,.autoreverse] , animations: {
             print("inblock\(String(describing: self.blueView.layer.delegate))")
            UIView.setAnimationRepeatCount(2.5);
            self.blueView.alpha = 0;
        }, completion: { (over) in

        })
        
//        let animation = CABasicAnimation(keyPath: "opacity");
//        animation.duration = 2;
//        animation.fromValue = 1;
//        animation.toValue = 0;
//        animation.beginTime = CACurrentMediaTime() + 0;
//        animation.timingFunction = CAMediaTimingFunction(name: "linear");
//        animation.autoreverses = true;
//        animation.repeatCount = 2.5;
//        animation.isRemovedOnCompletion = false;
//        animation.fillMode = kCAFillModeForwards;
//        self.perpleView.layer.add(animation, forKey: "animation");
//
        
//        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseOut, animations: {
//            self.yellowView.alpha = 0;
//            
//            UIView.animate(withDuration: 2, delay: 0.0, options: [.overrideInheritedCurve,.curveLinear,.overrideInheritedDuration,.repeat,.autoreverse] , animations: {
//                UIView.setAnimationRepeatCount(2.5);
//                self.blueView.alpha = 0;
//            }, completion: { (over) in
//                
//            })
//            
//            
//            let animation = CABasicAnimation(keyPath: "opacity");
//            animation.duration = 2;
//            animation.fromValue = 1;
//            animation.toValue = 0;
//            animation.beginTime = CACurrentMediaTime() + 0;
//            animation.timingFunction = CAMediaTimingFunction(name: "linear");
//            animation.autoreverses = true;
//            animation.repeatCount = 2.5;
//            animation.isRemovedOnCompletion = false;
//            animation.fillMode = kCAFillModeForwards;
//            self.perpleView.layer.add(animation, forKey: "animation");
//            
//            
//            
//            
//        }) { (over) in
//            
//            
//        }
//        
       
        
        
      
//        UIView.animate(withDuration: 1.0, delay: 5.0, options: .curveEaseOut, animations: {
//            self.yellowView.alpha = 0;
//
//            UIView.animate(withDuration: 3, delay: 0.0, options: [.overrideInheritedCurve,.curveEaseIn,.overrideInheritedDuration,.repeat,.autoreverse] , animations: {
//                UIView.setAnimationRepeatCount(2.5);
//                self.blueView.alpha = 0;
//            }, completion: { (over) in
//
//            })
//
//
//            UIView.animate(withDuration: 3, delay: 0.0, options: [.overrideInheritedCurve,.curveEaseIn,.overrideInheritedDuration,.repeat,.autoreverse] , animations: {
//                UIView.setAnimationRepeatCount(2);
//                self.perpleView.alpha = 0;
//            }, completion: { (over) in
//
//            })
//
//
//        }) { (over) in
//
//        }
//
       
        

        
    }
    

    
    
    @objc func startHandler() {
        
    }
    
    @objc func stopHandler() {
        
    }
    
}

