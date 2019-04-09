//
//  TestViewController.swift
//  Hosee
//
//  Created by huy on 09/04/2019.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var string: String?
    
    @IBOutlet weak var testView: InfinityLoopLabelView!
    override func viewDidLoad() {
        super.viewDidLoad()
        string = "asfhnjkasdfhadjksfhasfhasdikfhadsklfaskjfhashfjkasfhjkash"
        
        testView.text = string
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
