//
//  CustomTabBarController.swift
//  IpaDown
//
//  Created by ice on 16/10/6.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//自定义的标签栏控制器
class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //创建子视图控制器
        createViewControllers()
    }
    
    func createViewControllers(){
        
        let titleArray = ["首页","今日限免","分类","推荐","更多"]
        
        let ctrlArray = ["IpaDown.FirstViewController","IpaDown.LimitFreeViewController","IpaDown.CategoryViewController","IpaDown.SuggestViewController","IpaDown.MoreViewController"]
        let imageArray = ["item_app_home","item_app_pricedrop","item_app_category","item_app_hot","item_app_more"]
        
        var array = [UINavigationController]()
        
        for i in 0..<titleArray.count{
            
            //创建真正的类名 并实例化一个对象
            let clsName = ctrlArray[i]
            let cls = NSClassFromString(clsName) as! UIViewController.Type
            let ctrl = cls.init()
            
            ctrl.tabBarItem.title = titleArray[i]
            ctrl.tabBarItem.image = UIImage(named: imageArray[i])
            
            let navCtrl = UINavigationController(rootViewController: ctrl)
            array.append(navCtrl)  //放进标签栏管理的数组中
            
        }
        
        viewControllers = array
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
