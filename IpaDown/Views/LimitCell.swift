//
//  LimitCell.swift
//  IpaDown
//
//  Created by ice on 16/10/6.
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//限免的自定义cell

class LimitCell: UITableViewCell {
    
    @IBOutlet weak var appImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    func configCell(model: HomeModel, atIndex index: Int){
        
        //图片
        let url = NSURL(string: model.app_icon!)
        appImageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        
        //名字
        nameLabel.text = "\(index+1)." + "\(model.post_title!)"
        nameLabel.adjustsFontSizeToFitWidth = true
        
        
        //评级  //有的没有评级
        if model.app_apple_rated != nil{
            
            let rate = Float(model.app_apple_rated!)
            
            rateLabel.text = "评分:\(rate!)星"
        }else{
            rateLabel.text = "评分:未知"
        }
        
        //类别
        categoryLabel.text = "类别:\(model.app_category!)"
        
        //大小
        sizeLabel.text = model.app_size!
        
        //描述
        descLabel.text  = model.app_desc
        

        
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
