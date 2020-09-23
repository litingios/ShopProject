//
//  HomeViewController.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/3.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON
import SwiftMessages
import ESPullToRefresh

class HomeViewController: LTSuperViewController {
    
    private var slidesList: [SlidesModel]? // 穿插的广告数据
    private var categoryList: [CategoryModel]? // category数据
    private var advertesPictureModel = AdvertesPictureModel() //客服数据
    private var shopInfoModle = ShopInfoModel() // 周年庆图片model
    private var zhouActivityList: [AdvertesPictureModel]? // 周年庆活动
    private var recommendList: [RecommendModel]? // 推荐商品
    private var fenModelList : [AdvertesPictureModel] = [] // 三个分组的数据
    private var fenModle = AdvertesPictureModel() // 周年庆图片model
    private var belowList: [GoodsModel]? //底部列表数据
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backBntHidden = true
        
        loadSlidesListData()
        loadBelowListData()
        creatUI()
    }
    

    private func creatUI(){
        
        self.view .addSubview(self.collectionView)
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: 1935)
        self.collectionView.register(UINib.init(nibName: "GoodsCell", bundle: nil), forCellWithReuseIdentifier: "GoodsCell")
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "kHeaderViewID")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
        
    }
    
    
    override func headerRereshing() {
        self.page = 1
        self.isClear = false
        self.loadSlidesListData()
        self.loadBelowListData()
    }
    
    override func footerRereshing() {
        self.page += 1
        self.isClear = true
        self.loadBelowListData()
    }
        
    private func loadSlidesListData() {
        // 首页列表数据
        NetWorkRequest(.homeGoodsList(parameters: ["lon":"116.47118377685547","lat":"39.91233444213867"]),isCarch: true, completion: { (responseString) -> (Void) in
            // 轮播图数据
            let json = JSON(responseString)

                 // 轮播图数据
           if let slidesList = JSONDeserializer<SlidesModel>.deserializeModelArrayFrom(json: json["data"]["slides"].description) { // 从字符串转换为对象实例
               self.slidesList = slidesList as? [SlidesModel]
           }

           // 分类数据
           if let categoryList = JSONDeserializer<CategoryModel>.deserializeModelArrayFrom(json: json["data"]["category"].description) { // 从字符串转换为对象实例
               self.categoryList = categoryList as? [CategoryModel]

           }

           // 客服数据
           if let advertesPictureModel = JSONDeserializer<AdvertesPictureModel>.deserializeFrom(json: json["data"]["advertesPicture"].description){
               self.advertesPictureModel = advertesPictureModel

           }

           // 周年庆model
           if let shopInfoModel = JSONDeserializer<ShopInfoModel>.deserializeFrom(json: json["data"]["shopInfo"].description){
               self.shopInfoModle = shopInfoModel

           }

           // 周年庆活动数据
           var zhouList : [JSON] = []
           zhouList .append(json["data"]["saoma"])
           zhouList .append(json["data"]["integralMallPic"])
           zhouList .append(json["data"]["newUser"])
           if let zhouModelList = JSONDeserializer<AdvertesPictureModel>.deserializeModelArrayFrom(json: zhouList.description){
               self.zhouActivityList = zhouModelList as? [AdvertesPictureModel]

           }

           // 推荐数据
           if let recommendList = JSONDeserializer<RecommendModel>.deserializeModelArrayFrom(json: json["data"]["recommend"].description){
               self.recommendList = recommendList as? [RecommendModel]

           }

            self.fenModelList .removeAll()
           // 分组数据
           for i in 1...3 {
               let str01: String = "floor\(i)Pic"
               let str02: String = "floor\(i)"

               var dict = json["data"][str01]
               dict["goods_array"] = json["data"][str02]

               if let fenModel = JSONDeserializer<AdvertesPictureModel>.deserializeFrom(json: dict.description){
                   self.fenModle = fenModel
                   self.fenModelList .append(self.fenModle)
               }
           }
    
            UIView .performWithoutAnimation {
                self.collectionView .reloadData()
            }
            self.collectionView.es.stopPullToRefresh()
            self.collectionView.es.stopLoadingMore()

        }, failed: { (failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
        }, errorResult: { () -> (Void) in
            print("网络异常")
        })

    }

    // 列表数据
    private func loadBelowListData() -> Void {
        // 首页列表数据
        NetWorkRequest(.homePageBelowConten(parameters: ["page":self.page]),isCarch: true,carchID: "page-\(page)" as NSString, completion: { (responseString) -> (Void) in
            // 轮播图数据
            let json = JSON(responseString)
            if json["data"].count == 0 {
                self.collectionView.es.stopLoadingMore()
                /// 通过es_noticeNoMoreData()设置footer暂无数据状态
                self.collectionView.es.noticeNoMoreData()
            }
            
            // 底部列表数据
            if let belowList = JSONDeserializer<GoodsModel>.deserializeModelArrayFrom(json: json["data"].description) { // 从字符串转换为对象实例
                if self.isClear == true {
                    self.belowList = self.belowList! + belowList as? [GoodsModel]
                }else{
                    self.belowList = belowList as? [GoodsModel]
                }
                UIView .performWithoutAnimation {
                    self.collectionView .reloadData()
                }
                self.collectionView.es.stopPullToRefresh()
                self.collectionView.es.stopLoadingMore()

            }
        }, failed: { (failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
        }, errorResult: { () -> (Void) in
            print("网络异常")
        })
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.belowList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GoodsCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsCell", for: indexPath) as? GoodsCell
        cell.model = self.belowList![indexPath.row]
        return cell
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: ScreenWidth/2-5, height:200)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "kHeaderViewID", for: indexPath) as UICollectionReusableView
        let headerImg = HomeHeaderView()
        
        headerImg.homeGoodId = {[weak self]
            (str: String)in
            let goodsVC = GoodDetailVC()
            goodsVC.goodsID = str
            self?.navigationController?.pushViewController(goodsVC, animated: true)
        }
        
        headerImg.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 1935)
        
        headerImg .creatAllData(slidesList: self.slidesList, categoryList: self.categoryList, advertesPictureModel: self.advertesPictureModel, shopInfoModle: self.shopInfoModle, zhouActivityList: self.zhouActivityList, recommendList: self.recommendList, fenModelList: self.fenModelList, fenModle: self.fenModle)
        
        headerImg.backgroundColor = UIColor .white
        headerView.addSubview(headerImg)
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let goodsVC = GoodDetailVC()
        goodsVC.goodsID = self.belowList![indexPath.row].goodsId
        navigationController?.pushViewController(goodsVC, animated: true)
        
    }
        
}


