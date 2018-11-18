//
//  DetailViewController.swift
//  Memories
//
//  Created by Bepen Neupane on 11/17/18.
//  Copyright © 2018 Bepen Neupane. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var descL: UILabel!
    @IBOutlet weak var happySadL: UILabel!
    
    

    func configureView() {
        // Update the user interface for the detail item.
        if let memory = memoryItem {
            if let label = titleL {
                label.text = memory.title
            }
            if let label = descL {
                label.text = memory.description
            }
            if let label = happySadL {
                label.text = memory.type.name()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var memoryItem: MemoryItem? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

