//
//  RecomondCell.swift
//  ShopProject
//
//  Created by 李霆 on 2020/9/9.
//  Copyright © 2020 mziyuting. All rights reserved.
//

import UIKit

class RecomondCell: UITableViewCell {
    
    var backGoodId: ((String) ->())?

    @IBOutlet weak var recoLable: UILabel!
    @IBOutlet weak var lineLable: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 推荐数据
    var recommendList: [RecommendModel]? {
        didSet{
            guard recommendList != nil else {return}
            self.collectionView .reloadData()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.recoLable.textColor = MainColor;
        self.lineLable.textColor = BackViewColor
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.showsVerticalScrollIndicator = false;
        self.collectionView.showsHorizontalScrollIndicator = false;
        self.collectionView.register(UINib.init(nibName: "RecomondCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecomondCollectionViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension RecomondCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:RecomondCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "RecomondCollectionViewCell", for: indexPath) as? RecomondCollectionViewCell
        cell.model = self.recommendList![indexPath.row]
        return cell
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 120, height:140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        backGoodId?((self.recommendList?[indexPath.row].goodsId!)!)
    }
    
}
