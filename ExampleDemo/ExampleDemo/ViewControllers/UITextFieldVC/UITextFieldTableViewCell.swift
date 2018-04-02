//
//  UITextFieldTableViewCell.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/4/2.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit

class UITextFieldTableViewCell: BaseTableViewCell {

    var nameLabel: UILabel!
    
    var textView: UITextField!
    var inforModel = UITextFieldTableViewCellModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func initLabel() {
        nameLabel = UILabel.init(frame: CGRect(x:20, y: 0, width:50 , height:44 ))
        nameLabel.textColor = UIColor.black
        self.addSubview(nameLabel)
    }
    func inittextView() {
        textView = UITextField.init(frame: CGRect(x:SCREEN_WHIDTH()/2, y: 5, width:SCREEN_WHIDTH()/2 , height:30 ))
        textView.backgroundColor = UIColorFromRGB(rgbValue: 0xFFB6FF)
        self.addSubview(textView)
    }
    override func configurateTheCell(_ xinfo: BaseCellModel) {
        inforModel = xinfo as! UITextFieldTableViewCellModel
        if nameLabel == nil {
           initLabel()
            inittextView()
        }
        self.nameLabel.text = inforModel.titleValue
        if self.inforModel.textViewText != nil {
           self.textView.text = self.inforModel.textViewText
            print("====",self.inforModel.textViewText ?? String())
        }
        print("inforModel.titleValue=="+inforModel.titleValue!+self.textView.text!)
        self.textView.addTarget(self, action: #selector(gettextView), for: .editingChanged)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func gettextView(){
        self.inforModel.block(self.textView.text as AnyObject)
    }
}
class UITextFieldTableViewCellModel: BaseCellModel {
    var titleValue:String?
    var block:passParameterBlock!
    var isShowSelec = true
    var textViewText:String?
    
}
