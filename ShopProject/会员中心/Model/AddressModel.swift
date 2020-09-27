//
//  AddressModel.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/24.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import WCDBSwift

class AddressModel: NSObject,TableCodable {
    /// 姓名
    var username: String?
    /// 电话
    var telephone: String?
    /// 地址
    var address: String?
    /// 门牌号
    var houseNumber: String?
    /// 自增主键
    var addAddressCount: Int = 0

    enum CodingKeys: String, CodingTableKey {
        typealias Root = AddressModel
        static let objectRelationalMapping = TableBinding(CodingKeys.self)

        case username
        case telephone
        case address
        case houseNumber
        case addAddressCount

        //Column constraints for primary key, unique, not null, default value and so on. It is optional.
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                //自增主键的设置
                .addAddressCount: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true)
            ]
        }
    }

    /// 用于定义是否使用自增的方式插入
    var isAutoIncrement: Bool = true

    /// 用于获取自增插入后的主键值
    var lastInsertedRowID: Int64 = 0

}


