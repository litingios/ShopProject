//
//  AddCarVIew.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/12.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class AddCarVIew: UIView {

    
    lazy var leftView: UIImageView = {
        let leftView = UIImageView()
        leftView.image = UIImage.init(named: "qicheqianlian")
        return leftView
    }()
    
    
    lazy var addBtn: UIButton = {
        let addBtn = UIButton()
        addBtn.backgroundColor = GreenColor
        addBtn .setTitle("加入购物车", for: .normal)
        buyBtn .addTarget(self, action:#selector(addBtnCiled), for: .touchUpInside)
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
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self .addSubview(self.leftView)
        self .addSubview(self.addBtn)
        self .addSubview(self.buyBtn)
        
        self.leftView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
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
        
    }
    
    
    // 立即购买
    @objc func buyBtnCiled() -> Void {
        
    }
    
    
    
    
    
    
    
}
