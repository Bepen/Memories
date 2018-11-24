/* Bepen Neupane
 * bneupane@u.rochester.edu
 * CSC 214 Fall 2018 - Project 3, 11/24/18
 * I affirm that I have not given or received any unauthorized help on this assignment, and that this work is my own.
 */

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
