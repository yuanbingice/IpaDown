//
//  Const.swift
//  IpaDown_SWift
//
//  Created by 16/01/01
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit


//
//  Const.h
//  TestIpaDown
//
//  Created by gaokunpeng on 15/8/2.
//  Copyright (c) 2015年 gaokunpeng. All rights reserved.
//

//屏幕的简单适配
//获取屏幕的宽度
public let kScreenWidth = UIScreen.mainScreen().bounds.size.width
//获取屏幕的高度
public let kScreenHeight = UIScreen.mainScreen().bounds.size.height


//首页
//1、广告
public let kHomeAdUrl = "http://api.ipadown.com/iphone-client/ad.flash.php?count=5&device=iphone"

//2、列表
public let kHomeListUrl = "http://api.ipadown.com/iphone-client/apps.list.php?t=index&count=%ld&page=%ld&device=iPhone&price=all"

//今日限免
//1、今日限免
public let kLimitToday = "http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&count=%ld&page=%ld"

//2、本周热门限免
public let kLimitWeek = "http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&subday=7&orderby=views&count=%ld&page=%ld"

//3、热门限免总榜
public let kLimitHot = "http://api.ipadown.com/iphone-client/apps.list.php?device=iPhone&price=pricedrop&orderby=views&count=%ld&page=%ld"


//分类
//1、分类列表
public let kCategoryListUrl = "http://api.ipadown.com/iphone-client/category.list.php"

//2、分类进入的具体类型列表
public let kCategoryUrl = "http://api.ipadown.com/iphone-client/apps.list.php?%@&count=%ld&page=%ld&device=iPhone&price=%@"



//推荐
//1、每日一荐
public let kDailyUrl = "http://api.ipadown.com/iphone-client/apps.list.php?t=commend&count=%ld&page=%ld&device=iPhone&price=all"



