//
//  BaseViewController.swift
//  IpaDown
//
//  Created by ice on 16/10/6.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//视图控制器的基础类  上面都有表格视图
class BaseViewController: MyNavViewController {

    
    lazy var dataArray = NSMutableArray()
    
    var tableView: UITableView?
    
    //下拉刷新
    var curPage: Int = 1
    var pageSize: Int = 20
    
    //下载列表数据  //子类重写
    func downloadData(){
        print("子类必须实现这个方法:\(__FUNCTION__)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createTableView()
       
        //下载数据
        self.curPage = 1
        self.pageSize = 20
        
        self.downloadData()
        
    }
    
    
    func createTableView(){
        
        //导航条上设置背景图片会改变坐标
        self.navigationController?.navigationBar.translucent = true
        
        //滚动视图的自适应
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tableView = UITableView(frame: CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49), style: .Plain)
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.view.addSubview(self.tableView!)
        
    }
    
    //添加刷新
    func addRefresh(){
        
        if tableView?.footerView == nil{
        
            //下拉刷新
            tableView?.headerView = XWRefreshNormalHeader(target: self, action: "loadFirstPage")
            
        }
        
        if tableView?.footerView == nil{
        
            //上拉加载更多
            tableView?.footerView = XWRefreshAutoNormalFooter(target: self, action: "loadNextPage")
        }
        
    }
    //下拉刷新
    func loadFirstPage(){
        
        curPage = 1
        
        downloadData()
        
        //下拉刷新需要做的其他事情
        refreshHeader()
        
    }
    
    //下拉刷新需要做的其他事情
    func refreshHeader(){
    
    }
    
    //上拉加载更多
    func loadNextPage(){
        
        curPage += 1
        
        downloadData()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

//MARK: UITableView代理
extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("子类必须实现tableView:numberOfRowsInSection")
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("子类必须实现tableView:cellForRowAtIndexPath")
        return UITableViewCell()
        
    }
    
}
