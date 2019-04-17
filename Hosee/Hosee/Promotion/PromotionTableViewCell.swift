//
//  HasPromotionTableViewCell.swift
//  HasPromotion
//
//  Created by duycuong on 3/27/19.
//  Copyright © 2019 duycuong. All rights reserved.
//


import UIKit

protocol PromotionTableViewCellDelegate {
    func usingPromotion(_ promotion: Promo?)
}

let dateNow = Date()

class PromotionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var promotionDayLabel: UILabel!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var dashView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var topUpView: NSLayoutConstraint!
    @IBOutlet weak var bottomUnderView: NSLayoutConstraint!
    @IBOutlet weak var bottomDashView: NSLayoutConstraint!
    @IBOutlet weak var topDashView: NSLayoutConstraint!
    
    let formatter: DateFormatter = {
        let tmpFormatter = DateFormatter()
        tmpFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        return tmpFormatter
    }()
    
    var delegate: PromotionTableViewCellDelegate?
    var promotion: Promo? {
        didSet {
            if let promotion = promotion {
                let dateTo = promotion.availableTo?.toDate
                
                let dayLeft = Calendar.current.dateComponents([.day], from: dateNow, to: dateTo!)
                
                
                promotionDayLabel.text = String("\(dayLeft.day!) ngày")
                titleLabel.text = promotion.keyString
                timeLabel.text = promotion.availableTo
            } else {
                promotionDayLabel.text = ""
                titleLabel.text = ""
                timeLabel.text = ""
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customLayoutView()
        dashView.addDashedBorder()
    }
    
    override func prepareForReuse() {
        promotion = nil
    }
    
    func getTimeOfDate() -> String {
        let curDate = Date()
        let timeString = formatter.string(from: curDate)
        return timeString
    }
    
    func customLayoutView() {
        let radius = -(upView.bounds.height / 2)
        topUpView.constant = radius
        bottomUnderView.constant = radius
        topDashView.constant = -radius
        bottomDashView.constant = -radius
        timeLabel.textColor = UIColor.gray
    }
    @IBAction func onClickedUsePromotion(_ sender: Any) {
        delegate?.usingPromotion(promotion)
        //navigationController?.popViewController(animated: true)
        
    }
    
}

extension UIView {
    func addDashedBorder() {
        let color = UIColor.groupTableViewBackground.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [2,4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}
