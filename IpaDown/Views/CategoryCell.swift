//
//  CategoryCell.swift
//  IpaDown
//
//  Created by ice on 16/01/01
//  Copyright © 2016年 k. All rights reserved.
//

import UIKit

//分类的自定义cell

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    
    
    //传入的是list中的模型
    func configCell(type: CategoryType){
        
        let url = NSURL(string: type.icon!)
        
        leftImageView.kf_setImageWithURL(url!)
        
        titleLabel.text = type.title
        
        descLabel.text = type.desc
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
