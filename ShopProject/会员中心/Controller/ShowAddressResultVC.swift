//
//  ShowAddressResultVC.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/24.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import WCDBSwift

class ShowAddressResultVC: LTSuperViewController {

    var dataArr: [AddressModel]?
    
    lazy var addBtn: UIButton = {
        let addBtn = UIButton.init(type: .custom)
        addBtn.clipsToBounds = true
        addBtn.layer.borderWidth = 1
        addBtn.layer.borderColor = MainColor.cgColor
        addBtn.layer.cornerRadius = 6
        addBtn.backgroundColor = MainColor
        addBtn.layer.masksToBounds = true
        addBtn .setTitle("添加新地址", for: .normal)
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addBtn.contentHorizontalAlignment = .right
        addBtn.frame = CGRect(x: 0, y: 0, width: 90, height: 30)
        addBtn .addTarget(self, action: #selector(addBtnCiled), for: .touchUpInside)
        return addBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "收货地址"
        let rightitem = UIBarButtonItem.init(customView: self.addBtn)
        self.navigationItem.rightBarButtonItem = rightitem
        
        self.view .addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview().offset(0)
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AddAddressCell.self, forCellReuseIdentifier: "AddAddressCell")
        self.tableView.estimatedRowHeight = 100;
        self.tableView.rowHeight = UITableView.automaticDimension;
        tableView.es.removeRefreshFooter()
        
        headerRereshing()
    }
    
    override func headerRereshing() {
        
        if let dataArr: [AddressModel] = WCDManager.share.qurey(fromTable: DBTableName.addressTable){
            self.dataArr = dataArr
            self.tableView .reloadData()
            self.tableView.es.stopPullToRefresh()
            self.tableView.es.stopLoadingMore()
        }
    }
    
    @objc func addBtnCiled() -> Void{
        let view = AddAddressVC()
        self.navigationController?.pushViewController(view, animated: true)
    }
}


extension ShowAddressResultVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AddAddressCell = tableView.dequeueReusableCell(withIdentifier: "AddAddressCell", for: indexPath) as! AddAddressCell
        cell.model = self.dataArr![indexPath.row]
        return cell
    }
    
}
