//
//  DetailImageCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/10.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class DetailImageCell: UITableViewCell {

    @IBOutlet weak var imgeView: UIImageView!
    
    var imageStr: String? {
        didSet{
            guard imageStr != nil else {return}
            self.imgeView.kf.setImage(with: URL(string:imageStr! ))
            self.imgeView.contentMode = UIView.ContentMode.scaleToFill
            self.imgeView.clipsToBounds = true
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
