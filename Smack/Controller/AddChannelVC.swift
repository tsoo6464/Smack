//
//  AddChannelVC.swift
//  Smack
//
//  Created by Nan on 2019/3/19.
//  Copyright © 2019 nan. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //MARK: - Function
    func setUpView() {
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        descriptionTxt.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(tap)
    }
    
    //MARK: - Objc
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    //MARK: - IBAction
    @IBAction func createChannelBtnPressed(_ sender: Any) {
        guard let name = nameTxt.text, nameTxt.text != "" else { return }
        guard let description = descriptionTxt.text, descriptionTxt.text != "" else { return }
        SocketService.instance.addChannel(channelName: name, channelDescription: description) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func closeModalBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
