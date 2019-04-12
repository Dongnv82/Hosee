//
//  PromotionResultController.swift
//  Hosee
//
//  Created by Duc Anh on 4/12/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class PromotionResultController: PromotionViewController {
    static var instance : PromotionResultController {
        let storyboard = UIStoryboard(name: "Promotion", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "PromotionResultController") as! PromotionResultController
    }
}
