//
//  AppDelegate.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/3.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import ESTabBarController_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent

        // Override point for customization after application launch.
        self.window?.frame = UIScreen.main.bounds
        let tab = self.customIrregularityStyle(delegate: self as? UITabBarControllerDelegate)
        self.window?.rootViewController = tab
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        return true
    }

    // 加载底部tabbar样式
     func customIrregularityStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 6 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
    //                let vc = FMPlayController()
    //                tabBarController?.present(vc, animated: true, completion: nil)
            }
        }
        
        let v1 = HomeViewController()
        let v2 = CategoryViewController()
        let v3 = ShopCarViewController()
        let v4 = MeCenterViewController()
        
        v1.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "首页", image: UIImage(named: "shouye"), selectedImage: UIImage(named: "shouye"))
        
        v2.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "分类", image: UIImage(named: "shangpinfenlei"), selectedImage: UIImage(named: "shangpinfenlei"))
        
        v3.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "购物车", image: UIImage(named: "gouwuche"), selectedImage: UIImage(named: "gouwuche"))
        
        v4.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "会员中心", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile"))
        
        let n1 = LTNavViewController.init(rootViewController: v1)
        let n2 = LTNavViewController.init(rootViewController: v2)
        let n3 = LTNavViewController.init(rootViewController: v3)
        let n4 = LTNavViewController.init(rootViewController: v4)
        v1.navigationItem.title = "百姓生活+"
        v2.navigationItem.title = "商品分类"
        v3.navigationItem.title = "购物车"
        v4.navigationItem.title = "会员中心"
        
        tabBarController.viewControllers = [n1, n2, n3, n4]
        return tabBarController
    }
    
    
    
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

