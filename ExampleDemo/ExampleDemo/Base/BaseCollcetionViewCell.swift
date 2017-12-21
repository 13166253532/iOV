//
//  BaseCollcetionViewCell.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/21.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class BaseCollcetionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configurateTheCell(info:BaseCollectionViewCellModel){
        
    }
}
class BaseCollectionViewCellModel: NSObject {
    var className:String!
    
}
