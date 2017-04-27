        //
        //  AdminStationsViewController.swift
        //  BCO
        //
        //  Created by Prathipati,Yeswanth Eswar on 4/17/17.
        //  Copyright © 2017 Mamidala,Sri Sai Ram Kumar. All rights reserved.
        //

        import UIKit
        import Parse

        class AdminStationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

            var Stations:[String] = []
            
            
            @IBOutlet weak var StationsTable: UITableView!

            
            override func viewDidLoad() {
                super.viewDidLoad()
                print("aaaa")
                
                // To retrieve the data from database.
                let query = PFQuery(className: "Stations")
                query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
                    if error == nil
                    {
                        //print(objects!)
                        for obj in objects! {
                            self.Stations.append(obj["station_name"] as! String)
                            self.StationsTable.reloadData()
                            print(self.Stations)
                            
                        }
                    }
                    
                })
                
                // Styling of the page.
                self.navigationItem.title = "Stations"
                self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.0, green: 0.25, blue: 0.0, alpha: 1)
                self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
                self.navigationController?.navigationBar.tintColor = UIColor.white
                print(Stations)
                // Do any additional setup after loading the view.
            }
            
            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }

            // No.of rows in a section.
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
            {
                print("dddd")
                return Stations.count
            }
            
            //var g:IndexPath!
            
            // Populating the values onto table.
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
            {
                let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "stationIdentifier", for: indexPath)
                print("eeee")
                cell.textLabel!.text = Stations[indexPath.row]
                cell.textLabel?.textColor = UIColor(red: 0.0, green: 0.25, blue: 0.0, alpha: 1)
                return cell
                
            }
            
            var itemSele:String = ""
            // Action to perform on selection of a cell.
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                itemSele = Stations[indexPath.row]
                print("ffff")
                (UIApplication.shared.delegate as! AppDelegate).selectedItem = itemSele
                //self.navigationController?.pushViewController(a, animated: true)
                
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
