//
//  ActivityTableViewCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/9.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    
    func creatData(advertesPictureModel: AdvertesPictureModel,
                   shopInfoModle: ShopInfoModel,
                   zhouActivityList: [AdvertesPictureModel]?) -> Void {
        
        guard advertesPictureModel.PICTURE_ADDRESS != nil else {return}
        guard shopInfoModle.leaderImage != nil else {return}
        guard zhouActivityList != nil else {return}

        self.advertesPictureModel = advertesPictureModel
        self.shopInfoModle = shopInfoModle
        self.zhouActivityList = zhouActivityList
        
        self.keImageView.kf.setImage(with: URL(string:self.advertesPictureModel.PICTURE_ADDRESS! ))
        self.bigImageView.kf.setImage(with: URL(string: self.shopInfoModle.leaderImage! ))
        self.imageOneView.kf.setImage(with: URL(string: self.zhouActivityList![0].PICTURE_ADDRESS!))
        self.imageTwoView.kf.setImage(with: URL(string: self.zhouActivityList![1].PICTURE_ADDRESS!))
        self.imageThreeView.kf.setImage(with: URL(string: self.zhouActivityList![2].PICTURE_ADDRESS!))
        
    }
    
    // 客服数据
    var advertesPictureModel = AdvertesPictureModel()
    // 周年庆图片model
    var shopInfoModle = ShopInfoModel()
    // 周年庆活动
    var zhouActivityList: [AdvertesPictureModel]?
    
    private lazy var keImageView: UIImageView = {
        let keImageView = UIImageView()
        keImageView.contentMode = UIView.ContentMode.scaleToFill
        keImageView.clipsToBounds = true
        return keImageView
    }()
    
    private lazy var bigImageView: UIImageView = {
        let bigImageView = UIImageView()
        bigImageView.contentMode = UIView.ContentMode.scaleToFill
        bigImageView.clipsToBounds = true
        return bigImageView
    }()
    
    private lazy var imageOneView: UIImageView = {
        let imageOneView = UIImageView()
        imageOneView.contentMode = UIView.ContentMode.scaleToFill
        imageOneView.clipsToBounds = true
        return imageOneView
    }()
    
    private lazy var imageTwoView: UIImageView = {
        let imageTwoView = UIImageView()
        imageTwoView.contentMode = UIView.ContentMode.scaleToFill
        imageTwoView.clipsToBounds = true
        return imageTwoView
    }()
    
    private lazy var imageThreeView: UIImageView = {
        let imageThreeView = UIImageView()
        imageThreeView.contentMode = UIView.ContentMode.scaleToFill
        imageThreeView.clipsToBounds = true
        return imageThreeView
    }()
    

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() -> Void {
        
        self .addSubview(self.keImageView)
        self.keImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview().offset(0)
            make.height.equalTo(34)
        }
        
        self .addSubview(self.bigImageView)
        self.bigImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.keImageView.snp.bottom).offset(0)
            make.left.right.equalToSuperview().offset(0)
            make.height.equalTo(110)
        }
        
        self .addSubview(self.imageOneView)
        self.imageOneView.snp.makeConstraints { (make) in
            make.top.equalTo(self.bigImageView.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(0)
            make.width.equalTo(ScreenWidth/3)
            make.height.equalTo(160)
        }
        
        self .addSubview(self.imageTwoView)
        self.imageTwoView.snp.makeConstraints { (make) in
            make.top.equalTo(self.bigImageView.snp.bottom).offset(6)
            make.left.equalTo(self.imageOneView.snp.right).offset(0)
            make.width.equalTo(ScreenWidth/3)
            make.height.equalTo(160)
        }
        
        self .addSubview(self.imageThreeView)
        self.imageThreeView.snp.makeConstraints { (make) in
            make.top.equalTo(self.bigImageView.snp.bottom).offset(6)
            make.left.equalTo(self.imageTwoView.snp.right).offset(0)
            make.width.equalTo(ScreenWidth/3)
            make.height.equalTo(160)
        }
        
    }
    
}
