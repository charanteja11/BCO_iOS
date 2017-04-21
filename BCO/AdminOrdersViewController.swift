//
//  AdminOrdersViewController.swift
//  BCO
//
//  Created by Prathipati,Yeswanth Eswar on 4/17/17.
//  Copyright © 2017 Mamidala,Sri Sai Ram Kumar. All rights reserved.
//

import UIKit
import Parse

class AdminOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var itemName:[String] = []
    var itemTime:[String] = []
    var itemQunatity:[Int] = []
    
//    @IBOutlet weak var name: UILabel!
//    @IBOutlet weak var quantity: UILabel!
//    @IBOutlet weak var time: UILabel!
    
    

    @IBOutlet weak var cartTV: UITableView!
    
    
    func table()
    {
        itemName.removeAll()
        itemTime.removeAll()
        itemQunatity.removeAll()
        print("cccc")
        print(itemQunatity)
        let query = PFQuery(className: "Cart")
        query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
            
            if error == nil
            {
                
                for obj in objects! {
                    //print(obj)
                    self.itemName.append(obj["item_name"] as! String)
                    self.itemQunatity.append(obj["quantity"] as! Int)
                    self.itemTime.append(obj["pickupTime"] as! String)
                }
                self.cartTV.reloadData()
            }
            
        })
        print("cartItems \(itemName) \(itemQunatity) \(itemTime)")
        print(itemQunatity)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
         table()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("inside rows \(itemName.count)")
        return itemName.count+1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete)
        {
            
            let query = PFQuery(className: "Cart")
            query.whereKey("item_name", equalTo: self.itemName[indexPath.row - 1])
            query.whereKey("pickupTime", equalTo: self.itemTime[indexPath.row - 1])
            query.whereKey("quantity", equalTo: self.itemQunatity[indexPath.row - 1])
            
            print("aaaa")
            itemName.remove(at: indexPath.row - 1)
            itemQunatity.remove(at: indexPath.row - 1)
            itemTime.remove(at: indexPath.row - 1)
            print("bbbb")
            print(itemQunatity)
            //table()
            
            
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
                self.table()
            })
            
            
        }
        //cartTV.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("inside tablecell \(itemQunatity)")
        let cell:UITableViewCell!
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "abc", for: indexPath)
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cartList", for: indexPath)
            var name:UILabel = cell.viewWithTag(100) as! UILabel
            var time:UILabel = cell.viewWithTag(102) as! UILabel
            var quantity:UILabel = cell.viewWithTag(101) as! UILabel
            name.text = itemName[indexPath.row - 1]
            time.text = itemTime[indexPath.row - 1]
            quantity.text = String(itemQunatity[indexPath.row-1])
        }
        return cell
        
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
