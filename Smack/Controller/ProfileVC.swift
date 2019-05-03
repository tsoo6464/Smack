//
//  ProfileVC.swift
//  Smack
//
//  Created by Nan on 2019/3/11.
//  Copyright © 2019 nan. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    //MARK: - Function
    func setUpView() {
        userImage.image = UIImage(named: UserDataService.instance.avatarName)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        username.text = UserDataService.instance.name
        email.text = UserDataService.instance.email
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileVC.updateUsername(_:)), name: NOTIF_USERNAME_UPDATE, object: nil)
    }
    
    //MARK: - Objc
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func updateUsername(_ notif: Notification) {
        username.text = UserDataService.instance.name
    }
    
    //MARK: - IBAction
    @IBAction func closeModalBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        UserDataService.instance.userLogout()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeUsernameBtnPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Change username", message: "", preferredStyle: .alert)
        
        let cancelAtion = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let action = UIAlertAction(title: "Update", style: .default) { (action) in
            guard let newName = textField.text, textField.text != "" else { return }
            AuthService.instance.updateUserName(name: newName, uid: UserDataService.instance.id, completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USERNAME_UPDATE, object: nil)
                }
            })
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.text = UserDataService.instance.name
            textField = alertTextfield
        }
        
        alert.addAction(action)
        alert.addAction(cancelAtion)
        present(alert, animated: false, completion: nil)
    }
    
}
