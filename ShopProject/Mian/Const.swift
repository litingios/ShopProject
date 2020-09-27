//
//  Const.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/3.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON
import SwiftMessages
import Alamofire

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeigth = UIScreen.main.bounds.size.height
let DominantColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let FooterViewColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)
let MainColor = UIColor.init(red: 225/255.0, green: 20/255.0, blue: 126/255.0, alpha:1.0)
let TextColor = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha:1.0)
let BackViewColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha:1.0)
let NBackViewColor = UIColor.init(red: 211/255.0, green: 211/255.0, blue: 211/255.0, alpha:1.0)
let GreenColor = UIColor.init(red: 143/255.0, green: 199/255.0, blue: 98/255.0, alpha:1.0)
let QianGreenColor = UIColor.init(red: 242/255.0, green: 250/255.0, blue: 237/255.0, alpha:1.0)
let RedColor = UIColor.init(red: 219/255.0, green: 55/255.0, blue: 17/255.0, alpha:1.0)
let YellowColor = UIColor.init(red: 226/255.0, green: 117/255.0, blue: 52/255.0, alpha:1.0)

// iphone X
let isIphoneX = ScreenHeigth == 812 ? true : false
// navigationBarHeight
let navigationBarHeight : CGFloat = isIphoneX ? 88 : 64
// tabBarHeight
let tabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49
