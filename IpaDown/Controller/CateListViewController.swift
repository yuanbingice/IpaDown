//
//  CateListViewController.swift
//  IpaDown
//
//  Created by ice on 16/10/6.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

import SwiftyJSON


//具体的分类列表

class CateListViewController: BaseViewController {
    
    //查询条件,,,接口的参数
    var categoryStr: String?
    
    //导航显示的title
    var cateName: String?
    
    
    
    //选择e的按钮
    var chooseBtn: UIButton?
    
    //选中的序号,不同的序号对应不同的下载接口
    var selectIndex: Int = 0
    
    //半透明视图
    var maskView: UIView?
    
    //选择的控件
    var seg: UISegmentedControl?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        addNavTitle(self.cateName!)
        
        addBackBtn(self, action: "backAction")
        
        addRefresh()
        
        chooseBtn = addNavBtnTitle("筛选", bgImageName: "navButton", target: self, action: "clickBtn")
        
        
        //将视图加载 但是隐藏
        maskView = UIView(frame: CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49))
        
        maskView?.backgroundColor = UIColor.blackColor()
        maskView?.alpha = 0.8
        view.addSubview(maskView!)
        
        //label
        let label = MyUtil.createLabel(CGRectMake(kScreenWidth/2-140, (kScreenHeight-64-49)/2-50, 100, 20), text: "价格筛选:")
        
        label.textColor = UIColor.grayColor()
        maskView?.addSubview(label)
        
        
        //选择控件
        seg = UISegmentedControl(items: ["全部","免费","限免","付费"])
        
        seg?.frame =  CGRectMake(kScreenWidth/2-140, (kScreenHeight-64-49)/2-25, 280, 50)
        
        //文字颜色 和 大小
        seg?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.grayColor(), NSFontAttributeName : UIFont.boldSystemFontOfSize(18)], forState: UIControlState.Normal)
        
        seg?.addTarget(self, action: "segAction:", forControlEvents: .ValueChanged)
        maskView?.addSubview(seg!)
        
        //隐藏
        maskView?.hidden = true
    }
    
    //点击选择控件  进行的操作(重新下载数据)
    func segAction(seg: UISegmentedControl){
        
        //改变选中的标记  就会改变price的值  接口也相应的发生改变
        selectIndex = seg.selectedSegmentIndex
        
        curPage = 1  //将curpage = 1  会在解析数据之前清空dataArray
        
        downloadData() //下载
        
        //改变按钮的文字
        let title = seg.titleForSegmentAtIndex(selectIndex)
        chooseBtn?.setTitle(title, forState: .Normal)
        
        
        //将表格视图置为原位
        tableView?.contentOffset = CGPointZero
        
        
        //选中序号的背景图片
//        let image = UIImage(named: "navButton")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        seg.setImage(image, forSegmentAtIndex: selectIndex)
        
        
        //隐藏半透明视图
        maskView?.hidden = true
        
    }
    
    
    //点击选择按钮后的响应方法  // 显示一个半透明的界面  进行筛选
    func  clickBtn(){
        
            // 取消
        if (chooseBtn?.currentTitle)! == "取消"{
            
            //隐藏 视图//  恢复按钮的标题
            maskView?.hidden = true
            
            let title = seg?.titleForSegmentAtIndex(selectIndex)
            
            chooseBtn?.setTitle(title, forState: .Normal)
            
        }else{//筛选界面
 
            //显示 并  改变按钮的标题
            maskView?.hidden = false
            
            chooseBtn?.setTitle("取消", forState: .Normal)
        }
        
    }
    
    //系在数据
    override func downloadData() {
        
        ProgressHUD.showOnView(view)
        
        var price = ""
        
        switch selectIndex{
            
            case 0: price = "all"
            case 1: price = "free"
            case 2: price = "pricedrop"
            case 3: price = "paid"
            default: break
            
        }
        
        let urlString = String(format: kCategoryUrl, categoryStr!, pageSize, curPage, price)
        
        let downloader = MyDownloader()
        
        downloader.delegate = self
        
        downloader.downloadWithUrlString(urlString, methodOfRequest: MyRequestMethod.MyGet, parameterDict: nil)
        
    }
    
    
    func backAction(){
        
        navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension CateListViewController: MyDownloaderDelegate{
    
    func downloader(downloader: MyDownloader, didFailWithError error: NSError) {
     
        ProgressHUD.hideAfterFailOnView(view)
    }
    
    func downloader(downloader: MyDownloader, didFinishWithData data: AnyObject) {
        
        if curPage == 1{
            
            dataArray.removeAllObjects()
        }
        
        //看得出的是什么类型  此处为[AnyObject]
        let array = JSON(data).arrayObject
        
        for dict in array!{
            
            let model = HomeModel()
            
            model.setValuesForKeysWithDictionary(dict as! Dictionary)
            
            dataArray.addObject(model)
            
        }
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            self.tableView?.reloadData()
            
            self.tableView?.headerView?.endRefreshing()
            self.tableView?.footerView?.endRefreshing()
            
            ProgressHUD.hideAfterSuccessOnView(self.view)
        }
        
    }
    
}

//MARK: 表格视图的代理
extension CateListViewController{
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "homeCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? HomeCell
        
        if  cell == nil{
            
            cell = NSBundle.mainBundle().loadNibNamed("HomeCell", owner: nil, options: nil).last as? HomeCell
        }
        
        let model = dataArray[indexPath.row] as! HomeModel
        
        cell?.configCell(model, atIndex: indexPath.row)
        
        
        return cell!
    }
    
}
