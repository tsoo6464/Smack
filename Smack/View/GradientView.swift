//
//  GradientView.swift
//  Smack
//
//  Created by Nan on 2019/2/21.
//  Copyright © 2019 nan. All rights reserved.
//

import UIKit
// 可以讓這些設定在storyboard上修改
@IBDesignable
class GradientView: UIView {
    // @IBInspectable開頭的變量可以在storyboard裡直接修改數值
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet {
            // 有給值的話更新layout
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            // 有給值的話更新layout
            self.setNeedsLayout()
        }
    }
    // 更新會執行的function
    override func layoutSubviews() {
        // 在背景上繪製顏色漸變的圖層
        let gradientLayer = CAGradientLayer()
        // 設定顏色
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        // 設定從哪裡到哪裡 左上原始點是0,0 右下角是1,1
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
