//
//  RightView.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/10.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class RightView: UIView {

    var backCategorySmallModel: ((CategorySmallModel) ->())?
    var backGoodId: ((String) ->())?

    var topArray: [CategorySmallModel]? = [] {
        didSet{
            guard topArray != nil else {return}
            self.collectionView .reloadData();
        }
    }
    
    var belowList: [GoodsModel]? {
        didSet{
            guard topArray != nil else {return}
            self.goodsCollectionView .reloadData();
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self .addSubview(collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.right.width.equalToSuperview()
            make.top.equalTo(navigationBarHeight)
            make.height.equalTo(40)
        }
        
        self .addSubview(self.lineLable)
        self.lineLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView.snp.bottom).offset(0)
            make.right.width.equalToSuperview()
            make.height.equalTo(0.8)
        }
        
        self .addSubview(goodsCollectionView)
        self.goodsCollectionView.snp.makeConstraints { (make) in
            make.right.width.equalToSuperview()
            make.top.equalTo(self.lineLable.snp.bottom).offset(0)
            make.bottom.equalTo(0)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = BackViewColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "RightTopCell", bundle: nil), forCellWithReuseIdentifier: "RightTopCell")
        return collectionView
    }()
    
    lazy var lineLable: UILabel = {
        let lineLable = UILabel()
        lineLable.backgroundColor = NBackViewColor
        return lineLable
    }()
    
    lazy var goodsCollectionView : UICollectionView = {
        let goodsLayout = UICollectionViewFlowLayout.init()
        goodsLayout.scrollDirection = .vertical
        let goodsCollectionView = UICollectionView.init(frame:.zero, collectionViewLayout: goodsLayout)
        goodsCollectionView.delegate = self
        goodsCollectionView.dataSource = self
        goodsCollectionView.backgroundColor = UIColor .white
        goodsCollectionView.showsVerticalScrollIndicator = false
        goodsCollectionView.showsHorizontalScrollIndicator = false
        goodsCollectionView.register(UINib.init(nibName: "GoodsCell", bundle: nil), forCellWithReuseIdentifier: "GoodsCell")
        return goodsCollectionView
    }()
    
}

extension RightView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return self.topArray?.count ?? 0
            
        }else{
            return self.belowList?.count ?? 0

        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell:RightTopCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "RightTopCell", for: indexPath) as? RightTopCell
            cell.model = self.topArray?[indexPath.row]
            return cell
            
        }else{
            let cell:GoodsCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsCell", for: indexPath) as? GoodsCell
            cell.model = self.belowList?[indexPath.row]
            return cell
            
        }
        
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize.init(width: 70, height:40)
            
        }else{
            return CGSize.init(width: ScreenWidth/4*3/2-2, height:160)

        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {

            backCategorySmallModel?((self.topArray?[indexPath.row])!)
            for model in self.topArray! {
                model.isSelect = false
            }
            
            let selectModel = self.topArray![indexPath.row]
            selectModel.isSelect = true
            self.collectionView .reloadData()
            
        }else{
            backGoodId?((self.belowList?[indexPath.row].goodsId!)!)
            
        }
        
    }
    
}


