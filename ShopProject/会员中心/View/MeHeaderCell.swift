//
//  MeHeaderCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/21.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class MeHeaderCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var lineLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backView.backgroundColor = MainColor
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.lineLab.backgroundColor = BackViewColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
