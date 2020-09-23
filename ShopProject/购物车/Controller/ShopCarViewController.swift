//
//  ShopCarViewController.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/3.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON
import WCDBSwift

class ShopCarViewController: LTSuperViewController {

    private var goodsList: [GoodItem]? //底部列表数据
    lazy var selectAllBtn: UIButton = {
        let selectAllBtn = UIButton.init(type: .custom)
        selectAllBtn .setTitle("全选", for: .normal)
        selectAllBtn .setTitleColor(UIColor.black, for: .normal)
        selectAllBtn .setTitleColor(MainColor, for: .selected)
        selectAllBtn.backgroundColor = BackViewColor
        selectAllBtn .setImage(UIImage.init(named: "reasonNoSelect"), for: .normal)
        selectAllBtn .setImage(UIImage.init(named: "add_select_card"), for: .selected)
        selectAllBtn .imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        selectAllBtn .addTarget(self, action: #selector(selectAllBtnCiled), for: .touchUpInside)
        return selectAllBtn
    }()
    
    lazy var heLable:UILabel = {
        let heLable = UILabel()
        heLable.text = "合计:"
        heLable.textColor = UIColor.black
        heLable.textAlignment = .right
        heLable.font = UIFont.systemFont(ofSize: 16)
        return heLable
    }()
    
    lazy var allPriceLab: UILabel = {
        let allPriceLab = UILabel()
        allPriceLab.text = "￥ 0.0"
        allPriceLab.textAlignment = .right
        allPriceLab.textColor = UIColor .red
        allPriceLab.font = UIFont.systemFont(ofSize: 15)
        return allPriceLab
    }()
    
    lazy var desLab: UILabel = {
        let desLab = UILabel()
        desLab.text = "满68元免配送费,预购免费送费"
        desLab.textAlignment = .right
        desLab.textColor = UIColor .black
        desLab.font = UIFont.systemFont(ofSize: 12)
        return desLab
    }()
    
    lazy var returnBtn: UIButton = {
        let returnBtn = UIButton.init(type: .custom)
        returnBtn .setTitle("结算(9)", for: .normal)
        returnBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        returnBtn .setTitleColor(UIColor.white, for: .normal)
        returnBtn.backgroundColor = MainColor
        returnBtn.clipsToBounds = true
        returnBtn.layer.borderWidth = 1
        returnBtn.layer.borderColor = MainColor.cgColor
        returnBtn.layer.cornerRadius = 4
        returnBtn .addTarget(self, action: #selector(returnBtnCiled), for: .touchUpInside)
        return returnBtn
    }()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.allPriceLab.text = "￥ 0.0"
        self.selectAllBtn.isSelected = false
        headerRereshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = BackViewColor
        self.tableView.es.removeRefreshFooter()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.tableView.register(ShopCarCell.self, forCellReuseIdentifier: "ShopCarCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view .addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(tabBarHeight+60))
        }
        creatBottowView()
    }
    
    override func headerRereshing() {
        
        if let goodsArr: [GoodItem] = WCDManager.share.qurey(fromTable: DBTableName.sampleTable){
            self.goodsList = goodsArr
            self.tableView .reloadData()
            self.tableView.es.stopPullToRefresh()
            self.tableView.es.stopLoadingMore()
        }
    }
    
    func creatBottowView() -> Void {
        
        self.view .addSubview(self.selectAllBtn)
        self.view .addSubview(self.heLable)
        self.view .addSubview(self.allPriceLab)
        self.view .addSubview(self.desLab)
        self.view .addSubview(self.returnBtn)
        self.selectAllBtn.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.left.equalTo(20)
            make.top.equalTo(self.tableView.snp.bottom).offset(0)
            make.width.equalTo(80)
        }
        self.returnBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.tableView.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
        self.allPriceLab.snp.makeConstraints { (make) in
            make.right.equalTo(self.returnBtn.snp.left).offset(-15)
            make.top.equalTo(self.tableView.snp.bottom).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        self.desLab.snp.makeConstraints { (make) in
            make.right.equalTo(self.returnBtn.snp.left).offset(-15)
            make.top.equalTo(self.allPriceLab.snp.bottom).offset(3)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        self.heLable.snp.makeConstraints { (make) in
            make.right.equalTo(self.allPriceLab.snp.left).offset(-10)
            make.top.equalTo(self.tableView.snp.bottom).offset(10)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
    }
    
    @objc func selectAllBtnCiled() -> Void {
        self.selectAllBtn.isSelected = !self.selectAllBtn.isSelected
        /// 相加选中商品价钱 * selectItem.presentPrice
        var allPrice: Float = 0
        for selectItem in self.goodsList! {
             selectItem.isSelect = self.selectAllBtn.isSelected
            if selectItem.isSelect == true {
                let presentPrice: Float = Float(selectItem.presentPrice!)!
                allPrice += Float(selectItem.goodsCount)*presentPrice
            }
        }
        
        self.allPriceLab.text = "￥ \(allPrice)"
        self.tableView .reloadData()
    }
    
    @objc func returnBtnCiled() -> Void {
        
    }
    
}


extension ShopCarViewController: ShopCarDelegate{
    
    /// 添加数量
    func addGoodsCountMethond() {
        headerRereshing()
    }
    
    /// 减数量
    func subtractGoodsCountMethond() {
        headerRereshing()
    }
    
    /// 删除商品
    func removeGoodsMethond() {
        headerRereshing()
    }
    
}

extension ShopCarViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.goodsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ShopCarCell = tableView.dequeueReusableCell(withIdentifier: "ShopCarCell", for: indexPath) as! ShopCarCell
        cell.delegate = self
        cell.model = self.goodsList![indexPath.row]
        cell.backGoodItem = {[weak self]
            (item: GoodItem)in
            self?.selectItemData(item: item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = GoodDetailVC()
        view.goodsID = self.goodsList![indexPath.row].goodsId
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func selectItemData(item: GoodItem) -> Void {
        item.isSelect = !item.isSelect
        self.tableView .reloadData()
        
        /// 相加选中商品价钱 * selectItem.presentPrice
        var allPrice: Float = 0
        for selectItem in self.goodsList! {
            if selectItem.isSelect == true {
                let presentPrice: Float = Float(selectItem.presentPrice!)!
                allPrice += Float(selectItem.goodsCount)*presentPrice
            }
        }
        self.allPriceLab.text = "￥ \(allPrice)"
        if allPrice == 0 {
            self.selectAllBtn.isSelected = false
        }
    }
    
}
