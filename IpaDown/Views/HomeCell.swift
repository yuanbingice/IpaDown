//
//  HomeCell.swift
//  IpaDown
//
//  Created by ice on 16/10/6.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//首页的app自定义cell
class HomeCell: UITableViewCell {
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var rateLable: UILabel!
    @IBOutlet weak var categoryLable: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    
    func configCell(model: HomeModel, atIndex index: Int){
        
        //图片
        let url = NSURL(string: model.app_icon!)
        appImageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        
        //名字
        namelabel.text = "\(index+1)." + "\(model.post_title!)"
        namelabel.adjustsFontSizeToFitWidth = true
        
        //评级  //有的没有评级
        if model.app_apple_rated != nil{
            
            let rate = Float(model.app_apple_rated!)
            
            rateLable.text = "评分:\(rate!)星"
        }else{
            rateLable.text = "评分:未知"
        }
        
        //类别
        categoryLable.text = "类别:\(model.app_category!)"
        
        //大小
        sizeLabel.text = model.app_size!
        //文字大小适应
        sizeLabel.adjustsFontSizeToFitWidth = true
        
        //描述
        descLabel.text  = model.app_desc
        
        //状态 
        
        if Int(model.app_pricedrop!) == 1{
            //降价或限免
            
            statusLabel.backgroundColor = UIColor(red: 50.0/255.0, green: 120.0/255.0, blue: 200.0/255.0, alpha: 1.0)
            
            //裁剪圆角
            statusLabel.layer.cornerRadius = 8
            statusLabel.clipsToBounds = true
            
            statusLabel.textColor = UIColor.whiteColor()
            
            if Float(model.app_price!)! > 0{
                
                statusLabel.text = "降价中"
            }else{
                
                statusLabel.text = "限免中"
            }
            
            
        }else if Int(model.app_pricedrop!)! == 0{
            //原价
            
            statusLabel.backgroundColor = UIColor(red: 50.0/255.0, green: 70.0/255.0, blue: 120.0/255.0, alpha: 1.0)
            //裁剪圆角
            statusLabel.layer.cornerRadius = 8
            statusLabel.clipsToBounds = true
            
            if Float(model.app_price!)! > 0{
                
                statusLabel.text = "\(model.app_price!)元"
                
            }else{
            
                statusLabel.text = "免费"
            }
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
