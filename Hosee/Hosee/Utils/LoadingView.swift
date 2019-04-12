//
//  Indicator.swift
//  Hosee
//
//  Created by Duc Anh on 4/12/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    private static let shared : LoadingView = LoadingView()
    var button = Button()
    var indicator = UIActivityIndicatorView(style: .whiteLarge)
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.addSubview(button)
        self.addSubview(indicator)
        button.fill()
        indicator.startAnimating()
        indicator.alignCenter()
    }
    
    static func start() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        LoadingView.shared.alpha = 0.0
        AppDelegate.shared.window?.addSubview(LoadingView.shared)
        LoadingView.shared.fill()
        UIView.animate(withDuration: 0.1) {
            LoadingView.shared.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            LoadingView.stop()
        }
    }
    
    static func stop() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        UIView.animate(withDuration: 0.1 ,  animations: {
            LoadingView.shared.alpha = 0
        } , completion: { (_) in
            LoadingView.shared.removeFromSuperview()
        })
    }
}




