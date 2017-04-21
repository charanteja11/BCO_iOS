//
//  StationsViewController.swift
//  BCO
//
//  Created by Mamidala,Sri Sai Ram Kumar on 4/2/17.
//  Copyright © 2017 Mamidala,Sri Sai Ram Kumar. All rights reserved.
//

import UIKit
import Parse

class StationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var Stations:[String] = []
    
    @IBOutlet weak var stationsTV: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = PFQuery(className: "Stations")
        query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
            if error == nil
            {
                //print(objects!)
                for obj in objects! {
                    self.Stations.append(obj["station_name"] as! String)
                    self.stationsTable.reloadData()

                }
            }
            
        })
        self.navigationItem.title = "Stations"
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var stationsTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return Stations.count
    }
    
    //var g:IndexPath!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "stationIdentifier", for: indexPath)
        cell.textLabel!.text = Stations[indexPath.row]
        return cell
        
    }
    var itemSele:String = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemSele = Stations[indexPath.row]
        (UIApplication.shared.delegate as! AppDelegate).selectedItem = itemSele
        //self.navigationController?.pushViewController(a, animated: true)
        
    }
    
    @IBAction func Stationunwind(unwindSegue:UIStoryboardSegue)
    {
        
      let a = unwindSegue.source as! MenuViewController
  
    }
    

    
//        //self.performSegue(withIdentifier: "menuItems", sender: self)
//    }
    
    /*
  ceil MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
