//
//  TableViewCell.swift
//  KiemTien2
//
//  Created by daicudu on 3/19/19.
//  Copyright © 2019 daicudu. All rights reserved.
//

import UIKit
@IBDesignable
class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var starRating: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
        // Initialization code
    }
    
    func setShadow() {
        
        containView.layer.shadowColor = UIColor.gray.cgColor
        containView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containView.layer.shadowOpacity = 0.35
        containView.layer.cornerRadius = 8
        containView.layer.shadowRadius = 5
    }

    
    override func prepareForReuse() {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
