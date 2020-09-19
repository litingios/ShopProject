//
//  SceneDelegate.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/3.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        let tab = self.customIrregularityStyle(delegate: self as? UITabBarControllerDelegate)
        self.window?.rootViewController = tab
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
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
    

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

