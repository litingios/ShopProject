//
//  GoodDetailVC.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/9.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON
import SwiftMessages
import WCDBSwift
import ESPullToRefresh


class GoodDetailVC: LTSuperViewController {
    private var goodsModel = GoodsModel()
    private var strArr: [String] = []

    var goodsID: String?{
        didSet{
            guard goodsID != nil else {return}
            creatData(goodId: goodsID!)
        }
    }
    
    
    func creatData(goodId: String) -> Void {
                
        // 详情数据
        NetWorkRequest(.goodDetail(parameters: ["goodId":goodId]),isCarch: true ,carchID:"goodId-\(goodId)" as NSString,  completion: { (responseString) -> (Void) in
            // 轮播图数据
            let json = JSON(responseString)
            // 底部列表数据
            if let goodsModel = JSONDeserializer<GoodsModel>.deserializeFrom(json: json["data"]["goodInfo"].description) {
                // 从字符串转换为对象实例
                self.goodsModel = goodsModel
                // 将html转化成图片数组
                let arraySubstrings: [String] = ((self.goodsModel.goodsDetail?.components(separatedBy: "<img src="))!)

                for str in arraySubstrings {
                    if str == "" {
                        continue
                    }

                    if !str .contains("\" width") {
                        continue
                    }

                    let source = str
                    let startRang = source.range(of: "\"")!
                    let endRang = source.range(of: "\" width")!
                    let str01 = source[startRang.upperBound..<endRang.lowerBound]
                    self.strArr .append(String(str01))
                }
                // 刷新数据
                self.tableView .reloadData()
            }
        }, failed: { (failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
        }, errorResult: { () -> (Void) in
            print("网络异常")
        })
    }
    
    
    lazy var addView: AddCarVIew = {
       let addView = AddCarVIew()
        addView.backgroundColor = BackViewColor
        return addView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.navigationItem.title = "商品详情"
        
        self.addView.delegate = self
        self.addView.goodsID = self.goodsID
        self.view .addSubview(self.addView)
        
        self.addView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        self.view .addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().offset(0)
            make.bottom.equalTo(self.addView.snp.top).offset(0)
        }
        
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        header = MTRefreshHeaderAnimator.init(frame: CGRect.zero)
        self.tableView.es.addPullToRefresh(animator: header) { [weak self] in
            self?.headerRereshing()
        }
        tableView.expiredTimeInterval = 20.0
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "DetailHeaderCell", bundle: nil), forCellReuseIdentifier: "DetailHeaderCell")
        tableView.register(UINib.init(nibName: "DetailImageCell", bundle: nil), forCellReuseIdentifier: "DetailImageCell")
        tableView.es.removeRefreshFooter()
    }
    
    override func headerRereshing() {
        creatData(goodId: goodsID!)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.tableView.es.stopPullToRefresh()
        }
    }
    
}
    

extension GoodDetailVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return self.strArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell:DetailHeaderCell! = tableView.dequeueReusableCell(withIdentifier: "DetailHeaderCell", for: indexPath) as? DetailHeaderCell
            if self.goodsModel.comPic != nil {
                cell.model = self.goodsModel
            }
            return cell
        default:
            let cell:DetailImageCell! = tableView.dequeueReusableCell(withIdentifier: "DetailImageCell", for: indexPath) as? DetailImageCell
            cell.imageStr = self.strArr[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 570
        default:
            return 370
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            let headerView = UILabel()
            headerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 40)
            headerView.textAlignment = .center
            headerView.backgroundColor = .white
            headerView.textColor = MainColor
            headerView.text = "图片集锦"
            headerView.font = UIFont .systemFont(ofSize: 15)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.0001
        default:
            return 40
        }
    }
    
}

extension GoodDetailVC: AddCarVIewDelegate {
    
    /// 加入购物车
    func addCarMethod(goodCount: Int) {
        
        let item = GoodItem.init()
        item.goodsId = self.goodsID
        item.goodsName = self.goodsModel.goodsName
        item.goodsCount = goodCount
        item.oriPrice = self.goodsModel.oriPrice
        item.presentPrice = self.goodsModel.presentPrice
        item.image1 = self.goodsModel.image1
        item.isSelect = false
        let itemArr = [item]
        let properties = [
            GoodItem.Properties.goodsId,
            GoodItem.Properties.goodsName,
            GoodItem.Properties.goodsCount,
            GoodItem.Properties.oriPrice,
            GoodItem.Properties.presentPrice,
            GoodItem.Properties.isSelect,
            GoodItem.Properties.image1,
        ]
        if goodCount > 1 {
            WCDManager.share.update(fromTable: DBTableName.sampleTable, on: properties, itemModel: item, where: GoodItem.Properties.goodsId == String(self.goodsID!))
        }else{
            WCDManager.share.inser(objects: itemArr, intoTable: DBTableName.sampleTable)
        }
        
    }
    
    /// 立即购买
    func buyGoodsMethod() {
        let view = PromptlyBuyVC()
        view.goodsModel = self.goodsModel
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}
