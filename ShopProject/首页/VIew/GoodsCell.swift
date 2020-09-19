//
//  GoodsCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/8.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class GoodsCell: UICollectionViewCell {

    @IBOutlet weak var goodsImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var presentLable: UILabel!
    @IBOutlet weak var longLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.goodsImageView.backgroundColor = UIColor .white
        self.goodsImageView.contentMode = UIView.ContentMode.scaleToFill
        self.goodsImageView.clipsToBounds = true
        self.nameLable.textColor = MainColor
        self.presentLable.textColor = TextColor
        self.longLable.textColor = UIColor .lightGray
    }

    var model :GoodsModel? {
        didSet {
            guard let model = model else {return}
            self.goodsImageView.kf.setImage(with: URL(string:model.image! ))
            if model.name == nil {
                self.nameLable.text = model.goodsName
            }else{
                self.nameLable.text = model.name
            }
            
            if (model.mallPrice != nil) {
                self.presentLable.text = "￥\(model.mallPrice!)"
            }else{
                self.presentLable.text = "￥\(model.presentPrice!)"
            }
            
            if (model.price != nil) {
                self.longLable.text = "￥\(model.price!)"
            }else{
                self.longLable.text = "￥\(model.oriPrice!)"
            }
            
        }
    }
    
}

