        //
        //  CartItemsViewController.swift
        //  BCO
        //
        //  Created by Abhishek Kavalla on 4/12/17.
        //  Copyright © 2017 Mamidala,Sri Sai Ram Kumar. All rights reserved.
        //

        import UIKit
        import Parse

        class CartItemsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

            var cost:Int = 0
           // @IBOutlet weak var totalPrice: UILabel!
            @IBOutlet weak var cartTV: UITableView!
            var itemName:[String] = []
            var itemPrice:[Int] = []
            var itemQunatity:[Int] = []
            var cart = PFObject(className : "Cart")
            //var cart : [Cart]?
            override func viewDidLoad() {
                super.viewDidLoad()
                // Styling of the page.
                self.navigationItem.title = "Cart"
                self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.25, blue: 0.0, alpha: 1)
                self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
                self.navigationController?.navigationBar.tintColor = UIColor.white
                // Do any additional setup after loading the view.
            }

            @IBOutlet weak var checkoutButton: UIButton!
            
            // View to be updated everytime it appears.
            override func viewWillAppear(_ animated: Bool) {
                table()
            }
            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
            
            // To retrieve the information and store it in arrays.
            func table()
            {
                itemName.removeAll()
                itemPrice.removeAll()
                itemQunatity.removeAll()
                print("cccc")
                print(itemQunatity)
                let query = PFQuery(className: "Cart")
                self.cost = 0
                query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
                    
                    if error == nil
                    {
                        
                        for obj in objects! {
                            //print(obj)
                            self.itemName.append(obj["item_name"] as! String)
                            self.itemQunatity.append(obj["quantity"] as! Int)
                            self.itemPrice.append(obj["price"] as! Int)
                            self.cost += (obj["quantity"] as! Int) * (obj["price"] as! Int)
                            self.checkoutButton.isEnabled = true
                            //print(self.cost)
                        }
                        self.cartTV.reloadData()
                    }
                    
                })
                print("cartItems \(itemName) \(itemQunatity) \(itemPrice)")
                //self.totalPrice.text = String(cost)
                if(self.cost == 0)
                {
                    checkoutButton.isEnabled = false
                }
                print("dddd")
                print(itemQunatity)

            }
            
            // No.of rows in a section.
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                print("inside rows \(itemName.count)")
                return itemName.count+2
            }
            
            // Deletion of table cell and its data.
            func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
                if(editingStyle == UITableViewCellEditingStyle.delete)
                {
                    
                    let query = PFQuery(className: "Cart")
                    query.whereKey("item_name", equalTo: self.itemName[indexPath.row - 1])
                    query.whereKey("price", equalTo: self.itemPrice[indexPath.row - 1])
                    query.whereKey("quantity", equalTo: self.itemQunatity[indexPath.row - 1])
                    
                    print("aaaa")
                    itemName.remove(at: indexPath.row - 1)
                    itemQunatity.remove(at: indexPath.row - 1)
                    itemPrice.remove(at: indexPath.row - 1)
                    print("bbbb")
                    print(itemQunatity)
                    //table()
                    
                    
                    query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
                        if error == nil
                        {
                            //print(objects!)
                            for obj in objects!
                            {
                                
                                //self.cartTV.deleteSections(<#T##sections: IndexSet##IndexSet#>, with: <#T##UITableViewRowAnimation#>)
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
            
            // Populating the values onto table.
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                print("inside tablecell \(itemQunatity)")
                let cell:UITableViewCell!
                if indexPath.row == itemName.count+1 {
                    cell = tableView.dequeueReusableCell(withIdentifier: "total", for: indexPath)
                    let price = cell.viewWithTag(103) as! UILabel
                    price.text = String(cost)
                }
                else if indexPath.row == 0 {
                    cell = tableView.dequeueReusableCell(withIdentifier: "abc", for: indexPath)
                }
                else {
                cell = tableView.dequeueReusableCell(withIdentifier: "cartList", for: indexPath)
                let name:UILabel = cell.viewWithTag(100) as! UILabel
                let price:UILabel = cell.viewWithTag(102) as! UILabel
                let quantity:UILabel = cell.viewWithTag(101) as! UILabel
                name.text = itemName[indexPath.row-1]
                price.text = String(itemQunatity[indexPath.row-1]*itemPrice[indexPath.row-1])
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
