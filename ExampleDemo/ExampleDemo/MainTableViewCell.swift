//
//  MainTableViewCell.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2017/12/1.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class MainTableViewCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var infoModel = MainTableViewCellModel()
    var block:passParameterBlock!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //设置分割线长短
        // self.separatorInset=UIEdgeInsetsMake(0, SCREEN_WHIDTH(), 0, 0)
    }
    override func configurateTheCell(_ xinfo: BaseCellModel) {
        self.infoModel = xinfo as! MainTableViewCellModel
        self.titleLabel.text = self.infoModel.titleValue
        self.titleLabel.textColor = grayColor
        self.block = self.infoModel.block
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            self.block(self.infoModel.titleValue as AnyObject)
        }
    }
}
class MainTableViewCellModel: BaseCellModel {
    var titleValue:String?
    var block:passParameterBlock!
    var isShowSelec = true
    
}
