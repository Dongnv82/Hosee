//
//  ContainerViewController.swift
//  Hosee
//
//  Created by Duc Anh on 3/22/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let toggle                 = Notification.Name("toggle")
}


class ContainerViewController: UIViewController, HomeViewControllerDelegate {
   
    

    @IBOutlet weak var corverButton: UIButton!
    @IBOutlet weak var leftSlideMenu: UIView!
    @IBOutlet weak var leftContraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotification()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isLeftSlideMenuOpen = false
    }

    var isLeftSlideMenuOpen: Bool = false {
        didSet {
            if isLeftSlideMenuOpen {
              leftContraint.constant = 0
            corverButton.alpha = 0.4
            } else {
                leftContraint.constant = -(leftSlideMenu.bounds.size.width + 15)
                corverButton.alpha = 0
            }
            UIView.animate(withDuration: 0.35) {
                self.view.layoutIfNeeded()
            }
        }
        
    }
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(toggle(_:)), name: .toggle, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
 
    @IBAction func toggle(_ sender: UIButton? = nil) {
        isLeftSlideMenuOpen = !isLeftSlideMenuOpen
    }
    
}
