//
//  ShopCarViewController.swift
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

class ShopCarViewController: LTSuperViewController {

    private var belowList: [GoodsModel]? //底部列表数据

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backBntHidden = true


        self.view .addSubview(self.collectionView);
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: 20)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.left.height.width.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor .white
        self.collectionView.register(UINib.init(nibName: "GoodsCell", bundle: nil), forCellWithReuseIdentifier: "GoodsCell")
        // 移除上拉下拉
//        self.collectionView.es.removeRefreshFooter()
//        self.collectionView.es.removeRefreshHeader()
        loadBelowListData()
    }
    

    // 列表数据
    private func loadBelowListData() -> Void {
        // 首页列表数据
        NetWorkRequest(.homePageBelowConten(parameters: ["page":0]), completion: { (responseString) -> (Void) in
            // 轮播图数据
            let json = JSON(responseString)
            if json["data"].count == 0 {
                self.collectionView.es.stopLoadingMore()
                /// 通过es_noticeNoMoreData()设置footer暂无数据状态
                self.collectionView.es.noticeNoMoreData()
            }
            
            // 底部列表数据
            if let belowList = JSONDeserializer<GoodsModel>.deserializeModelArrayFrom(json: json["data"].description) { // 从字符串转换为对象实例
                self.belowList = belowList as? [GoodsModel]
                self.collectionView .reloadData()
                self.collectionView.es.stopPullToRefresh()
                self.collectionView.es.stopLoadingMore()

            }
        }, failed: { (failedResutl) -> (Void) in
            print("服务器返回code不为0000啦~\(failedResutl)")
        }, errorResult: { () -> (Void) in
            print("网络异常")
        })
    }
    
    override func headerRereshing() -> Void {
        
        
        
    }
    
    override func footerRereshing() -> Void {
        
        
        
    }
    

}


extension ShopCarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let goodsVC = GoodDetailVC()
        goodsVC.goodsID = self.belowList![indexPath.row].goodsId
        navigationController?.pushViewController(goodsVC, animated: true)
        
    }
        
}
