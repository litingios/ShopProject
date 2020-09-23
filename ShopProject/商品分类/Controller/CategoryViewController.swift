//
//  CategoryViewController.swift
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

class CategoryViewController: LTSuperViewController {

    private var cateArray:[CategoryModel]?
    private var belowList: [GoodsModel]?
    /// 商品大类id
    private var mallCategoryId: String = "2c9f6c946cd22d7b016cd74220b70040"
    /// 商品小类id
    private var mallSubId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backBntHidden = true

        loadGoodCategory()
        loadGoodInfoList(categoryId: mallCategoryId, categorySubId: mallSubId, page: 1)

        rightView.delegate = self
        self.view .addSubview(leftView)
        self.view .addSubview(rightView)
        leftView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(0)
            make.height.equalTo(ScreenHeigth-tabBarHeight)
            make.width.equalTo(ScreenWidth/4)
        }
        rightView.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().offset(0)
            make.height.equalTo(ScreenHeigth-tabBarHeight)
            make.width.equalTo(ScreenWidth/4*3)
        }
        
        // 回调
        leftView.backMallCategoryId = {[weak self]
            (model: CategoryModel,index: Int)in
            self?.mallCategoryId = model.mallCategoryId!
            self?.mallSubId = ""
            
            // 添加 全部 model
            let mallModel = CategorySmallModel()
            mallModel.mallSubName = "全部"
            mallModel.mallCategoryId = model.mallCategoryId!
            mallModel.mallSubId = ""
            mallModel.isSelect = true
            var smallArray:[CategorySmallModel]? = []
            smallArray = self?.cateArray?[index].bxMallSubDto
            smallArray?.insert(mallModel, at: 0)
            
            self?.rightView.topArray = smallArray
            
            self?.loadGoodInfoList(categoryId: model.mallCategoryId!, categorySubId: "", page: 1)
        }
        
        rightView.backCategorySmallModel = {[weak self]
            (model: CategorySmallModel)in
            self?.isClear = false
            self?.mallCategoryId = model.mallCategoryId!
            self?.mallSubId = model.mallSubId!
            self?.loadGoodInfoList(categoryId: model.mallCategoryId!, categorySubId: model.mallSubId!, page: 1)
        }
        
        rightView.backGoodId = {[weak self]
            (str: String)in
            let goodsVC = GoodDetailVC()
            goodsVC.goodsID = str
            self?.navigationController?.pushViewController(goodsVC, animated: true)
        }
        
    }
    
    private lazy var leftView: LeftView = {
        let leftView = LeftView()
        leftView.backgroundColor = UIColor .white
        return leftView
    }()
    
    private lazy var rightView: RightView = {
        let rightView = RightView()
        rightView.backgroundColor = UIColor .white
        return rightView
    }()

    
    // 列表数据
    private func loadGoodCategory() -> Void {
        
        NetWorkRequest(.goodCategory(parameters: [:]),isCarch: true ,completion: { (responseString) -> (Void) in
            let json = JSON(responseString)
            // 底部列表数据
            if let cateArray = JSONDeserializer<CategoryModel>.deserializeModelArrayFrom(json: json["data"].description) { // 从字符串转换为对象实例
                self.cateArray = cateArray as? [CategoryModel]
                self.leftView.cateArray = self.cateArray
                
                // 添加 全部 model
                let model = CategorySmallModel()
                model.mallSubName = "全部"
                model.mallCategoryId = "2c9f6c946cd22d7b016cd74220b70040"
                model.mallSubId = ""
                model.isSelect = true
                var smallArray:[CategorySmallModel]? = []
                smallArray = self.cateArray?[0].bxMallSubDto
                smallArray?.insert(model, at: 0)
                
                self.rightView.topArray = smallArray
                
            }
            
        }, failed: { (failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
        }, errorResult: { () -> (Void) in
            print("网络异常")
        })
        
    }
    
    
    private func loadGoodInfoList(categoryId: String,categorySubId: String,page: Int) -> Void {
        NetWorkRequest(.categoryGoodsList(parameters: ["categoryId":categoryId,"categorySubId":categorySubId,"page":page]),isCarch: true,carchID: "categoryId-\(categoryId)-categorySubId\(categorySubId)-page\(page)" as NSString, completion: { (responseString) -> (Void) in
            let json = JSON(responseString)
            
            if let cateArray = JSONDeserializer<GoodsModel>.deserializeModelArrayFrom(json: json["data"].description) { // 从字符串转换为对象实例
                
                if self.isClear == true {
                    self.belowList = self.belowList! + cateArray as? [GoodsModel]
                }else{
                    self.belowList?.removeAll()
                    self.belowList = cateArray as? [GoodsModel]
                }
                self.rightView.belowList = self.belowList
            }
            self.rightView.goodsCollectionView.es.stopPullToRefresh()
            self.rightView.goodsCollectionView.es.stopLoadingMore()
            if json["data"].count == 0 {
                self.rightView.goodsCollectionView.es.stopLoadingMore()
                self.rightView.goodsCollectionView.es.noticeNoMoreData()
            }
            
        }, failed: { (failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
        }, errorResult: { () -> (Void) in
            print("网络异常")
        })
    }
    
}

extension CategoryViewController: RightViewDelegate {
    
    func rightViewHeaderRereshing() {
        self.page = 1
        self.isClear = false
        self.loadGoodInfoList(categoryId: self.mallCategoryId, categorySubId: self.mallSubId, page: self.page)
    }
    
    func rightViewFooterRereshing() {
        self.page += 1
        self.isClear = true
        self.loadGoodInfoList(categoryId: self.mallCategoryId, categorySubId: self.mallSubId, page: self.page)
    }
}

