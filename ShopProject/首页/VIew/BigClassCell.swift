//
//  BigClassCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/8.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class BigClassCell: UITableViewCell {
    
    var backGoodId: ((String) ->())?

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var leftBigView: UIImageView!
    @IBOutlet weak var leftSmallView: UIImageView!
    @IBOutlet weak var rightOneView: UIImageView!
    @IBOutlet weak var rightTwoView: UIImageView!
    @IBOutlet weak var rightThreeView: UIImageView!
    
    var model: AdvertesPictureModel?{
        didSet{
            guard let model = model else {return}
            self.topImageView.kf.setImage(with: URL(string:model.PICTURE_ADDRESS! ))
            self.leftBigView.kf.setImage(with: URL(string: model.goods_array![0].image!))
            self.rightOneView.kf.setImage(with: URL(string: model.goods_array![1].image!))
            self.rightTwoView.kf.setImage(with: URL(string: model.goods_array![2].image!))
            self.leftSmallView.kf.setImage(with: URL(string: model.goods_array![3].image!))
            self.rightThreeView.kf.setImage(with: URL(string: model.goods_array![4].image!))
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none

        self.topImageView.contentMode = UIView.ContentMode.scaleToFill
        self.topImageView.clipsToBounds = true
        
        
        self.leftBigView.contentMode = UIView.ContentMode.scaleToFill
        self.leftBigView.clipsToBounds = true
        self.leftBigView.isUserInteractionEnabled = true
        self.leftBigView.addGestureRecognizer(UITapGestureRecognizer(target: self ,action: #selector(iconClick01)))

        
        self.rightOneView.contentMode = UIView.ContentMode.scaleToFill
        self.rightOneView.clipsToBounds = true
        self.rightOneView.isUserInteractionEnabled = true
        self.rightOneView.addGestureRecognizer(UITapGestureRecognizer(target: self ,action: #selector(iconClick02)))
        
        self.rightTwoView.contentMode = UIView.ContentMode.scaleToFill
        self.rightTwoView.clipsToBounds = true
        self.rightTwoView.isUserInteractionEnabled = true
        self.rightTwoView.addGestureRecognizer(UITapGestureRecognizer(target: self ,action: #selector(iconClick03)))
        
        self.leftSmallView.contentMode = UIView.ContentMode.scaleToFill
        self.leftSmallView.clipsToBounds = true
        self.leftSmallView.isUserInteractionEnabled = true
        self.leftSmallView.addGestureRecognizer(UITapGestureRecognizer(target: self ,action: #selector(iconClick04)))
        
        self.rightThreeView.contentMode = UIView.ContentMode.scaleToFill
        self.rightThreeView.clipsToBounds = true
        self.rightThreeView.isUserInteractionEnabled = true
        self.rightThreeView.addGestureRecognizer(UITapGestureRecognizer(target: self ,action: #selector(iconClick05)))
        
    }
    
    @objc func iconClick01(recognizer:UITapGestureRecognizer){
        backGoodId!((self.model?.goods_array![0].goodsId!)!)
    }
    
    @objc func iconClick02(recognizer:UITapGestureRecognizer){
        backGoodId!((self.model?.goods_array![1].goodsId!)!)
    }
    
    @objc func iconClick03(recognizer:UITapGestureRecognizer){
        backGoodId!((self.model?.goods_array![2].goodsId!)!)
    }
    
    @objc func iconClick04(recognizer:UITapGestureRecognizer){
        backGoodId!((self.model?.goods_array![3].goodsId!)!)
    }
    
    @objc func iconClick05(recognizer:UITapGestureRecognizer){
        backGoodId!((self.model?.goods_array![4].goodsId!)!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
