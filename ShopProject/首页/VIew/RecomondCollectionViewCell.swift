//
//  RecomondCollectionViewCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/9.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class RecomondCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lineLable: UILabel!
    @IBOutlet weak var goodsImageView: UIImageView!
    @IBOutlet weak var presentLable: UILabel!
    @IBOutlet weak var longLable: UILabel!
    
    var model: RecommendModel?{
        didSet{
            guard let model = model else {return}
            self.goodsImageView.kf.setImage(with: URL(string:model.image! ))
            self.presentLable.text = "￥\(model.mallPrice!)"
            self.longLable.text = "￥\(model.price!)"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lineLable.backgroundColor = BackViewColor
        self.presentLable.textColor = TextColor
        self.longLable.textColor = UIColor .lightGray

    }

}
