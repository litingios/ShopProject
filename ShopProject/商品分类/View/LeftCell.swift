//
//  LeftCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/10.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class LeftCell: UITableViewCell {
    @IBOutlet weak var nameLab: UILabel!
    
    var model: CategoryModel?{
        didSet{
            guard let model = model else {return}
            self.nameLab.text = model.mallCategoryName
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
