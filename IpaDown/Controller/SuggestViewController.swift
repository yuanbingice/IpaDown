//
//  SuggestViewController.swift
//  IpaDown
//
//  Created by ice on 16/01/01
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//推荐界面
class SuggestViewController: MyNavViewController {
    
    var pageCtrl: UIPageControl?
    
    var scrollView: UIScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        

        addNavTitle("精品栏目推荐")
        
        //配置显示的UI
        createBtn()
        
        
    }
    
    //配置显示的UI
    func createBtn(){
        
        //导航条上设置背景图片会改变坐标
        
        navigationController?.navigationBar.translucent = true
        
        automaticallyAdjustsScrollViewInsets = false
        
        scrollView = UIScrollView(frame: CGRectMake(0, 64, kScreenWidth, kScreenHeight-49-64))
    
        scrollView?.delegate = self
        
        view.addSubview(scrollView!)
        
        //图片和 标题数组
        let nameArray = ["每日一荐","本周热门应用","本周热门游戏","上榜精品","GameCenter游戏","装机必备","知名网站客户端","五星好评应用","随便看看","i派党移动版","苹果新闻","iphone4壁纸","用户交流QQ群","i派党移动微博"]
        let imageArray = ["i-commend","i-soft","i-game","i-top","i-gamecenter","i-musthave","i-famous","i-star","i-random","i-ipadown","i-news","i-download","i-qqgroup","i-sinaweibo"]
        
        //创建按钮
    
        for i in 0..<nameArray.count{
            
            let page = i/12 //页数
            let colNumber = 3
            let btnW: CGFloat = 90
            let btnH: CGFloat = 92
            
            let offsetX: CGFloat = 30  //第一列的x值
            let spaceX: CGFloat = (kScreenWidth-CGFloat(colNumber)*btnW-offsetX*2)/CGFloat(colNumber-1)  //列间距
            
            let offsetY: CGFloat = 30 //第一行的y值
            let spaceY: CGFloat = 40  //行间距
            
            let rowAndCol = i % 12 //用于计算按钮的行和列
            
            let row = rowAndCol / colNumber  //该按钮的行
            let col = rowAndCol % colNumber  //该按钮的列
            
            //按钮的原点
            let btnX = offsetX + CGFloat(col) * (btnW + spaceX) + kScreenWidth * CGFloat(page)
            let btnY = offsetY + CGFloat(row) * (btnH + spaceY)
            
            //创建按钮
            
            let frame = CGRectMake(btnX, btnY, btnW, btnH)
            let btn = MyUtil.createBtn(frame, title: nil, bgImageName: imageArray[i], target: self, action: "clickBtn:")
            btn.tag = 100 + i
            
            scrollView?.addSubview(btn)
            
            
            //创建label
            let frameOfLabel = CGRectMake(btnX, btnY+btnH, btnW, 20)
            let label = MyUtil.createLabel(frameOfLabel, text: nameArray[i])
            label.font = UIFont.systemFontOfSize(12)
            //自适应宽度
            label.adjustsFontSizeToFitWidth = true
            
            label.textAlignment = .Center
            
            scrollView?.addSubview(label)
        }
        
        //计算页数,并确定滑动范围
        let pageCnt = (nameArray.count + 11) / 12
        
        scrollView?.contentSize = CGSizeMake(CGFloat(pageCnt)*kScreenWidth , 0)
        
        scrollView?.pagingEnabled = true
        
        scrollView?.showsHorizontalScrollIndicator = false
        
        scrollView?.showsVerticalScrollIndicator = false
        
        
        //页码控制器
        pageCtrl = UIPageControl(frame: CGRectMake(0, kScreenHeight-49-40, kScreenWidth, 40))
        
        pageCtrl?.currentPageIndicatorTintColor = UIColor.blueColor()
        pageCtrl?.pageIndicatorTintColor = UIColor.redColor()
        
        pageCtrl?.numberOfPages = pageCnt
        
//        pageCtrl?.currentPage = 1
        view.addSubview(pageCtrl!)
        
    }
    
    
    //按钮的响应方法
    func clickBtn(btn: UIButton){
        
        if btn.tag == 100{ //点击每日推荐进入相应的界面
        
            let ctrl = DailyViewController()
            
            navigationController?.pushViewController(ctrl, animated: true)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        
    }


}

//MARK: 滚动视图的代理

extension SuggestViewController: UIScrollViewDelegate{
    
    //完成减速
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        pageCtrl?.currentPage = index
        
    }
    
}
