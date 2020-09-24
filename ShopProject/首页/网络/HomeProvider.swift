//
//  HomeProvider.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/4.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

// 首页接口
let HomeProvider = MoyaProvider<HomeGoodsAPI>()


enum HomeGoodsAPI {
    case homeGoodsList // 首页上面列表
    case homePageBelowConten // 首页下面列表
    case goodDetail(goodId: String) // 商品详情
    case goodCategory //商品类别信息
    case categoryGoodsList(categoryId: String,CategorySubId: String,page: Int) //商品列表

}

// 遵循 TargetType 代理 实现方法
extension HomeGoodsAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
         return URL(string: "https://wxmini.baixingliangfan.cn/baixing/")!
    }

    var path: String {
        switch self {
            case .homeGoodsList: return "wxmini/homePageContent"
            case .homePageBelowConten: return "wxmini/homePageBelowConten"
            case .goodDetail: return "wxmini/getGoodDetailById"
            case .goodCategory: return "wxmini/getCategory"
            case .categoryGoodsList: return "wxmini/getMallGoods"

        }
    }

    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .homeGoodsList:
            parmeters = ["lon":"116.47118377685547","lat":"39.91233444213867"]
        case .homePageBelowConten:
            parmeters = ["page":"1"]
        case .goodDetail(let goodId):
            parmeters = ["goodId":goodId]
        case .goodCategory:
            parmeters = ["":""]
        case .categoryGoodsList(let categoryId,let CategorySubId,let page):
            parmeters = ["categoryId":categoryId,"categorySubId":CategorySubId,"page":page]
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data {
        
        return "".data(using: String.Encoding.utf8)!
        
    }
    var headers: [String : String]? { return nil }

}
