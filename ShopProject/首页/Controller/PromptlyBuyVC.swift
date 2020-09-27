//
//  PromptlyBuyVC.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/25.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import WCDBSwift

class PromptlyBuyVC: LTSuperViewController {

    var model: AddressModel?
    var goodsModel: GoodsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var model: GoodsModel? {
            didSet{
                guard let model = model else {return}
                self.goodsModel = model
                
                self.tableView .reloadData()
            }
        }
        
        self.navigationItem.title = "确认订单"
        self.view.backgroundColor = BackViewColor
        self.view .addSubview(self.tableView)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "BuyHeaderCell", bundle: nil), forCellReuseIdentifier: "BuyHeaderCell")
        self.tableView.register(UINib.init(nibName: "BuyMainCell", bundle: nil), forCellReuseIdentifier: "BuyMainCell")
        self.tableView.backgroundColor = BackViewColor
        self.tableView.es .removeRefreshFooter()
        headerRereshing()
    }
    
    override func headerRereshing() {
        if let addressArr:[AddressModel] = WCDManager.share.qurey(fromTable: DBTableName.addressTable) {
            if addressArr.count > 1 {
                self.model = addressArr[1]
            }
            if addressArr.count > 0 {
                self.model = addressArr[0]
            }
            self.tableView .reloadData()
            self.tableView.es.stopPullToRefresh()
            self.tableView.es.stopLoadingMore()
        }
    }
    
}


extension PromptlyBuyVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 130
        }else{
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell:BuyHeaderCell! = tableView.dequeueReusableCell(withIdentifier: "BuyHeaderCell", for: indexPath) as? BuyHeaderCell
            cell.backgroundColor = BackViewColor
            cell.model = self.model
            return cell
        default:
            let cell:BuyMainCell! = tableView.dequeueReusableCell(withIdentifier: "BuyMainCell", for: indexPath) as? BuyMainCell
            cell.model = self.goodsModel
            cell.backgroundColor = BackViewColor
            return cell
        }
    }
    
    
}
