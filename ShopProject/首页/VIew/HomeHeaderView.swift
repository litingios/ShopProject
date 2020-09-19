//
//  HomeHeaderView.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/8.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {
    
    var homeGoodId: ((String) ->())?

    func creatAllData( slidesList: [SlidesModel]?,
                       categoryList: [CategoryModel]?,
                       advertesPictureModel: AdvertesPictureModel,
                       shopInfoModle: ShopInfoModel,
                       zhouActivityList: [AdvertesPictureModel]?,
                       recommendList: [RecommendModel]?,
                       fenModelList : [AdvertesPictureModel]?,
                       fenModle: AdvertesPictureModel) -> Void {
        
        self.slidesList = slidesList
        self.fenModelList = fenModelList
        self.recommendList = recommendList
        self.categoryList = categoryList
        self.advertesPictureModel = advertesPictureModel
        self.shopInfoModle = shopInfoModle
        self.zhouActivityList = zhouActivityList
        
        self.bannerView.slidesList = self.slidesList
        self.tableView .reloadData()

    }
    
    
    // 穿插的广告数据
    var slidesList: [SlidesModel]?
    // category数据
    var categoryList: [CategoryModel]?
    // 客服数据
    var advertesPictureModel = AdvertesPictureModel()
    // 周年庆图片model
    var shopInfoModle = ShopInfoModel()
    // 周年庆活动
    var zhouActivityList: [AdvertesPictureModel]?
    // 推荐数据
    var recommendList: [RecommendModel]?
    // 三个分组的数据
    var fenModelList : [AdvertesPictureModel]?

    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:.zero, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor .white
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UINib.init(nibName: "BigClassCell", bundle: nil), forCellReuseIdentifier: "BigClassCell")
        tableView.register(UINib.init(nibName: "RecomondCell", bundle: nil), forCellReuseIdentifier: "RecomondCell")
        tableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: "ActivityTableViewCell")
        tableView.register(UINib.init(nibName: "CateTableViewCell", bundle: nil), forCellReuseIdentifier: "CateTableViewCell")

        
        return tableView
    }()
    
    private lazy var bannerView: BannerView = {
        let bannerView = BannerView()
        bannerView.backgroundColor = UIColor .white
        bannerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 160)
        return bannerView
    }()
    
    private lazy var footView: UIView = {
        let footView = UIView()
        footView.backgroundColor = BackViewColor
        footView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 30)
        return footView
    }()
    
    private lazy var fireView: UILabel = {
        let fireView = UILabel()
        fireView.backgroundColor = MainColor
        fireView.text = "火"
        fireView.textAlignment = NSTextAlignment.center
        fireView.textColor = UIColor .white
        fireView.font = UIFont .systemFont(ofSize: 12)
        fireView.layer.borderWidth = 2.0
        fireView.layer.borderColor = MainColor.cgColor
        fireView.layer.cornerRadius = 10
        fireView.layer.masksToBounds = true
        fireView.frame = CGRect(x: ScreenWidth/2-30, y: 5, width: 20, height: 20)
        return fireView
    }()
    
    private lazy var quLable: UILabel = {
        let quLable = UILabel()
        quLable.frame = CGRect(x: ScreenWidth/2, y: 5, width: 100, height: 20)
        quLable.text = "火爆专区"
        quLable.textAlignment = NSTextAlignment.left
        quLable.textColor = UIColor .black
        quLable.font = UIFont .systemFont(ofSize: 12)
        return quLable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tableView)
        self.footView .addSubview(self.fireView)
        self.footView .addSubview(self.quLable)
        
        self.tableView.tableHeaderView = self.bannerView
        self.tableView.tableFooterView = self.footView
        
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.height.equalTo(1935)
        }
        
        self.bannerView.backGoodId = {
            (str: String)in
            self.homeGoodId!(str)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension HomeHeaderView:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return fenModelList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell:CateTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CateTableViewCell", for: indexPath) as? CateTableViewCell
            cell.categoryList  = self.categoryList
            cell.backgroundColor = BackViewColor
            return cell
            
        case 1:
            let cell:ActivityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCell", for: indexPath) as! ActivityTableViewCell
            cell .creatData(advertesPictureModel: self.advertesPictureModel, shopInfoModle: self.shopInfoModle, zhouActivityList: self.zhouActivityList)
            cell.backgroundColor = BackViewColor
            return cell
            
        case 2:
            let cell:RecomondCell! = tableView.dequeueReusableCell(withIdentifier: "RecomondCell", for: indexPath) as? RecomondCell
            cell.recommendList  = self.recommendList
            cell.backGoodId = {[weak self]
                (str: String)in
                self?.homeGoodId!(str)
            }
            return cell
            
        default:
            let cell:BigClassCell! = tableView.dequeueReusableCell(withIdentifier: "BigClassCell", for: indexPath) as? BigClassCell
            cell.model  = self.fenModelList![indexPath.row]
            cell.backGoodId = {[weak self]
                (str: String)in
                self?.homeGoodId!(str)
            }
            cell.backgroundColor = BackViewColor
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120
        case 1:
            return 315
        case 2:
            return 200
        default:
            return 370
        }
    }
    
    
}
