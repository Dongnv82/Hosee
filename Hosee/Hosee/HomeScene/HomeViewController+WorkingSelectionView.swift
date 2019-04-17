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
            self?.selectedWorkingType = workingType
        }
    }
    
    @IBAction func onClickSelectedWorkingType(_ sender: UIButton) {
        workingSelectionView.toggle()
          sender.isSelected = !sender.isSelected
    }
}

