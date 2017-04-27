        //
        //  LoginsViewController.swift
        //  BCO
        //
        //  Created by Mamidala,Sri Sai Ram Kumar on 4/2/17.
        //  Copyright © 2017 Mamidala,Sri Sai Ram Kumar. All rights reserved.
        //

        import UIKit
        import Parse

        class LoginsViewController: UIViewController {

            override func viewDidLoad() {
                super.viewDidLoad()
                
                // To dismiss the keyboard on tap.
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(LoginsViewController.dismissKeyboard))
                view.addGestureRecognizer(tap)
                // Do any additional setup after loading the view.
                
                // Styling of the page.
                self.userEmail.layer.borderColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1).cgColor;
                self.userEmail.layer.borderWidth = CGFloat(Float(1.0));
                self.userEmail.layer.cornerRadius = CGFloat(Float(5.0));
                
                self.userPassword.layer.borderColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1).cgColor;
                self.userPassword.layer.borderWidth = CGFloat(Float(1.0));
                self.userPassword.layer.cornerRadius = CGFloat(Float(5.0));
            }
            
            // Function to implement the keyboard dismissal.
            func dismissKeyboard()
            {
                view.endEditing(true)
            }

            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
            
            @IBOutlet weak var userEmail: UITextField!

            @IBOutlet weak var userPassword: UITextField!
            
            // Validation and perform segue to go to the user stations.
            @IBAction func loginButton(_ sender: Any) {
                
                let email = userEmail.text!
                let password  = userPassword.text!
                
                if(email.isEmpty || password.isEmpty)
                {
                    displayMyAlertMessage(userMessage: "All fields are required");
                    return;
                }
                
                
                let query = PFQuery(className:"Customer")
                if email.characters.count > 0 && password.characters.count>0
                {
                    query.whereKey("email", equalTo: email)
                    query.whereKey("password", equalTo: password)
                }
                query.findObjectsInBackground {
                    (objects: [PFObject]?, error: Error?) -> Void in
                    if error == nil
                    {
                        if( objects?.count == 0)
                        {
                            //print("Login failure")
                            self.displayMyAlertMessage(userMessage: "Login Failure");
                            
                        }
                        else
                        {
                            var cartItem = CartItems()
                            let query = PFQuery(className: "Cart")
                            query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
                                if error == nil
                                {
                                    //print(objects!)
                                    for obj in objects!
                                    {
                                        obj.deleteInBackground()
                                        cartItem = obj as! CartItems
                                    }
                                }
                                
                            })

                            
                            self.performSegue(withIdentifier: "stations", sender: self)
                            
                        }
                     
                    }
                    
                }
            }
            
            // Validation and retrieve the data on admin login.
            @IBAction func adminLogin(_ sender: Any) {
                
                let email = userEmail.text!
                let password  = userPassword.text!
                
                if(email.isEmpty || password.isEmpty)
                {
                    displayMyAlertMessage(userMessage: "All fields are required");
                    return;
                }
                
                
                let query = PFQuery(className:"Customer")
                if email.characters.count > 0 && password.characters.count>0
                {
                    query.whereKey("email", equalTo: email)
                    query.whereKey("password", equalTo: password)
                }
                query.findObjectsInBackground {
                    (objects: [PFObject]?, error: Error?) -> Void in
                    if error == nil
                    {
                        if( objects?.count == 0)
                        {
                            //print("Login failure")
                            self.displayMyAlertMessage(userMessage: "Login Failure");
                            
                        }
                        else
                        {
                            var cartItem = CartItems()
                            let query = PFQuery(className: "Cart")
                            query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
                                if error == nil
                                {
                                    //print(objects!)
                                    for obj in objects!
                                    {
                                        obj.deleteInBackground()
                                        cartItem = obj as! CartItems
                                    }
                                }
                                
                            })
                            
                            
                            self.performSegue(withIdentifier: "stations", sender: self)
                            
                        }
                        
                    }
                    
                }
                
            }
            
            
        //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let station = self.tabBarController?.viewControllers?[0] as! StationsViewController
        //        let query = PFQuery(className: "Stations")
        //        var Stations:[String]!
        //        //query.whereKeyExists("station_name")
        //        
        //        query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
        //            if error == nil
        //            {
        //                print(objects!)
        //                for obj in objects! {
        //                    station.Stations.append(obj["station_name"] as! String)
        //                }
        //            }
        //            
        //        })
        //    }
            
            // Perfrom segue to go to the register page.
            @IBAction func registerButton(_ sender: Any) {
                
                performSegue(withIdentifier: "register", sender: self)
            }
            
            
            // Unwind segue to come to this page by varous segue identifiers.
            @IBAction func unwind(unwindSegue:UIStoryboardSegue)
            {
                if(unwindSegue.identifier == "register")
                {
                    _ = unwindSegue.source as! RegisterViewController
                }
                else if(unwindSegue.identifier == "menuItems")
                {
                    _ = unwindSegue.source as! MenuViewController
                }
                else if(unwindSegue.identifier == "paymentIdentifier")
                {
                    _ = unwindSegue.source as! MenuViewController
                }
                else if(unwindSegue.identifier == "stations")
                {
                    _ = unwindSegue.source as! MenuViewController
                }
                //let b = unwindSegue.source as! RegisterViewController
            }
            
             // Alert function to display messages.
            func displayMyAlertMessage(userMessage:String)
                
            {
                let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
                let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
                myAlert.addAction(okAction);
                self.present(myAlert, animated:true, completion:nil);
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
