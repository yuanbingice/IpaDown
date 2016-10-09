//
//  CategoryViewController.swift
//  IpaDown
//
//  Created by ice on 16/01/01
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit
import SwiftyJSON

//分类界面

class CategoryViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavTitle("按分类筛选")
        
    }
    
    
    override func downloadData() {
        
        ProgressHUD.showOnView(view)
        
        let urlString = kCategoryListUrl
        
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
extension CategoryViewController: MyDownloaderDelegate{
    
    func downloader(downloader: MyDownloader, didFailWithError error: NSError) {
        
        ProgressHUD.hideAfterFailOnView(view)
    }
    
    func downloader(downloader: MyDownloader, didFinishWithData data: AnyObject) {
        
        let array = JSON(data).array!
        
        for dict in array{
            
            //对分类的模型赋值
            let model = CategoryModel()
            model.setValuesForKeysWithDictionary(dict.dictionaryObject!) //会对不是数组的数据进行赋值
            
            
            //list 内的数据
            let listArray = dict.dictionaryObject!["list"] as! Array<Dictionary<String, AnyObject>>
            
            let typeArray = NSMutableArray()
            for listDict in listArray{
                
                let typeModel = CategoryType()
                
                typeModel.setValuesForKeysWithDictionary(listDict)
                
                typeArray.addObject(typeModel)
            }
            
            //对分类模型中的数组进行赋值  // 这样改模型中会是 一个是字符串属性  一个是数组
            model.typeArray = typeArray
            
            dataArray.addObject(model)  //model的属性 一个是数据 一个是数组
        }
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            self.tableView?.reloadData()
            
            self.tableView?.headerView?.endRefreshing()
            self.tableView?.footerView?.endRefreshing()
            
            ProgressHUD.hideAfterSuccessOnView(self.view)
        }
        
    }
    
}

//MARK: 表格视图代理
extension CategoryViewController{
    
    //分组
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return dataArray.count
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //不同的section对应 相应的row
        
        let model = dataArray[section] as! CategoryModel

        //内部数组的个数即 每组的行数
        let cnt = model.typeArray?.count
        
        return cnt!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "categorCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CategoryCell
        if cell == nil{
            
            cell = NSBundle.mainBundle().loadNibNamed("CategoryCell", owner: nil, options: nil).last as? CategoryCell
        }

        let model = dataArray[indexPath.section] as! CategoryModel
        
        //内部的模型
        let typeModel = model.typeArray![indexPath.row] as! CategoryType
        
        cell?.configCell(typeModel)
        
        return cell!
        
    }
    
    //section的标签
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let model = dataArray[section] as! CategoryModel
        
        return model.header
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 80
    }
    
    
    //选中进入相应的界面
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let model = dataArray[indexPath.section] as! CategoryModel
        
        let typeModel = model.typeArray![indexPath.row] as! CategoryType
        
        
        
        let listCtrl = CateListViewController()
        //接口的参数
        listCtrl.categoryStr = typeModel.querystr
        
        //导航上显示的标签
        listCtrl.cateName = typeModel.title
        
        navigationController?.pushViewController(listCtrl, animated: true)
    }
    
    
}
