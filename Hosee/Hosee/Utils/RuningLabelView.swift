//
//  LoopsLabelView.swift
//  Booking
//
//  Created by Minh Thang on 3/21/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
class RuningLabelView: UIView {
    
    private var rect0: CGRect!
    private var rect1: CGRect!
    private var labelArray = [UILabel]()
    private var timeInterval: TimeInterval!
    private let leadingBuffer = CGFloat(5.0)
    private let loopStartDelay = 2.0
    private var leadingConstraint  : NSLayoutConstraint?
    private var stackView                 : UIStackView?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var text: String? {
        didSet {
            setup()
        }
    }
    
    private var isTextTooLong: Bool {
        get {
            let label = UILabel()
            label.text = text
            label.frame = CGRect.zero
            let sizeOfText = label.sizeThatFits(CGSize.zero)
            return sizeOfText.width > frame.size.width ? true : false
        }
    }
    
    private var isRunning = false {
        didSet {
            if !isRunning {
                timeInterval = TimeInterval((text?.characters.count)! / 5)
                UIView.animate(withDuration: timeInterval, delay: loopStartDelay, options: [.curveLinear, .repeat], animations: {
                    self.leadingConstraint?.constant = -self.stackView!.bounds.width
                    self.layoutIfNeeded()
                })
            } else {
                self.subviews.forEach{$0.removeFromSuperview()}
            }
            
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        reset()
        if isTextTooLong {
            stackView = UIStackView()
            stackView?.axis = .horizontal
            stackView?.spacing = 20.0
            
            let label1 = UILabel()
            label1.text = text
            let label2 = UILabel()
            label2.text = text
            
            stackView?.addArrangedSubview(label1)
            stackView?.addArrangedSubview(label2)
            
            self.addSubview(stackView!)
            stackView?.fill(left: nil, top: leadingBuffer, right: nil, bottom: 0)
            let leadingConstraint = stackView?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
            leadingConstraint?.isActive = true
            self.isRunning = true
        } else {
            let label = UILabel()
            label.text = text
            self.addSubview(label)
            label.fill()
        }
       
    }
    
    func reset() {
        super.clipsToBounds = true
        stackView = nil
        self.subviews.forEach{$0.removeFromSuperview()}
        self.layer.removeAllAnimations()
    }
    
  
}
