//
//  DailyViewController.swift
//  IpaDown
//
//  Created by ice on 16/01/01
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

import SwiftyJSON

//每日推荐的页面
class DailyViewController: BaseViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        addNavTitle("每日一荐")
        
        addRefresh()
        
        addBackBtn(self, action: "backAction")
    }
    
    //返回上一界面
    func backAction(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    //下载每日的数据
    override func downloadData() {
        
        ProgressHUD.showOnView(view)
        
        let urlString = String(format: kDailyUrl, pageSize, curPage)
        
        let downloader = MyDownloader()
        
        downloader.delegate = self
        
        downloader.downloadWithUrlString(urlString, methodOfRequest: MyRequestMethod.MyGet, parameterDict: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
        
    }
    
}

//MARK: 下载后的代理
extension DailyViewController: MyDownloaderDelegate{
    
    func downloader(downloader: MyDownloader, didFailWithError error: NSError) {
        
        ProgressHUD.hideAfterFailOnView(view)
    }
    
    func downloader(downloader: MyDownloader, didFinishWithData data: AnyObject) {
        
        if curPage == 1{
            
            dataArray.removeAllObjects()
        }
        
        let array = JSON(data).arrayObject!
        
        for dict in array{
            
            let model = HomeModel()
            
            model.setValuesForKeysWithDictionary(dict as! Dictionary)
            
            dataArray.addObject(model)
        }
        
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            self.tableView?.reloadData()
            
            self.tableView?.headerView?.endRefreshing()
            self.tableView?.footerView?.endRefreshing()
            
            //成功后隐藏
            ProgressHUD.hideAfterSuccessOnView(self.view)
        }
    
    }
}


//MARK: 表格视图的代理

extension DailyViewController{
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "homeCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? HomeCell
        
        if cell == nil {
            
            cell = NSBundle.mainBundle().loadNibNamed("HomeCell", owner: nil, options: nil).first as? HomeCell
        }
        
        cell?.selectionStyle = .None
        
        let model = dataArray[indexPath.row] as! HomeModel
        
        cell?.configCell(model, atIndex: indexPath.row)
        
        return cell!
        
    }
    
}
