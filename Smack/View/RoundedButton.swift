//
//  RoundedButton.swift
//  Smack
//
//  Created by Nan on 2019/2/26.
//  Copyright © 2019 nan. All rights reserved.
//

import UIKit

//要讓修改的內容直接顯示在Interface Builder上
//Step 1. 先加上@IBDesignable
@IBDesignable
class RoundedButton: UIButton {
    //加上@IBInspectable 可讓屬性在InterFace Build上被修改
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    //Step 2. override prepareForInterfaceBuilder()
    //這是在界面上 在Interface Build 被呼叫
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    //這是運行中 runtime 時候呼叫 所以兩個都必須呼叫客制UI元件的方法
    override func awakeFromNib() {
        self.setupView()
    }
    //Step 3. 客制UI元件的方法 再讓 prepare 和 awake呼叫即可
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
}
