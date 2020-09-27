//
//  BuyHeaderCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/25.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class BuyHeaderCell: UITableViewCell {
    @IBOutlet weak var leftView: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var addressLab: UILabel!
    @IBOutlet weak var desLab: UILabel!
    @IBOutlet weak var backView: UIView!
    
    var model: AddressModel? {
        didSet{
            guard let model = model else {return}
            self.leftView.text = (model.username! as NSString).substring(to: 1)
            self.nameLable.text = model.username
            self.numberLable.text = model.telephone
            self.addressLab.text = (model.address!) + (model.houseNumber!)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        leftView.clipsToBounds = true
        leftView.layer.borderWidth = 1
        leftView.font = UIFont.systemFont(ofSize: 15)
        leftView.layer.borderColor = UIColor.lightGray.cgColor
        leftView.layer.cornerRadius = 15
        leftView.layer.masksToBounds = true
        leftView.backgroundColor = UIColor.lightGray

        
        backView.clipsToBounds = true
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.white.cgColor
        backView.layer.cornerRadius = 6
        backView.layer.masksToBounds = true
        backView.backgroundColor = UIColor.white
        
        self.desLab.textColor = YellowColor
        
    }
}
