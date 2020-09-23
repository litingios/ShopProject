//
//  GoodItem.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/23.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import WCDBSwift

class GoodItem: NSObject,TableCodable {
    /// 商品id
    var goodsId: String?
    /// 初始价格
    var oriPrice: String?
    /// 商品图片
    var image1: String?
    /// 商品名称
    var goodsName: String?
    /// 商品数量
    var goodsCount: Int = 0
    /// 是否选中
    var isSelect: Bool = false
    /// 优化价格
    var presentPrice: String?
    /// 自增
    var addCount: Int = 0

    enum CodingKeys: String, CodingTableKey {
        typealias Root = GoodItem
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case goodsId
        case oriPrice
        case image1
        case goodsName
        case goodsCount
        case isSelect
        case presentPrice
        case addCount
    
        //Column constraints for primary key, unique, not null, default value and so on. It is optional.
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                //自增主键的设置
                .addCount: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true)
            ]
        }
    }
    
    /// 用于定义是否使用自增的方式插入
    var isAutoIncrement: Bool = true
    
    /// 用于获取自增插入后的主键值
    var lastInsertedRowID: Int64 = 0
}
