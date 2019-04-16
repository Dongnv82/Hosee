//
//  WorkingSelectionView.swift
//  Hosee
//
//  Created by Vu on 4/11/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit


class WorkingSelectionView:  View, ToggleViewProtocol {
    var isOpen: Bool = false {
        didSet {
            
        }
    }
    
    @IBOutlet weak var controlConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var corverButton: UIButton!
    
    @IBOutlet weak var menu: UIView!
    
    var closeDistance: CGFloat = 0.0
    
    var showDistance: CGFloat = 10
    
    var view: UIView!
    
    var coverAlpha: CGFloat = 0.4
  
    @IBOutlet weak var cameraButton: Button!
    
    @IBOutlet weak var airCoolButton: Button!
    
    @IBOutlet weak var lightButton: Button!
    
    @IBOutlet weak var imageUpandDownOfSelect: UIImageView!
    
    @IBOutlet weak var selectionWorkingTypeButton: UIButton!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var effectView: UIVisualEffectView!

    
    var selectedWorkingType : WorkingType?
    
    var closure: ((WorkingType)-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view = self
        setupToggleView(distance: menu.frame.height + 100)
         self.imageUpandDownOfSelect.transform = CGAffineTransform(rotationAngle: self.isOpen ? 0 : (45.0 * .pi) / 1.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    @IBAction func onClickSelectedButton(_ sender: UIButton) {
        switch sender {
        case cameraButton:
            selectedWorkingType = .camera
        case airCoolButton:
            selectedWorkingType = .airCool
        case lightButton:
            selectedWorkingType = .light
        default:
            break
        }
        closure?(selectedWorkingType!)
        toggle()
    }
    
    @IBAction func toggle(_ sender: UIButton! = nil) {
        isOpen = !isOpen
        performToggle(isOpen: isOpen)
        UIView.animate(withDuration: 0.35) {
            self.imageUpandDownOfSelect.transform = CGAffineTransform(rotationAngle: self.isOpen ? 0 : (45.0 * .pi) / 1.0)
            self.alpha = self.isOpen ? 1 : 0
            self.layoutIfNeeded()
        }
    }
    
}

