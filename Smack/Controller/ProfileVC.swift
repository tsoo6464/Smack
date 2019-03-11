//
//  ProfileVC.swift
//  Smack
//
//  Created by Nan on 2019/3/11.
//  Copyright © 2019 nan. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        userImage.image = UIImage(named: UserDataService.instance.avatarName)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        username.text = UserDataService.instance.name
        email.text = UserDataService.instance.email
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(tap)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // Action
    @IBAction func closeModalBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        UserDataService.instance.userLogout()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
}
