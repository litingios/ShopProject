//
//  LTSuperViewController.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/3.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import ESPullToRefresh
import DZNEmptyDataSet

class LTSuperViewController: UIViewController {
    
    /// 全局 layout
    var layout = UICollectionViewFlowLayout()
    /// page
    var page: Int = 1
    /// 返回按钮是否隐藏 true隐藏
    var backBntHidden: Bool = false
    /// 是否清空数组
    var isClear: Bool = false
    /// 站位图片
    var noImageName: String = ""
    /// 站位标题
    var noTitle: String = ""
    /// 站位描述
    var noDes: String = ""
    /// 设置站位图
    func setNoDataViewElement(name: String = "icon_pull_animation_4",title: String = "提示",des: String = "您还没有添加购物车") -> Void {
        self.noImageName = name
        self.noTitle = title
        self.noDes = des
    }

    //修改 下拉 上拉刷新 文字提示
    var header: ESRefreshHeaderAnimator {
        get {
            let h = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
            h.pullToRefreshDescription = "下拉刷新"
            h.releaseToRefreshDescription = "松开获取最新数据"
            h.loadingDescription = "下拉刷新..."
            return h
        }
    }
    
    var footer: ESRefreshFooterAnimator {
        get {
            let f = ESRefreshFooterAnimator.init(frame: CGRect.zero)
            f.loadingMoreDescription = "上拉加载更多"
            f.noMoreDataDescription = "数据已加载完"
            f.loadingDescription = "加载更多..."
            return f
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BackViewColor
    }
            
    
    func headerRereshing() -> Void {
        
    }
    func footerRereshing() -> Void {
        
    }
    
    /// 状态栏样式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// 状态栏是否隐藏
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    /// 状态栏的隐藏与显示动画样式
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    lazy var collectionView : UICollectionView = {
        layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        if #available(iOS 11.0,*){
            collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 49, right: 0)
            collectionView.scrollIndicatorInsets = collectionView.contentInset
        }
       
        collectionView.backgroundColor = UIColor .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        // 下拉刷新
        collectionView.es.addPullToRefresh(animator: header, handler: {
            [unowned self] in

            self.headerRereshing()
//            self.page = 1
//            self.isClear = false
//            self.loadSlidesListData()
//            self.loadBelowListData()
//            / 在这里做刷新相关事件
//            / ...
//            / 如果你的刷新事件成功，设置completion自动重置footer的状态
//            self.collectionView.es.stopPullToRefresh()
//            / 设置ignoreFooter来处理不需要显示footer的情况
//            self.collectionView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: true)
        });
        
        // 上拉加载
        collectionView.es.addInfiniteScrolling(animator: footer) {
            [unowned self] in
            self.footerRereshing()
//            self.page += 1
//            self.isClear = true
//            self.loadBelowListData()

//            /// 在这里做加载更多相关事件
//            /// ...
//            /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
//            self.collectionView.es.stopLoadingMore()
//            /// 通过es_noticeNoMoreData()设置footer暂无数据状态
//            self.collectionView.es.noticeNoMoreData()
        }
        return collectionView
    }()
    
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:.zero, style: UITableView.Style.plain)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.backgroundColor = UIColor .white
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        if #available(iOS 11.0,*){
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 49, right: 0)
            tableView.scrollIndicatorInsets = tableView.contentInset
        }
        // 下拉刷新
        tableView.es.addPullToRefresh(animator: header, handler: {
            [unowned self] in
            self.headerRereshing()
        });
        // 上拉加载
        tableView.es.addInfiniteScrolling(animator: footer) {
            [unowned self] in
            self.footerRereshing()
        }
        return tableView
    }()
    
    private lazy var leftBtn: UIButton = {
        let leftBtn = UIButton()
        leftBtn .addTarget(self, action: #selector(backBtnCiled), for: UIControl.Event.touchUpInside)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 45, height: 30)
        leftBtn .contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 45, right: 30)
        leftBtn.backgroundColor = UIColor .yellow
        return leftBtn
    }()
    
    @objc func backBtnCiled() -> Void{
        
    }

}


extension LTSuperViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    
    /// 返回图片
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: noImageName)
    }

    /// 返回标题文字
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let nameStr : NSMutableAttributedString = NSMutableAttributedString(string:noTitle as String, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16.0),NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return nameStr
    }
    
    /// 返回文字详情
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        let nameStr: NSAttributedString = NSAttributedString(string: noDes, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0),NSAttributedString.Key.foregroundColor: UIColor.lightGray,NSAttributedString.Key.paragraphStyle:paragraph])
        return nameStr
    }
    
}



