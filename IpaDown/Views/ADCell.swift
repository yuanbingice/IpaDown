//
//  ADCell.swift
//  IpaDown
//
//  Created by ice on 16/10/6.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

class ADCell: UITableViewCell {
    
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var myPageCtrl: UIPageControl!
    
    //接受广告下载完后的数据   利用属性观察器来进行cell的赋值
    var dataArray: NSArray?{
        
        didSet{
            
            let cnt = (dataArray?.count)!
            for i in 0..<cnt{
                
                let model = dataArray![i] as! ADModel
                
                let frame = CGRectMake(CGFloat(i)*kScreenWidth, 0, kScreenWidth, 140)
                let imageView = MyUtil.createImageView(frame, imageName: nil)
                
                let url = NSURL(string: model.pic!)
                
                imageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                
                myScrollView.addSubview(imageView)
                
            }
            
            myScrollView.delegate = self
            myScrollView.pagingEnabled = true
            myScrollView.bounces = false
            myScrollView.contentSize = CGSizeMake(CGFloat(cnt)*kScreenWidth, 140)
            
            myPageCtrl.numberOfPages = cnt
            
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: UIScrollView代理
extension ADCell: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        
        self.myPageCtrl.currentPage = index
    }
    
}

