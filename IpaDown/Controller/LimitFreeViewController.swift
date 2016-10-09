//
//  LimitFreeViewController.swift
//  IpaDown
//
//  Created by ice on 16/10/6.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit
import SwiftyJSON


//限免的类型
public enum LimitFreeType:Int{
    
    case TodayLimit
    case WeekLimit
    case TotalLimit
}

//限免界面
class LimitFreeViewController: BaseViewController {
    
    //限免的类型
    var TypeOfLimit: LimitFreeType = .TodayLimit

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMyNav()
        
        addRefresh()
 
    }
    //导航上
    func createMyNav(){
        
        let segCtrl = UISegmentedControl(items: ["今日限免","本周热门限免","热门限免总榜"])
        
        segCtrl.frame = CGRectMake(0, 0, kScreenWidth-80, 35)
        segCtrl.addTarget(self, action: "clickAction:", forControlEvents: .ValueChanged)
        
        //背景图片
        segCtrl.setBackgroundImage(UIImage(named: "navButton"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        
        //文字颜色
        segCtrl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        segCtrl.selectedSegmentIndex = 0
        
        navigationItem.titleView = segCtrl
    }
    
    //点击不同的按钮  不同的下载类型  和  显示类型   // 并且进行新的下载
    func clickAction(seg: UISegmentedControl){
        
        let index = seg.selectedSegmentIndex
        
        
        switch index{

            case 0:  TypeOfLimit = .TodayLimit
            case 1:  TypeOfLimit = .WeekLimit
            case 2:  TypeOfLimit = .TotalLimit
            default: break
            
        }
        
        //将表格视图复位
        tableView?.contentOffset = CGPointZero
         // 并且进行新的下载   //在下载后的代理里面curPage == 1  已经清空数组,所以此处不需要清空数组]
        
        curPage = 1  //新的接口  将curPage 置为1
        
        downloadData()
        
    }
    
    
    override func downloadData() {
        
        ProgressHUD.showOnView(view)
        
        var urlString = ""
        
        switch TypeOfLimit{  //不同的下载接口
            
            case .TodayLimit :
                
                urlString = String(format: kLimitToday, pageSize, curPage)
            
            case .WeekLimit:
                
                urlString = String(format: kLimitWeek, pageSize, curPage)
            
            case .TotalLimit:
                
                urlString = String(format: kLimitHot, pageSize, curPage)
        }
        
        let downloader = MyDownloader()
        
        downloader.delegate = self
        
        downloader.downloadWithUrlString(urlString, methodOfRequest: MyRequestMethod.MyGet, parameterDict: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: 下载后的代理

extension LimitFreeViewController: MyDownloaderDelegate{
    
    func downloader(downloader: MyDownloader, didFailWithError error: NSError) {
        
        ProgressHUD.hideAfterFailOnView(view)
    }
    
    func downloader(downloader: MyDownloader, didFinishWithData data: AnyObject) {
        
        //下拉时 先清空数组
        if curPage == 1{
            
            dataArray.removeAllObjects()
        }
        
        //解析数据
        let array = JSON(data).array!
        
        for dict in array{
            
            let model = HomeModel()
            
            model.setValuesForKeysWithDictionary(dict.dictionaryObject!)
            
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

extension LimitFreeViewController{
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 110
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "limitCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? LimitCell
        
        if cell == nil{
            
            cell = NSBundle.mainBundle().loadNibNamed("LimitCell", owner: nil, options: nil).last as? LimitCell
        }
        
        cell?.selectionStyle = .None
        
        let model = dataArray[indexPath.row] as! HomeModel
        
        cell?.configCell(model, atIndex: indexPath.row)
        
        return cell!
    }
}


