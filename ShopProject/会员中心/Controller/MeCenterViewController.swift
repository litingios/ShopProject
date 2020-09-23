//
//  MeCenterViewController.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/3.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class MeCenterViewController: LTSuperViewController {

    var dataSouce: [Array<Any>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = BackViewColor
        
        self.tableView.backgroundColor = MainColor
        self.tableView.es.removeRefreshFooter()
        self.tableView.es.removeRefreshHeader()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.tableView.register(UINib.init(nibName: "MeHeaderCell", bundle: nil), forCellReuseIdentifier: "MeHeaderCell")
        self.tableView.register(UINib.init(nibName: "MeCommonCell", bundle: nil), forCellReuseIdentifier: "MeCommonCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view .addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
           make.top.left.right.equalToSuperview()
           make.bottom.equalToSuperview().offset(0)
       }
        
        creatData()
        
    }
    
    func creatData() -> Void {
        
        let oneDict1 = ["image" : "wodedingdan-2", "name" : "领取优惠券"] as [String : Any]
        let oneDict2 = ["image" : "wodedingdan-2", "name" : "已领取优惠券"] as [String : Any]
        let oneDict3 = ["image" : "wodedingdan-2", "name" : "地址管理"] as [String : Any]
        let oneArray:[[String : Any]] = [oneDict1, oneDict2, oneDict3]
        
        let twoDict1 = ["image" : "wodedingdan-2", "name" : "关于商城"] as [String : Any]
        let twoDict2 = ["image" : "wodedingdan-2", "name" : "扫码进行投诉"] as [String : Any]
        let twoArray:[[String : Any]] = [twoDict1, twoDict2]

        let threeDict1 = ["image" : "wodedingdan-2", "name" : "分享收入明细"] as [String : Any]
        let threeArray:[[String : Any]] = [threeDict1]
        
        dataSouce = [oneArray,twoArray,threeArray]
        self.tableView .reloadData()
    }
}


extension MeCenterViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 10)
        view.backgroundColor = BackViewColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if(section == 1){
            return 3
        }else if(section == 2){
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 310
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:MeHeaderCell! = tableView.dequeueReusableCell(withIdentifier: "MeHeaderCell", for: indexPath) as? MeHeaderCell
            cell.backgroundColor = UIColor .white
            return cell
        }else{
            let cell:MeCommonCell! = tableView.dequeueReusableCell(withIdentifier: "MeCommonCell", for: indexPath) as? MeCommonCell
            cell.backgroundColor = UIColor .white
            if self.dataSouce != nil {
                cell.dict = self.dataSouce![indexPath.section-1][indexPath.row] as? [String : Any]
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
