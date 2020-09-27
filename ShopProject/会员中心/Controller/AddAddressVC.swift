//
//  AddAddressVC.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/24.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddAddressVC: LTSuperViewController {

    lazy var saveBtn: UIButton = {
        let saveBtn = UIButton.init(type: .custom)
        saveBtn .setTitle("保存地址", for: .normal)
        saveBtn.backgroundColor = MainColor
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        saveBtn .addTarget(self, action: #selector(saveBtnCiled), for: .touchUpInside)
        return saveBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "地址管理"
        
        
        let titleArray: Array = ["  姓名：","  电话：","  地址：","  门牌号："]
        let placeholderArray: Array = ["请输入姓名","请输入电话","请输入地址","请输入门牌号"]
        
        for i in 0 ..< titleArray.count {
            let textFiled = UITextField()
            textFiled.placeholder = String(placeholderArray[i])
            textFiled.backgroundColor = UIColor.white
            textFiled.frame = CGRect(x: 0, y: 60+61*i, width: Int(ScreenWidth), height: 60)
            if i == 1 {
                textFiled.keyboardType = .numberPad
            }
            textFiled.tag = 100+i
            
            let leftLab = UILabel()
            leftLab.frame = CGRect(x: 0, y: 0, width: i == 3 ? 80 : 70, height: 65)
            leftLab.textColor = UIColor .black
            leftLab.text = String(titleArray[i])
            leftLab.textAlignment = .center
            textFiled.leftView = leftLab
            textFiled.leftViewMode = .always
            self.view .addSubview(textFiled)
        }
        
        self.view .addSubview(self.saveBtn)
        self.saveBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true)
    }
    
    @objc func saveBtnCiled() -> Void{
        SVProgressHUD .setMaximumDismissTimeInterval(0.4)
        SVProgressHUD .setBackgroundColor(UIColor.lightGray)
        
        let textFiled01 = self.view.viewWithTag(100) as! UITextField
        let textFiled02 = self.view.viewWithTag(101) as! UITextField
        let textFiled03 = self.view.viewWithTag(102) as! UITextField
        let textFiled04 = self.view.viewWithTag(103) as! UITextField
        if textFiled01.text == "" {
            SVProgressHUD .showError(withStatus: "请输入姓名")
            return
        }
        if textFiled02.text == "" {
            SVProgressHUD .showError(withStatus: "请输入电话号码")
            return
        }
        if textFiled03.text == "" {
            SVProgressHUD .showError(withStatus: "请输入地址")
            return
        }
        if textFiled04.text == "" {
            SVProgressHUD .showError(withStatus: "请输入门牌号")
            return
        }
        
        /// 将数据插入表中
        let addressItem = AddressModel.init()
        addressItem.username = textFiled01.text
        addressItem.telephone = textFiled02.text
        addressItem.address = textFiled03.text
        addressItem.houseNumber = textFiled04.text
        let addressArr = [addressItem]
        WCDManager.share.inser(objects: addressArr, intoTable: DBTableName.addressTable)
        self.navigationController?.popViewController(animated: true)
    }

}
