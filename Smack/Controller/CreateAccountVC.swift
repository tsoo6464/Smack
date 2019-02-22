//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Nan on 2019/2/23.
//  Copyright © 2019 nan. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // IBAction
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
}
