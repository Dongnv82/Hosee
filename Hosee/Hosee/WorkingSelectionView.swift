//
//  WorkingSelectionView.swift
//  Hosee
//
//  Created by Vu on 4/11/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

enum WorkingType {
    case camera
    case airCool
    case light
}
class WorkingSelectionView:  View {
    
    @IBOutlet weak var effectView: UIVisualEffectView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var coverButton: UIButton!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var cameraButton: Button!
    @IBOutlet weak var airCoolButton: Button!
    @IBOutlet weak var lightButton: Button!
    @IBOutlet weak var imageUpandDownOfSelect: UIImageView!
    @IBOutlet weak var selectedButton: UIButton!
    var closure: ((WorkingType)-> Void)?
    var isOpen: Bool = true {
        didSet {
            UIView.animate(withDuration: 0.35, animations: {
                self.topConstraint.constant = self.isOpen ? 32 : -self.dialogView.bounds.height
                self.coverButton.alpha = self.isOpen ? 0.8 : 0
                self.effectView.alpha = self.isOpen ? 0.8 : 0
                self.imageUpandDownOfSelect.transform = CGAffineTransform(rotationAngle: self.isOpen ? 0 : (45.0 * .pi) / 1.0)
                self.alpha = self.isOpen ? 1 : 0
                self.layoutIfNeeded()
            }) { (success) in
                
            }
        }
    }
    
    
    
    @IBAction func onClickSelectedButton(_ sender: UIButton) {
        switch sender {
        case cameraButton:
            closure?(.camera)
        case airCoolButton:
            closure?(.airCool)
        case lightButton:
            closure?(.light)
        default:
            break
        }
        toggle()
        sender.isSelected = !sender.isSelected
    }

    @IBAction func onClickCoverButton(_ sender: UIButton) {
        toggle()
        selectedButton.isSelected = false
    }
    
    func toggle() {
        isOpen = !isOpen
    }
    
}

