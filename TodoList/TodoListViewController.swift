//
//  ViewController.swift
//  TodoList
//
//  Created by Barış Güngör on 22.04.2019.
//  Copyright © 2019 Baris. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
       if let items = defaults.array(forKey: "TodoListArray") as? [String]
       {
            itemArray = items
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPress(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           self.itemArray.append(textfield.text!)
            self.defaults.set(self.itemArray, forKey:"TodoListArray")
            self.tableView.reloadData()
           
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textfield = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion:  nil)
    }
    
}

