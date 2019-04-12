//
//  HomeViewController+WorkingSelectionView.swift
//  Hosee
//
//  Created by Vu on 4/11/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

extension HomeViewController {
    func setupWorkingSelectionView() {
        view.addSubview(workingSelectionView)
        workingSelectionView.fill(left: 0, top: 0, right: 0, bottom: -100)

        workingSelectionView.closure = { [weak self] workingType in
            var text: String = ""
            switch workingType {
            case .camera:
                text = "Sửa chữa Camera"
                
            case .airCool:
                text = "Sửa chữa Điều Hoà"
                
            default:
                text = "Sửa chữa Đèn"
            }
            self?.selectedButton.setTitle(text, for: .normal)
            self?.selectedButton.isSelected = false
        }
    }
    

    
    
    
    @IBAction func onClickSelectedMenu(_ sender: UIButton) {
        workingSelectionView.toggle()
          sender.isSelected = !sender.isSelected
    }
}

