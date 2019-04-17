//
//  ContainerViewController.swift
//  Hosee
//
//  Created by Duc Anh on 3/22/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit


class ContainerViewController: UIViewController, ToggleViewProtocol {
    var effectView: UIVisualEffectView?
    var coverAlpha: CGFloat = 0.5
    @IBOutlet var controlConstraint: NSLayoutConstraint!
    @IBOutlet var corverButton: UIButton!
    @IBOutlet var menu: UIView!
    
    var closeDistance: CGFloat = 0.0
    var showDistance: CGFloat = 0.0
    var isOpen: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        registerNotification()
        setupToggleView(distance: menu.frame.height + 100)

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupToggleView(distance: menu.frame.height + 100)
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(toggle(_:)), name: .toggle, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func toggle(_ sender: UIButton! = nil) {
        isOpen = !isOpen
        performToggle(isOpen: isOpen)
    }
    
}

