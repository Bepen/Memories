//
//  ColorViewController.swift
//  Memories
//
//  Created by Bepen Neupane on 11/19/18.
//  Copyright © 2018 Bepen Neupane. All rights reserved.
//

import UIKit

protocol ColorVCDelegate: class {
    func indexUpdate(_ index: Int)
}

class ColorViewController: UIViewController {
    
    @IBOutlet weak var doubleTapL: UILabel!
    @IBOutlet weak var pinchL: UILabel!
    @IBOutlet var doubleTap: UITapGestureRecognizer!
    @IBOutlet var pinch: UIPinchGestureRecognizer!
    @IBOutlet var mainView: UIView!
    let cArray = [UIColor.cyan, UIColor.orange]
    var index: Int!
    
    weak var delegate: ColorVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backgroundColor = cArray[index]
        
        doubleTapL.text = NSLocalizedString("str_doubleTap", comment: "")
        pinchL.text = NSLocalizedString("str_pinch", comment: "")
        doubleTap.numberOfTapsRequired = 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        
        if(index == 0){
            index = 1
            mainView.backgroundColor = cArray[index]
            delegate?.indexUpdate(index)
        } else{
            index = 0
            mainView.backgroundColor = cArray[index]
            delegate?.indexUpdate(index)
        }
        
        
        
        
    }
    
    @IBAction func onPinch(_ sender: UIPinchGestureRecognizer) {
        if(sender.state == .ended){
            if(index == 0){
                index = 1
                mainView.backgroundColor = cArray[index]
                delegate?.indexUpdate(index)
            } else{
                index = 0
                mainView.backgroundColor = cArray[index]
                delegate?.indexUpdate(index)
            }
        }
        
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
