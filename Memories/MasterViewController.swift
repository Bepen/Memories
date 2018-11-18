//
//  MasterViewController.swift
//  Memories
//
//  Created by Bepen Neupane on 11/17/18.
//  Copyright © 2018 Bepen Neupane. All rights reserved. 
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var memories: Memories!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
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
        insertWithAlert()
        
    }
    
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
            self.memories.add(title: title, description: desc, type: .happy)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        })
        let sadAction = UIAlertAction(title:NSLocalizedString("str_sad", comment: ""), style: .default, handler: { _ in
            self.memories.add(title: title, description: desc, type: .sad)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        })

        alert2.addAction(sadAction)
        alert2.addAction(happyAction)
        self.present(alert2, animated: true, completion: nil)
        
        //iPad
        alert2.popoverPresentationController?.permittedArrowDirections = []
        alert2.popoverPresentationController?.sourceView = self.view
        alert2.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = memories.memoryList[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.memoryItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memories.memoryList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = memories.memoryList[indexPath.row]
        cell.textLabel!.text = object.title
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memories.removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

