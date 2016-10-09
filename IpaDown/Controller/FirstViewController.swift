//
//  FirstViewController.swift
//  IpaDown
//
//  Created by ice on 16/01/01
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit
import SwiftyJSON


//首页

class FirstViewController: BaseViewController {

    //广告的数据
    lazy var adArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavTitle("精品限时免费")
        
        //下拉刷新
        addRefresh()
        
        //下载广告数据
        downloadAdvertismentData()
        
    }
    
    
    //下拉刷新也需要重新下载广告 //下拉的额外操作
    override func refreshHeader() {
        
        if adArray.count > 0{
         
            adArray.removeAllObjects()
        }
        
        downloadAdvertismentData()
    }
    
    
    //下载广告数据
    func downloadAdvertismentData(){
        
        let urlString = kHomeAdUrl
        
        let downloader = MyDownloader()
        downloader.type = .Advertisement   //下载的类型区分
        downloader.delegate = self
        
        downloader.downloadWithUrlString(urlString, methodOfRequest: MyRequestMethod.MyGet, parameterDict: nil)
        
    }
    //下载数据
    override func downloadData() {
        
        ProgressHUD.showOnView(view)
        
        let urlString = String(format: kHomeListUrl, pageSize, curPage)
        
        let downloader = MyDownloader()
        
        downloader.type = .AppTable
        
        downloader.delegate = self
        
        downloader.downloadWithUrlString(urlString, methodOfRequest: MyRequestMethod.MyGet, parameterDict: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: 下载完后代理
extension FirstViewController: MyDownloaderDelegate{
    
    
    func downloader(downloader: MyDownloader, didFailWithError error: NSError) {
        
        if downloader.type == .Advertisement{//广告
            
            ProgressHUD.hideAfterFailOnView(view)
        }
    }
    
    //下载成功   //下载完后才后返回的是anyobject类型
    func downloader(downloader: MyDownloader, didFinishWithData data: AnyObject) {
        
        //广告
        if downloader.type == .Advertisement{
            
            //看得出的是什么类型  此处为[JSON]
            let array = JSON(data).array!
            
            for dict in array{

                let model = ADModel()
                
                model.setValuesForKeysWithDictionary(dict.dictionaryObject!)
                
                adArray.addObject(model)
            }
            
            //回主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.tableView?.reloadData()
                
                self.tableView?.headerView?.endRefreshing()
                self.tableView?.footerView?.endRefreshing()
            })
            

        }else{  //数据解析
            
            //下拉第一页  需要\先清空之前的数组
            if curPage == 1{
                
                dataArray.removeAllObjects()
            }
            
            let array = JSON(data).array!
            
            for dict in array{
                
                let model = HomeModel()
                
                model.setValuesForKeysWithDictionary(dict.dictionaryObject!)
                
                dataArray.addObject(model)
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.tableView?.reloadData()
                
                self.tableView?.headerView?.endRefreshing()
                self.tableView?.footerView?.endRefreshing()
                
                //表格的数据下载完了才成功隐藏
                ProgressHUD.hideAfterSuccessOnView(self.view)
            })
            
        }
        
    }
    
}


//MARK: tableView的代理

extension FirstViewController{
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var num = self.dataArray.count
        
        if adArray.count > 0{ //广告数组有数据
            
            num += 1
            
        }
        
        return num
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var h: CGFloat = 0
        
        if adArray.count > 0{ //广告数组有数据,区别
            
            if indexPath.row == 0{
                
                h = 160      //广告cell的高度
                
            }else{
                h = 110
            }
            
        }else{
            
            h = 110
            
        }
        
        return h
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if adArray.count > 0{ //广告数组有数据,区别
            
            if indexPath.row == 0{
                
                let cellId = "adCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? ADCell
                
                if cell == nil{
                    
                    cell = NSBundle.mainBundle().loadNibNamed("ADCell", owner: nil, options: nil).last as? ADCell
                }
                //给自定义cell类中的模型数组赋值 ,,, 属性观察器会配置UI
                cell?.dataArray = adArray

                return cell!
                
            }else{ // app的显示
                
                let cellId = "homeCellId"
                
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? HomeCell
                
                if cell == nil{
                    
                    cell = NSBundle.mainBundle().loadNibNamed("HomeCell", owner: nil, options: nil).last as? HomeCell
                    
                }
                
                cell?.selectionStyle = .None
                
                //此时使用1row开始
                let model = dataArray[indexPath.row - 1] as! HomeModel
                
                cell?.configCell(model, atIndex: indexPath.row-1)
                
                return cell!
            }
        
            
        }else{ //广告数组无数据,不显示广告
            
            
            let cellId = "homeCellId"
            
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? HomeCell
            
            if cell == nil{
                
                cell = NSBundle.mainBundle().loadNibNamed("HomeCell", owner: nil, options: nil).last as? HomeCell
                
            }
            
            cell?.selectionStyle = .None
            //此时使用0row开始
            let model = dataArray[indexPath.row] as! HomeModel
            
            cell?.configCell(model, atIndex: indexPath.row)
            
            return cell!
            
        }
        
    }
    
    
}


