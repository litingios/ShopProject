//
//  BuyMainCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/25.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class BuyMainCell: UITableViewCell {
    var model: GoodsModel? {
        didSet{
            guard let model = model else {return}
            self.goodsView.kf.setImage(with: URL(string: model.image1!))
            self.nameLable.text = model.goodsName
            self.countLable.text = "数量：x2"
            self.desLable.text = "七天无理由退换"
        }
    }
    
    @IBOutlet weak var goodsView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var countLable: UILabel!
    @IBOutlet weak var desLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.desLable.textColor = YellowColor
        
        self.goodsView.clipsToBounds = true
        self.goodsView.layer.borderWidth = 1
        self.goodsView.layer.borderColor = UIColor.lightGray.cgColor
        self.goodsView.layer.cornerRadius = 2
        self.goodsView.layer.masksToBounds = true
        self.countLable.textColor = UIColor.lightGray
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
