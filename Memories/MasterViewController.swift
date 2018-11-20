//
//  MasterViewController.swift
//  Memories
//
//  Created by Bepen Neupane on 11/17/18.
//  Copyright © 2018 Bepen Neupane. All rights reserved. 
//

import UIKit
import CoreLocation

class MasterViewController: UITableViewController, CLLocationManagerDelegate {
    
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var memories: Memories!
    @IBOutlet weak var colorButton: UIBarButtonItem!
    var locationManager: CLLocationManager!
    var latitude = "0"
    var longitude = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colorButton.title = NSLocalizedString("str_color", comment: "")
        if(memories.memoryList.count == 0){
            memories.add(title: "Happy!!", description: "This is a default happy memory", type: .happy, latitude: latitude, longitude: longitude)
        }
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 1
        locationManager.delegate = self
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.startLoc()
        self.stopLoc()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        startLoc()
        insertWithAlert()
        
    }
    
    // MARK: - Alerts
    
    func insertWithAlert(){
        let alert = UIAlertController(title: NSLocalizedString("str_prompt", comment: ""), message: nil, preferredStyle: .alert)
        var title = ""
        var desc = ""
        let continueAction = UIAlertAction(title:NSLocalizedString("str_continue", comment: ""), style: .default, handler: { _ in
            if let textField = alert.textFields?.first, let titleAdd = textField.text, !titleAdd.isEmpty {
                title = titleAdd
            }
            if let textField = alert.textFields?.last, let descAdd = textField.text, !descAdd.isEmpty {
                desc = descAdd
            }
            self.insertWithAlertChild(title: title, desc: desc)
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = NSLocalizedString("str_title", comment: "")
            continueAction.isEnabled = false
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { _ in
                continueAction.isEnabled = !textField.text!.isEmpty
            }
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = NSLocalizedString("str_desc", comment: "")
            continueAction.isEnabled = false
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { _ in
                continueAction.isEnabled = !textField.text!.isEmpty
            }
        })
        
        alert.addAction(continueAction)
        alert.addAction(UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        //iPad
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
    }
    
    func insertWithAlertChild(title: String, desc: String){
        let alert2 = UIAlertController(title: NSLocalizedString("str_prompt2", comment: ""), message: nil, preferredStyle: .alert)
        let happyAction = UIAlertAction(title:NSLocalizedString("str_happy", comment: ""), style: .default, handler: { _ in
            self.finalizeInsert(title: title, desc: desc, type: .happy)
            
        })
        let sadAction = UIAlertAction(title:NSLocalizedString("str_sad", comment: ""), style: .default, handler: { _ in
            self.finalizeInsert(title: title, desc: desc, type: .sad)
            
        })
        
        alert2.addAction(sadAction)
        alert2.addAction(happyAction)
        self.present(alert2, animated: true, completion: nil)
        
        //iPad
        alert2.popoverPresentationController?.permittedArrowDirections = []
        alert2.popoverPresentationController?.sourceView = self.view
        alert2.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
    }
    
    func finalizeInsert(title: String, desc: String, type: MemoryType){
        let mem = MemoryItem(title: title, description: desc, type: type, latitude: latitude, longitude: longitude)
        stopLoc()
        print(mem.latitude)
        
        
        if(memories.unique(mem: mem)){
            if (mem.type == .happy){
                memories.add(mem: mem)
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
                
            } else{
                memories.add(mem: mem)
                let indexPath = IndexPath(row: 0, section: 1)
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        } else{
            let alert3 = UIAlertController(title: NSLocalizedString("str_prompt3", comment: ""), message: nil, preferredStyle: .alert)
            alert3.addAction(UIAlertAction(title: NSLocalizedString("str_okay", comment: ""), style: .default, handler: nil))
            self.present(alert3, animated: true, completion: nil)
            
            //iPad
            alert3.popoverPresentationController?.permittedArrowDirections = []
            alert3.popoverPresentationController?.sourceView = self.view
            alert3.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        }
        
    }
    
    func cantDeleteAlert(){
        let alert4 = UIAlertController(title: NSLocalizedString("str_prompt4", comment: ""), message: nil, preferredStyle: .alert)
        alert4.addAction(UIAlertAction(title: NSLocalizedString("str_okay", comment: ""), style: .default, handler: nil))
        self.present(alert4, animated: true, completion: nil)
        
        //iPad
        alert4.popoverPresentationController?.permittedArrowDirections = []
        alert4.popoverPresentationController?.sourceView = self.view
        alert4.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                var object: MemoryItem?
                if(indexPath.section == 0){
                    let mArr = memories.memories(for: .happy)
                    object = mArr[indexPath.row]
                } else{
                    let mArr = memories.memories(for: .sad)
                    object = mArr[indexPath.row]
                }
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.memoryItem = object
                controller.title = object?.title
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        if segue.identifier == "showColor" {
            if let colorVC = segue.destination as? ColorViewController {
                colorVC.delegate = self
                colorVC.index = memories.index
                colorVC.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                colorVC.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return MemoryType.allValues.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let type = MemoryType(rawValue: section) {
            return memories.memories(for: type).count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let type = MemoryType(rawValue: section) {
            return type.name()
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let type = MemoryType(rawValue: indexPath.section) {
            var typeMemories = memories.memories(for: type)
            let mem = typeMemories[indexPath.row]
            cell.textLabel?.text = mem.title
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if(memories.memoryList.count > 1){
                //self.memories.removeItem(at: indexPath.row)
                var mem: MemoryItem
                if(indexPath.section == 0){
                    let mArr = memories.memories(for: .happy)
                    mem = mArr[indexPath.row]
                } else{
                    let mArr = memories.memories(for: .sad)
                    mem = mArr[indexPath.row]
                }
                self.memories.removeItem(mem: mem)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else{
                cantDeleteAlert()
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    //MARK: - Location Management
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: " + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            let coordinate = location.coordinate
            longitude = coordinate.longitude.description
            latitude = coordinate.latitude.description
        }
    }
    
    func startLoc() {
        switch CLLocationManager.authorizationStatus() {
        case .denied:
            locErrorAlert(title: NSLocalizedString("str_cantGetLoc", comment: ""),
                          message: NSLocalizedString("str_goSet", comment: ""))
        case .restricted:
            locErrorAlert(title: NSLocalizedString("str_cantGetLoc", comment: ""),
                          message: NSLocalizedString("str_goSet", comment: ""))
        default:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopLoc() {
        locationManager.stopUpdatingLocation()
    }
    
    
    
    func locErrorAlert(title: String, message: String) {
        let alert5 = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("str_okay", comment: ""), style: .default)
        alert5.addAction(okAction)
        self.present(alert5, animated: true)
        
        //iPad
        alert5.popoverPresentationController?.permittedArrowDirections = []
        alert5.popoverPresentationController?.sourceView = self.view
        alert5.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
    }
    
}

// MARK: - Color Delegate
extension MasterViewController: ColorVCDelegate { //updates holiday
    func indexUpdate(_ index: Int){
        memories.index = index
    }
}

