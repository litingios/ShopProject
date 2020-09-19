//
//  RightTopCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/11.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class RightTopCell: UICollectionViewCell {
    @IBOutlet weak var titleLable: UILabel!
    
    var model: CategorySmallModel? {
        didSet{
            guard let model = model else {return}
            self.titleLable.text = model.mallSubName!
            
            if model.isSelect == true {
                self.titleLable.textColor = MainColor
            }else{
                self.titleLable.textColor = UIColor .black
            }
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
