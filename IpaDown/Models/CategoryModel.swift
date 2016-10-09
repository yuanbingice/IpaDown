//
//  CategoryModel.swift
//  IpaDown
//
//  Created by ice on 16/01/01
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

class CategoryModel: NSObject {

    var header: String?
    
    var typeArray: NSArray?  //是一个数组,到时候的模型数组会是数组装数组
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
    }
    
}

//数组中的模型对象(typeArray)

class CategoryType: NSObject {
    
    var desc: String?
    var icon: String?
    var querystr: String?
    var title: String?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}


