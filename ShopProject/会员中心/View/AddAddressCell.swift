//
//  AddAddressCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/25.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class AddAddressCell: UITableViewCell {

    var model:AddressModel? {
        didSet{
            guard let model = model else {return }
            
            self.leftView.text = (model.username! as NSString).substring(to: 1)
            self.nameLab.text = model.username
            self.phomeLab.text = model.telephone
            self.addressLab.text = (model.address!) + (model.houseNumber!)
        }
    }
    
    
    lazy var leftView: UILabel = {
        let leftView = UILabel()
        leftView.textColor = UIColor.white
        leftView.clipsToBounds = true
        leftView.layer.borderWidth = 1
        leftView.font = UIFont.systemFont(ofSize: 15)
        leftView.layer.borderColor = UIColor.lightGray.cgColor
        leftView.layer.cornerRadius = 15
        leftView.layer.masksToBounds = true
        leftView.text = "李"
        leftView.textAlignment = .center
        leftView.backgroundColor = UIColor.lightGray
        return leftView
    }()
    
    lazy var nameLab: UILabel = {
        let nameLab = UILabel()
        nameLab.font = UIFont.systemFont(ofSize: 15)
        nameLab.text = "李霆"
        return nameLab
    }()
    
    lazy var phomeLab: UILabel = {
        let phomeLab = UILabel()
        phomeLab.font = UIFont.systemFont(ofSize: 12)
        phomeLab.textColor = UIColor.lightGray
        phomeLab.text = "13161138626"
        return phomeLab
    }()
    
    lazy var addressLab: UILabel = {
        let addressLab = UILabel()
        addressLab.font = UIFont.systemFont(ofSize: 13)
        addressLab.text = "北京 北京市大兴区 兴丰街道富强东里小区 2号楼 102"
        addressLab.numberOfLines = 0
        return addressLab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none

        self .addSubview(self.leftView)
        self .addSubview(nameLab)
        self .addSubview(phomeLab)
        self .addSubview(addressLab)
        
        self.leftView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(20)
            make.width.height.equalTo(30)
        }
        self.nameLab.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(self.leftView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        self.phomeLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLab.snp.right).offset(5)
            make.top.equalTo(12)
            make.height.equalTo(15)
            make.width.equalTo(100)
        }
        self.addressLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftView.snp.right).offset(10)
            make.top.equalTo(self.nameLab.snp.bottom).offset(5)
            make.width.equalTo(ScreenWidth-80)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
