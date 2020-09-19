//
//  LeftView.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/10.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class LeftView: UIView {
    
    var backMallCategoryId: ((CategoryModel,Int) ->())?

    var cateArray:[CategoryModel]? {
        didSet{
            guard cateArray != nil else {return}
            self.tableView .reloadData()
        }
    }

    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:.zero, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor .white
        tableView.register(UINib.init(nibName: "LeftCell", bundle: nil), forCellReuseIdentifier: "LeftCell")
        return tableView
    }()
    
    lazy var lineLab : UILabel = {
        let lineLab = UILabel()
        lineLab.backgroundColor = NBackViewColor
        return lineLab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tableView.tableFooterView = UIView()
        self .addSubview(self.tableView)
        self .addSubview(self.lineLab)

        self.tableView.snp.makeConstraints { (make) in
            make.top.left.height.equalToSuperview()
            make.width.equalTo(ScreenWidth/4-1)
        }
        self.lineLab.snp.makeConstraints { (make) in
            make.top.height.equalToSuperview()
            make.width.equalTo(0.8)
            make.left.equalTo(self.tableView.snp.right).offset(0)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LeftView:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cateArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LeftCell! = tableView.dequeueReusableCell(withIdentifier: "LeftCell", for: indexPath) as? LeftCell
        cell.model = self.cateArray![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        backMallCategoryId?(self.cateArray![indexPath.row],indexPath.row)
        
    }
    
}
