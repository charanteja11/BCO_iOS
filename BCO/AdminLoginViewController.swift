//
//  AdminLoginViewController.swift
//  BCO
//
//  Created by Inventory System on 4/20/17.
//  Copyright © 2017 Mamidala,Sri Sai Ram Kumar. All rights reserved.
//

import UIKit
import Parse

class AdminLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var userName: UITextField!

    @IBOutlet weak var passWord: UITextField!
    
    func displayMyAlertMessage(userMessage:String)
        
    {
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
    }
    
    @IBAction func AdminLogin(_ sender: Any) {
        let email = userName.text!
        let password  = passWord.text!
        let query = PFQuery(className:"Admin")

        if(email.isEmpty || password.isEmpty)
        {
            displayMyAlertMessage(userMessage: "All fields are required");
            return;
        }
        
        
        
        else
        {
            query.whereKey("username", equalTo: email)
            query.whereKey("password", equalTo: password)
        }
        
        query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
            if error == nil
            {

                if( objects?.count == 0)
                {
                    print("Login failure")
                    self.displayMyAlertMessage(userMessage: "Login Failure");
                    
                }
                else
                {
                    print("aaaa")
                    self.performSegue(withIdentifier: "adminStations", sender: self)
                }
                
                
            }

        })
        
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
