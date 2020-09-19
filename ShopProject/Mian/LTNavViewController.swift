//
//  LTNavViewController.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/3.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class LTNavViewController: UINavigationController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let item = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = item
        
        setNavBarAppearence()
    }
}



func setNavBarAppearence(){
    // 设置导航栏默认的背景颜色
    WRNavigationBar.defaultNavBarBarTintColor = MainColor
    // 设置导航栏所有按钮的默认颜色
    WRNavigationBar.defaultNavBarTintColor = UIColor .white
    
//    self.navigationController.navigationBar.topItem.title = @"";
    
    // 设置导航栏标题默认颜色
    WRNavigationBar.defaultNavBarTitleColor = .white
    // 统一设置状态栏样式
    WRNavigationBar.defaultStatusBarStyle = .lightContent
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    WRNavigationBar.defaultShadowImageHidden = true
}

extension LTNavViewController{
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
