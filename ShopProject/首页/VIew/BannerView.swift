//
//  BannerView.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/9.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import SwiftMessages
import FSPagerView

class BannerView: UIView {
    
    var backGoodId: ((String) ->())?

    var slidesList: [SlidesModel]?{
        didSet{
            guard slidesList != nil else {return}
            self.pagerView.reloadData()
        }
    }

    // 懒加载滚动图片浏览器
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = !pagerView.isInfinite
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "ShopBannerCell")
        return pagerView
    }()
    
    // 懒加载滚动图片浏下标
    lazy var pagerControl:FSPageControl = {
        let pageControl = FSPageControl()
        //设置下标的个数
//        pageControl.numberOfPages = 5
        //设置下标位置
        pageControl.contentHorizontalAlignment = .center
        //设置下标指示器边框颜色（选中状态和普通状态）
        pageControl.setStrokeColor(.lightGray, for: .normal)
        pageControl.setStrokeColor(.darkGray, for: .selected)
        //设置下标指示器颜色（选中状态和普通状态）
        pageControl.setFillColor(.lightGray, for: .normal)
        pageControl.setFillColor(.darkGray, for: .selected)
        
        //设置下标指示器图片（选中状态和普通状态）
        //pageControl.setImage(UIImage.init(named: "1"), for: .normal)
        //pageControl.setImage(UIImage.init(named: "2"), for: .selected)
        
        //绘制下标指示器的形状 (roundedRect绘制绘制圆角或者圆形)
//        pageControl.setPath(UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 8, width: 8, height: 5),cornerRadius: 4.0), for: .normal)
        
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 6, height: 6)), for: .normal)
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 6, height: 6)), for: .selected)
        return pageControl

    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.pagerView)
        self.addSubview(self.pagerControl)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        self.pagerControl.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.bottom.equalTo(pagerView.snp.bottom).offset(0)
            make.centerX.equalTo(self.pagerView)
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension BannerView: FSPagerViewDelegate, FSPagerViewDataSource {
    // - FSPagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        self.pagerControl.numberOfPages = self.slidesList?.count ?? 0
        return self.slidesList?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "ShopBannerCell", at: index)
        cell.imageView?.kf.setImage(with: URL(string:(self.slidesList?[index].image)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        self.pagerControl.currentPage = index

    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        backGoodId?((self.slidesList?[index].goodsId!)!)
        
    }
}

