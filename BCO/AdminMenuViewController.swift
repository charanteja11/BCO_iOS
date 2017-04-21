//
//  AdminMenuViewController.swift
//  BCO
//
//  Created by Prathipati,Yeswanth Eswar on 4/17/17.
//  Copyright © 2017 Mamidala,Sri Sai Ram Kumar. All rights reserved.
//

import UIKit
import Parse

class AdminMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var itemSelected:String = ""
    var Menu:[String] = []
    
    @IBOutlet weak var menuTable: UITableView!
    func addItem(s:String){
        self.itemSelected=s
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemSelected = (UIApplication.shared.delegate as! AppDelegate).selectedItem
        //print(self.itemSelected+"1")
        let query = PFQuery(className: self.itemSelected)
        query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
            
            if error == nil
            {
                for obj in objects! {
                    self.Menu.append(obj["menu_name"] as! String)
                    self.menuTable.reloadData()
                }
            }
            
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete)
        {
            
            let query = PFQuery(className: self.itemSelected)
            query.whereKey("menu_name", equalTo: self.Menu[indexPath.row])
            Menu.remove(at: indexPath.row)
            query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
                if error == nil
                {
                    //print(objects!)
                    for obj in objects!
                    {
                       
                        obj.deleteInBackground()
                        break
                        //self.table()
                    }
                }
                self.menuTable.reloadData()
            })
            
            
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
    {
        return Menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuIdentifier", for: indexPath)
        
        //let tmenu:PFObject = TexmexMenu[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = Menu[indexPath.row]
        //cell.detailTextLabel!.text = tmenu["menu_price"] as! String!
        
        //cell.viewWithTag(tmenu["menu_price"] as! Int)
        
        return cell
    }

    @IBAction func addMenu(_ sender: Any) {
        
        var textField : String = ""
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add an item", message: "", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            textField = (alert?.textFields![0].text)! // Force unwrapping because we know it exists.
            print("Text field: \(textField)")
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
//        var query = PFQuery(className: self.itemSelected)
//        
//        Menu.append(textField)
//        query.
//        query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
//            if error == nil
//            {
//                objects?.insert(contentsOf: Menu, at: 0)
//            }
//            self.menuTable.reloadData()
//        })
//
        
        
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
