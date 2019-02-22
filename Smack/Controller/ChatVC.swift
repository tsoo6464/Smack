//
//  ChatVC.swift
//  Smack
//
//  Created by Nan on 2019/2/21.
//  Copyright © 2019 nan. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 將按鈕觸發事件連接到SWReveal彈出菜單
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        // 在主視圖上增加滑動手勢可以跑出菜單
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        // 在主視圖上增加點擊手勢可以隱藏菜單
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
    }

}
