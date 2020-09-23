//
//  MeCommonCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/21.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class MeCommonCell: UITableViewCell {
    @IBOutlet weak var imView: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    
    var dict :[String : Any]? {
        didSet {
            guard let dict = dict else {return}
            self.imView.image = UIImage.init(named: dict["image"] as! String)
            self.nameLab.text = dict["name"] as? String
            
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
