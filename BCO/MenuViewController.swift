        //
        //  MenuViewController.swift
        //  BCO
        //
        //  Created by Mamidala,Sri Sai Ram Kumar on 4/2/17.
        //  Copyright © 2017 Mamidala,Sri Sai Ram Kumar. All rights reserved.
        //

        import UIKit
        import Parse

        class MenuViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{

            let menuList = ["Burger","Sandwich","Pizza","Icecream","Nuggets","Burrito"]
            var itemSelected:String = ""
            var Menu:[String] = []
            
            func addItem(s:String){
                self.itemSelected=s
            }
            override func viewDidLoad() {
                super.viewDidLoad()
                
                // selecting the respective station from previous page.
                itemSelected = (UIApplication.shared.delegate as! AppDelegate).selectedItem
                //print(self.itemSelected+"1")
                let query = PFQuery(className: self.itemSelected)
                
                // To retrieve the data from database.
                query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
                    
                    if error == nil
                    {
                        for obj in objects! {
                            self.Menu.append(obj["menu_name"] as! String)
                            self.menuTable.reloadData()
                        }
                    }
                    
                })
                
                self.navigationItem.title = "Items"
            }

            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
            
            override func viewWillAppear(_ animated: Bool) {
                
            }
            
            @IBOutlet weak var menuTable: UITableView!
            
            // No.of section a row.
            func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
            
            // No.of rows in a section.
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
                
            {
                return Menu.count
            }
            
            // Populating the values onto table.
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
            {
                
                let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuIdentifier", for: indexPath)
                
                //let tmenu:PFObject = TexmexMenu[(indexPath as NSIndexPath).row]
                cell.textLabel!.text = Menu[indexPath.row]
                cell.textLabel?.textColor = UIColor(red: 0.0, green: 0.25, blue: 0.0, alpha: 1)
                //cell.detailTextLabel!.text = tmenu["menu_price"] as! String!
                
                //cell.viewWithTag(tmenu["menu_price"] as! Int)
                
                return cell
            }

            // Action to perform on selection of a cell.
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                (UIApplication.shared.delegate as! AppDelegate).item = Menu[indexPath.row]
                //performSegue(withIdentifier: "cartIdentifier", sender: nil)
            }

            // Unwing segue to go back to cart.
            @IBAction func Menuunwind(unwindSegue:UIStoryboardSegue)
            {
                
                _ = unwindSegue.source as! CartViewController
                
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
