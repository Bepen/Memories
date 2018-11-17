//
//  AboutViewController.swift
//  Memories
//
//  Created by Bepen Neupane on 11/17/18.
//  Copyright © 2018 Bepen Neupane. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var buildLabel: UILabel!
    @IBOutlet var appLogo: UIImageView!
    @IBOutlet var launchLabel: UILabel!
    @IBOutlet var accessLabel: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var copyrightLabel: UILabel!
    
    let defaults = UserDefaults(suiteName: kAppGroupBundleID)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initializes the about view with the proper bundle values
        button.setTitle(NSLocalizedString("str_done", comment: ""), for: .normal)
        nameLabel.text = Bundle.main.displayName
        versionLabel.text = Bundle.main.version
        buildLabel.text = Bundle.main.build
        copyrightLabel.text = Bundle.main.copyright
        launchLabel.text = defaults.integer(forKey: dNumLaunches).description
        accessLabel.text = defaults.string(forKey: dDate)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onButton(_ sender: Any) {
        //dismisses the about view controler
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
