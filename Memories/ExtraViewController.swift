//
//  ExtraViewController.swift
//  Memories
//
//  Created by Bepen Neupane on 11/21/18.
//  Copyright © 2018 Bepen Neupane. All rights reserved.
//

import UIKit

class ExtraViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = NSLocalizedString("str_extraVC", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
