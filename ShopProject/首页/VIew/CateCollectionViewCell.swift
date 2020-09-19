//
//  CateCollectionViewCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/9.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class CateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var goodsImageView: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    
    var model: CategoryModel?{
        didSet{
            guard let model = model else {return}
            self.goodsImageView.kf.setImage(with: URL(string:model.image! ))
            self.nameLab.text = model.mallCategoryName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
