//
//  AddCarVIew.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import Spring
import WCDBSwift

public protocol AddCarVIewDelegate: NSObjectProtocol{
    func addCarMethod(goodCount: Int)
    func buyGoodsMethod()
}

class AddCarVIew: UIView {

    weak var delegate: AddCarVIewDelegate?
    var goodCount:Int = 0
    var goodsID: String?{
        didSet{
            guard goodsID != nil else {return}
            if let qureyARR:[GoodItem] =  WCDManager.share.qurey(fromTable: DBTableName.sampleTable, where: GoodItem.Properties.goodsId == String(self.goodsID!), orderBy: nil) {
                if qureyARR.count > 0 {
                    let item: GoodItem = qureyARR[0]
                    self.goodCount = item.goodsCount
                    self.springV.text = String(self.goodCount)
                }
            }
        }
    }
    
    lazy var leftView: UIImageView = {
        let leftView = UIImageView()
        leftView.image = UIImage.init(named: "qicheqianlian")
        return leftView
    }()
    
    
    lazy var addBtn: UIButton = {
        let addBtn = UIButton()
        addBtn.backgroundColor = GreenColor
        addBtn .setTitle("加入购物车", for: .normal)
        addBtn .addTarget(self, action:#selector(addBtnCiled), for: .touchUpInside)
        addBtn .setTitleColor(.white, for: .normal)
        return addBtn
    }()
    
    lazy var buyBtn: UIButton = {
        let buyBtn = UIButton()
        buyBtn.backgroundColor = UIColor .red
        buyBtn .setTitleColor(.white, for: .normal)
        buyBtn .setTitle("立即购买", for: .normal)
        buyBtn .addTarget(self, action:#selector(buyBtnCiled), for: .touchUpInside)
        return buyBtn
    }()
    
    //懒加载SpringView
    lazy var springV: SpringLabel = {
        let springV = SpringLabel()
        springV.textColor = UIColor .white
        springV.textAlignment = .center
        springV.font = UIFont.systemFont(ofSize: 12)
        springV.backgroundColor = MainColor
        springV.clipsToBounds = true
        springV.layer.borderWidth = 1
        springV.layer.borderColor = MainColor.cgColor
        springV.layer.cornerRadius = 9
        return springV
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self .addSubview(self.leftView)
        self .addSubview(self.addBtn)
        self .addSubview(self.buyBtn)
        self.addSubview(self.springV)
        
        self.leftView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        self.springV.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftView.snp.right)
            make.top.equalTo(2)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        self.addBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftView.snp.right).offset(15)
            make.top.height.equalToSuperview()
            make.width.equalTo((ScreenWidth-60)/2)
        }
        
        self.buyBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.addBtn.snp.right).offset(0)
            make.top.height.equalToSuperview()
            make.width.equalTo((ScreenWidth-60)/2)
        }
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 加入购物车
    @objc func addBtnCiled() -> Void {
        
        self.springV.isHidden = false
        //设置动画属性
        springV.animation = "wobble"
        springV.curve = "easeInOut"
        springV.duration = 1.0
        springV.animateToNext(completion: { () -> () in
            self.goodCount += 1
            self.springV.text = String(self.goodCount)
            self.delegate?.addCarMethod(goodCount: self.goodCount)
        })
    }
    
    // 立即购买
    @objc func buyBtnCiled() -> Void {
        delegate?.buyGoodsMethod()
    }
   
}
