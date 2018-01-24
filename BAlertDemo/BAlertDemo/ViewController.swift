//
//  ViewController.swift
//  BAlertDemo
//
//  Created by bai on 2017/12/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let dataArray = ["自定义动画显示多个","自定义动画显示外部不可点击","二次弹窗",""]
    
    
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
    
    
    
    lazy var whriteView:UIView = {
        let view = UIView();
        view.frame = CGRect(x: 100, y: 150, width: 100, height: 100);
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
        view.frame = CGRect(x: 50, y: 150, width: 100, height: 100);
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
        
        
    }
    
    
    
    
    //    MARK: table代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
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
    
    //外部不可点击
    func show2(){
        
        let config =  BAlertConfig();
        config.b_shouldTapOutHidde = false;
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
    
    
    func show4(){
        
        let config =  BAlertConfig();
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

