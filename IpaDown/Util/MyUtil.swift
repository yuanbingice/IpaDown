//
//  MyUtil.swift
//  IpaDown
//
//  Created by ice on 16/01/01
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit


//工具 快速创建 标签  图片视图  按钮   弹出试图框
class MyUtil: NSObject {
    
    //标签
    class func createLabel(frame: CGRect, text: String?) -> UILabel {
        
        let label = UILabel(frame: frame)
        
        if  let title = text{
            
            label.text = title
        }
        
        return label
    }
    
    //图片视图
    class func createImageView(frame: CGRect, imageName: String?) -> UIImageView {
        
        let imageView = UIImageView(frame: frame)
        
        if imageName != nil{
            
            imageView.image = UIImage(named: imageName!)
        }
        
        return imageView
    }
    
    //按钮
    
    class func createBtn(frame: CGRect, title: String?, bgImageName: String?, target: AnyObject?, action: Selector) -> UIButton {
        
        let btn = UIButton(type: .Custom)
        
        btn.frame = frame
        
        if let tmpTitle = title{
            
            btn.setTitle(tmpTitle, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        
        if let tmpBgImageName = bgImageName{
            
            btn.setBackgroundImage(UIImage(named: tmpBgImageName), forState: .Normal)
        }
        
        
        if target != nil && action != nil{
            
            btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        }
        
        return btn
    }
    
    //弹出试图框
    class func showAlert(msg: String, onViewController vc: UIViewController) {
        
        let alertCtrl = UIAlertController(title: "提示", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        
        let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
        
        alertCtrl.addAction(action)
        
        //回到主线程修改UI
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            vc.presentViewController(alertCtrl, animated: true, completion: nil)
        }
        
        
    }

}
