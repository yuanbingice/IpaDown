//
//  MyNavViewController.swift
//  IpaDown
//
//  Created by ice on 16/01/01
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//对导航器上面的按钮 和 标题的配置()   //有导航的视图都继承该类 //都有一些方法,就看是否会调用
class MyNavViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //导航条的背景图片
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "top-bg"), forBarMetrics: UIBarMetrics.Default)
        
    }

    //导航上的标题视图
    func addNavTitle(title: String){
        
        let label = MyUtil.createLabel(CGRectMake(80, 20, 215, 44), text: title)
        
        label.font = UIFont.boldSystemFontOfSize(28)
        label.textAlignment = .Center
        
        label.textColor = UIColor.whiteColor()
        
        navigationItem.titleView = label
        
    }
    
    //返回按钮
    func addBackBtn(target: AnyObject, action: Selector){
        
        let btn = MyUtil.createBtn(CGRectMake(0, 0, 60, 36), title: "返回", bgImageName: "backButton", target: target, action: action)
        
        
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        let item = UIBarButtonItem(customView: btn)
        navigationItem.leftBarButtonItem = item
    }
    
    
    func addNavBtnTitle(title: String, bgImageName: String, target: AnyObject, action: Selector) -> UIButton{
        
        let btn = MyUtil.createBtn(CGRectMake(0, 0, 60, 36), title: title, bgImageName: bgImageName, target: target, action: action)
        
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        let item = UIBarButtonItem(customView: btn)
        
        navigationItem.rightBarButtonItem = item
        
        return btn
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
