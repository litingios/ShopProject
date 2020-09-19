//
//  DetailHeaderCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/10.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class DetailHeaderCell: UITableViewCell {

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var nameLabe: UILabel!
    @IBOutlet weak var zhiLable: UILabel!
    @IBOutlet weak var bianLable: UILabel!
    @IBOutlet weak var presentLable: UILabel!
    @IBOutlet weak var shiLable: UILabel!
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var songLable: UILabel!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var lineLable: UILabel!
    
    var model :GoodsModel? {
        didSet {
            
            guard let model = model else {return}
            self.topImageView.kf.setImage(with: URL(string:(model.image1!) ))
            self.presentLable.text = "￥\(model.presentPrice! )"
            self.shiLable.text = "￥\(model.oriPrice! )"
            self.nameLabe.text = model.goodsName
            self.bianLable.text = "编号:\(model.goodsSerialNumber!))"
            self.songLable.text = "  说明: >急速送达 > 正品保证"
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.line1.backgroundColor = BackViewColor
        self.line2.backgroundColor = BackViewColor
        self.topImageView.contentMode = UIView.ContentMode.scaleToFill
        self.topImageView.clipsToBounds = true
        
        zhiLable.layer.borderWidth = 1
        zhiLable.layer.borderColor = GreenColor.cgColor
        zhiLable.textColor = GreenColor
        zhiLable.layer.cornerRadius = 4
        zhiLable.layer.masksToBounds = true
        zhiLable.backgroundColor = QianGreenColor
        
        self.bianLable.textColor = TextColor
        self.presentLable.textColor = RedColor
        self.shiLable.textColor = UIColor .lightGray
        self.songLable.textColor = RedColor
        self.lineLable.backgroundColor = UIColor .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
