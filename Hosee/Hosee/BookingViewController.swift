//
//  ViewController.swift
//  Booking
//
//  Created by Mac on 3/19/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var loadding: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var runingLabel: InfinityLoopLabelView!
    @IBOutlet weak var backButton: Button!

    @IBOutlet weak var cancelButton: UIButton!
    
    var restString: String?
    var timer = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if restString != nil {
            runingLabel.text = restString
        }
        backButton.isHidden = true
        cancelButton.isEnabled = false
        startTime()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        photo.roundAndRound(duration: 5.0)
    }
    
    func startTime () {
        var _ = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(BookingViewController.actions), userInfo: nil, repeats: true)
    }
    @objc func actions (){
        if(timer > 0) {
            timer -= 1
            timerLabel.text = String(timer)
        } else {
            backButton.isHidden = false
            cancelButton.isEnabled = true
            timerLabel.isHidden = true
        }
    }
    
    @IBAction func backBtnMap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
      
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
