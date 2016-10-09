//
//  MoreViewController.swift
//  IpaDown
//
//  Created by ice on 16/01/01
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//用来区分 cell 上的 头像  textLabel    detailtextLabel
public let kImageArray = "imageArray"
public let kTitleArray = "titleArray"
public let kSubtileArray = "subtitleArray"

class MoreViewController: BaseViewController {
    
    //组标题
    var titleArray = ["更多栏目","客户端设置","关于客户端","关于i派党","我们的iOS移动客户端","我们的电脑客户端"]
    
    var titleViewArray = [UILabel]()  //组的头视图

    override func viewDidLoad() {
      
        createDataArray()  //数据写在表格之前
        createHeaderViewOfSection()  //创建每组的的头视图
        
        super.viewDidLoad()
        
        //表格视图cell的分割方式  默认为 SingleLine
        tableView?.separatorStyle = .SingleLine
        
        //添加表格视图的头视图
        let headView = MyUtil.createImageView(CGRectMake(0, 0, kScreenWidth, 110), imageName: "logo_empty")
        tableView?.tableHeaderView = headView
        
        
        addNavTitle("更多")
    }
    
    //创建每组的的头视图
    func createHeaderViewOfSection() {
        
        for i in 0..<titleArray.count{
            
            let label = MyUtil.createLabel(CGRectMake(10, 0, kScreenWidth, 30), text: titleArray[i])
            label.backgroundColor = UIColor.grayColor()
            
            label.font = UIFont.systemFontOfSize(18)
            label.textColor = UIColor.whiteColor()
            
            titleViewArray.append(label)
        }
    }
    
    
    //数据   // 数据数组中放6给字典,字典的value又是数组 形成了分组模式
    func createDataArray(){
        
        //更多栏目
        var dict1 = Dictionary<String, AnyObject>()
        
        dict1[kImageArray] = ["c-top","c-zt","c-guide","c-jc"]
        dict1[kTitleArray] = ["排行标题","应用专题","精品导购","苹果学院"]
        dict1[kSubtileArray] = ["Appstroe各国实时排行榜","归类推荐精品软件游戏","精品应用程序导购指南","iPhone小技巧一网打尽"]
        dataArray.addObject(dict1)
        
        
        //客户端设置
        var dict2 = Dictionary<String, AnyObject>()
        
        dict2[kTitleArray] = ["我收藏的Apps","清空本地缓存","开启或关闭推送"]
        dict2[kSubtileArray] = ["","一键清空","设置"]
        
        dataArray.addObject(dict2)
        
        
        //关于客户端
        var dict3 = Dictionary<String, AnyObject>()
        dict3[kTitleArray] = ["软件名称","软件作者","意见反馈","技术支持","去AppStore给我们评价"]
        dict3[kSubtileArray] = ["精品显示免费","花太香齐","ieliwb@gmail.com","www.ipadown.com",""]
        
        dataArray.addObject(dict3)
        
        
        //关于i派党
        var dict4 = Dictionary<String, AnyObject>()
        dict4[kTitleArray] = ["关于ipai党","团队联系方式","App玩家交流QQ群"]
        
        dataArray.addObject(dict4)
        
        //我们的IOS移动客户端
        var dict5 = Dictionary<String,AnyObject>()
        
        dict5[kTitleArray] = ["《精品限时免费》 for iPad","《苹果i新闻》for iPhone"]
        self.dataArray.addObject(dict5)
        
        
        //我们的电脑客户端
        var dict6 = Dictionary<String,AnyObject>()
        
        dict6[kTitleArray] = ["i派党Mac客户端","ipai党AIR客户端"]
        self.dataArray.addObject(dict6)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //空实现父类的方法
    override func downloadData() {
        
    }
    
}


//MARK: 表格视图的代理
extension MoreViewController{
    
    //分组数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return titleArray.count
    }
    
    //每组的行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //取出6个字典中的一个
        let dict = dataArray[section] as! Dictionary<String,AnyObject>
        
        //取出字典的key为kTitleArray 的数组
        let array = dict[kTitleArray] as! Array<String>
        
        return array.count   //每个数组的 长度 即为每组的行数
    }
    
//    //每组的标签
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        let title = titleArray[section]
//        
//        return title
//    }
    
    //每组的头视图
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = titleViewArray[section]
        
        return view
    }
    
    //标题使用视图  必须定义视图的高度,否则会不显示
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    //设置标题视图的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 80
    }
    
    
    //
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)
        
        //cell的方式各不相同  indexPath.row == 0 / 1 / 2 为 .Value1  其他为.Subtitle
        var style: UITableViewCellStyle = .Subtitle
    
        
        if  indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            
            style = .Value1
        }
        
        
        if cell == nil{
            
            cell = UITableViewCell(style: style, reuseIdentifier: cellId)
        }
        
        let dict = dataArray[indexPath.section] as! Dictionary<String,AnyObject>
        let titleArray = dict[kTitleArray] as! Array<String>
        //标题(都有)
        cell?.textLabel?.text = titleArray[indexPath.row]
        
        cell?.textLabel?.font = UIFont.boldSystemFontOfSize(20)
        
        
        //图片(有的没有)  //先判断是否存在键 kImageArray
        if dict.keys.contains(kImageArray){
            
            let imageArray = dict[kImageArray] as! Array<String>
            
            let imageName = imageArray[indexPath.row]
            
            cell?.imageView?.image = UIImage(named: imageName)
            
        }else{ //需要置为nil,否则会从其他的cell上取(切记)
            
            cell?.imageView?.image = nil
        }
        
        //副标题 同样要判断是否存在
        if dict.keys.contains(kSubtileArray){
            
            let subArray = dict[kSubtileArray] as! Array<String>
            
            cell?.detailTextLabel?.text = subArray[indexPath.row]
            
        }else{  //需要置为nil,否则会从其他的cell上取
            
            cell?.detailTextLabel?.text = nil
        }
        
        //cell上指向右侧的箭头
        cell?.accessoryType = .DisclosureIndicator
        
        return cell!
    }
    
    
}
