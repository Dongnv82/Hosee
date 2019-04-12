//
//  ShowAlert.swift
//  Hosee
//
//  Created by Duc Anh on 4/11/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit


func showAlertToDeleteApp(title:String, message: String) {
    showAlertCompelete(title: title, message: message, settingUrl: "chung toi can vi tri cua ban")
}
func showAlertToOpenSetting( title:String, message: String) {
    showAlertCompelete(title: title, message: message, settingUrl: UIApplication.openSettingsURLString)
    
}

func showAlert(title:String, message: String, completeHandler: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (result : UIAlertAction) -> Void in
        completeHandler?()
    }
    alertController.addAction(okAction)
    if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
        rootVC.present(alertController, animated: true, completion: nil)
    }
}

func showAlertCompelete(title:String, message: String, settingUrl: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let settingAction = UIAlertAction(title: "Setting", style: .cancel) { (_) -> Void in
        guard let settingsUrl = URL(string: settingUrl) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }
    let okAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
    }
    alertController.addAction(okAction)
    alertController.addAction(settingAction)
    if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
        rootVC.present(alertController, animated: true, completion: nil)
    }
}

