//
//  ShopCarCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/21.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import WCDBSwift

public protocol ShopCarDelegate: NSObjectProtocol{
    /// 加数量方法
    func addGoodsCountMethond()
    
    /// 减数量方法
    func subtractGoodsCountMethond()

    /// 删除方法
    func removeGoodsMethond()
    
}

class ShopCarCell: UITableViewCell {

    weak var delegate: ShopCarDelegate?
    var backGoodItem: ((GoodItem) ->())?

    var model:GoodItem? {
        didSet{
            guard let model = model else {return }
            
            self.selectBtn.isSelected = model.isSelect
            self.goodsView.kf.setImage(with: URL(string: model.image1!))
            self.nameLab.text = model.goodsName
            self.countLab.text = String(model.goodsCount)
            self.oriPriceLab.text = "￥ \(model.oriPrice!)"
            self.presentPriceLab.text = "￥ \(model.presentPrice!)"
            
        }
    }
    
    lazy var selectBtn: UIButton = {
        let selectBtn = UIButton.init(type: .custom)
        selectBtn.setImage(UIImage.init(named: "reasonNoSelect"), for: .normal)
        selectBtn.setImage(UIImage.init(named: "add_select_card"), for: .selected)
        selectBtn.addTarget(self, action: #selector(selectBtnCiled), for: .touchUpInside)
        return selectBtn
    }()
    
    lazy var goodsView: UIImageView = {
        let goodsView = UIImageView()
        goodsView.contentMode = UIView.ContentMode.scaleToFill
        goodsView.clipsToBounds = true
        goodsView.layer.borderWidth = 1
        goodsView.layer.borderColor = UIColor.lightGray.cgColor
        goodsView.layer.cornerRadius = 2
        goodsView.layer.masksToBounds = true
        goodsView.backgroundColor = UIColor.white
        return goodsView
    }()
    
    lazy var nameLab: UILabel = {
        let nameLab = UILabel()
        nameLab.textColor = UIColor .black
        nameLab.text = "台湾香江台湾香江台湾香江台湾香江台湾香江台湾香江"
        nameLab.font = UIFont .systemFont(ofSize: 14)
        return nameLab
    }()
    
    lazy var subBtn: UIButton = {
        let subBtn = UIButton.init(type: .custom)
        subBtn .setTitle("-", for: .normal)
        subBtn .setTitleColor(TextColor, for: .normal)
        subBtn.titleLabel?.font = UIFont .systemFont(ofSize: 15)
        subBtn .addTarget(self, action: #selector(subBtnCiled), for: .touchUpInside)
        return subBtn
    }()
    
    lazy var countLab: UILabel = {
        let countLab = UILabel()
        countLab.textColor = TextColor
        countLab.font = UIFont .systemFont(ofSize: 15)
        countLab.text = "10"
        countLab.textAlignment = .center
        countLab.clipsToBounds = true
        countLab.layer.borderWidth = 1
        countLab.layer.borderColor = UIColor.lightGray.cgColor
        countLab.layer.cornerRadius = 3
        return countLab
    }()
    
    lazy var addBtn: UIButton = {
        let addBtn = UIButton.init(type: .custom)
        addBtn .setTitle("+", for: .normal)
        addBtn .setTitleColor(TextColor, for: .normal)
        addBtn.titleLabel?.font = UIFont .systemFont(ofSize: 15)
        addBtn .addTarget(self, action: #selector(addBtnCiled), for: .touchUpInside)
        return addBtn
    }()
    
    lazy var oriPriceLab: UILabel = {
       let oriPriceLab = UILabel()
       oriPriceLab.textColor = TextColor
       oriPriceLab.font = UIFont .systemFont(ofSize: 12)
        oriPriceLab.text = "￥ 60.98"
       return oriPriceLab
    }()
    
    lazy var presentPriceLab: UILabel = {
       let presentPriceLab = UILabel()
       presentPriceLab.textColor = UIColor .black
       presentPriceLab.font = UIFont .systemFont(ofSize: 15)
        presentPriceLab.text = "￥ 45.98"
       return presentPriceLab
    }()
    
    lazy var removeBtn: UIButton = {
        let removeBtn = UIButton.init(type: .custom)
        removeBtn .setImage(UIImage.init(named: "remove_recond"), for: .normal)
        removeBtn .addTarget(self, action: #selector(removeBtnCiled), for: .touchUpInside)
        return removeBtn
    }()
    
    private lazy var lineLable01: UILabel = {
       let lineLable01 = UILabel()
        lineLable01.backgroundColor = UIColor.lightGray
        return lineLable01
    }()

    private lazy var lineLable02: UILabel = {
        let lineLable02 = UILabel()
        lineLable02.backgroundColor = UIColor.lightGray
        return lineLable02
    }()
    
    private lazy var lineLable03: UILabel = {
        let lineLable03 = UILabel()
        lineLable03.backgroundColor = UIColor.lightGray
        return lineLable03
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        self .addSubview(self.selectBtn)
        self .addSubview(self.goodsView)
        self .addSubview(self.nameLab)
        self .addSubview(self.countLab)
        self .addSubview(self.lineLable01)
        self .addSubview(self.lineLable02)
        self .addSubview(self.subBtn)
        self .addSubview(self.addBtn)
        self .addSubview(self.removeBtn)
        self .addSubview(self.oriPriceLab)
        self .addSubview(self.lineLable03)
        self .addSubview(self.presentPriceLab)
        self.selectBtn.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(35)
            make.width.height.equalTo(30)
        }
        self.goodsView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(self.selectBtn.snp.right).offset(10)
            make.width.height.equalTo(80)
        }
        self.nameLab.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(self.goodsView.snp.right).offset(10)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-80)
        }
        self.countLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.goodsView.snp.bottom).offset(-5)
            make.left.equalTo(self.goodsView.snp.right).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(25)
        }
        self.lineLable01.snp.makeConstraints { (make) in
            make.top.equalTo(self.countLab.snp.top)
            make.left.equalTo(self.countLab.snp.left).offset(25)
            make.width.equalTo(1)
            make.height.equalTo(25)
        }
        self.lineLable02.snp.makeConstraints { (make) in
            make.top.equalTo(self.countLab.snp.top)
            make.right.equalTo(self.countLab.snp.right).offset(-25)
            make.width.equalTo(1)
            make.height.equalTo(25)
        }
        self.subBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.countLab.snp.top)
            make.left.equalTo(self.countLab.snp.left)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        self.addBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.countLab.snp.top)
            make.right.equalTo(self.countLab.snp.right).offset(0)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        self.presentPriceLab.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(self.nameLab.snp.right).offset(13)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-5)
        }
        self.oriPriceLab.snp.makeConstraints { (make) in
            make.top.equalTo(self.presentPriceLab.snp.bottom).offset(5)
            make.left.equalTo(self.nameLab.snp.right).offset(15)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-5)
        }
        self.lineLable03.snp.makeConstraints { (make) in
            make.top.equalTo(self.presentPriceLab.snp.bottom).offset(15)
            make.left.equalTo(self.nameLab.snp.right).offset(13)
            make.height.equalTo(1)
            make.right.equalToSuperview().offset(-15)
        }
        self.removeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.oriPriceLab.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-25)
            make.width.equalTo(22)
            make.height.equalTo(22)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectBtnCiled() -> (Void){
        backGoodItem!(self.model!)
    }
    
    @objc func subBtnCiled() -> (Void){
        var numberLable: Int = Int(self.countLab.text!)!
        if numberLable == 0 {
            self.countLab.text = "0"
            return
        }
        numberLable -= 1
        self.countLab.text = String(numberLable)
        updataGoodItem()
        delegate?.subtractGoodsCountMethond()
    }
    
    @objc func addBtnCiled() -> (Void){
        var numberLable: Int = Int(self.countLab.text!)!
        numberLable += 1
        self.countLab.text = String(numberLable)
        updataGoodItem()
        delegate?.addGoodsCountMethond()
    }
    
    @objc func removeBtnCiled() -> (Void){
        WCDManager.share.deleteFromDb(fromTable: DBTableName.sampleTable, where: GoodItem.Properties.goodsId == String(self.model!.goodsId!))
        delegate?.removeGoodsMethond()
    }
    
    // 更新商品信息
    func updataGoodItem() -> Void {
        let item = GoodItem.init()
        item.goodsId = self.model?.goodsId
        item.goodsName = self.model?.goodsName
        item.goodsCount = Int(self.countLab.text!)!
        item.oriPrice = self.model?.oriPrice
        item.presentPrice = self.model?.presentPrice
        item.image1 = self.model?.image1
        item.isSelect = false
        let properties = [
            GoodItem.Properties.goodsId,
            GoodItem.Properties.goodsName,
            GoodItem.Properties.goodsCount,
            GoodItem.Properties.oriPrice,
            GoodItem.Properties.presentPrice,
            GoodItem.Properties.isSelect,
            GoodItem.Properties.image1,
        ]
        WCDManager.share.update(fromTable: DBTableName.sampleTable, on: properties, itemModel: item, where: GoodItem.Properties.goodsId == String(self.model!.goodsId!))
    }

}
