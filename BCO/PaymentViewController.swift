        //
        //  PaymentViewController.swift
        //  BCO
        //
        //  Created by Mamidala,Sri Sai Ram Kumar on 4/2/17.
        //  Copyright © 2017 Mamidala,Sri Sai Ram Kumar. All rights reserved.
        //

        import UIKit
        import Parse

        class PaymentViewController: UIViewController {

            

            override func viewDidLoad() {
                super.viewDidLoad()
                
                // To dismiss the keyboard on tap.
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(PaymentViewController.dismissKeyboard))
                view.addGestureRecognizer(tap)
                
                self.navigationItem.title = "Payment"

                // Do any additional setup after loading the view.
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
            
            
            @IBOutlet weak var name: UITextField!
            @IBOutlet weak var bearcatID: UITextField!
            @IBOutlet weak var password: UITextField!
            
            // Validations and addition of user to the database.
            @IBAction func doneButton(_ sender: Any) {
                
                let username = name.text!
                let userpwd = password.text!
                let userID = bearcatID.text!
                
                if((username.isEmpty) || (userpwd.isEmpty) ||  (userID.isEmpty))
                    
                {
                    // Display alert message
                    displayMyAlertMessage(userMessage: "All fields are required");
                    return;
                    
                }
                
                else if(userID.characters.count != 9)
                {
                    displayMyAlertMessage(userMessage: "Please enter valid Bearcat ID");
                    return;
                }
                else
                {
                    performSegue(withIdentifier: "Done", sender: self)
                    displayMyAlertMessage(userMessage: "Payment Done");
                    
                }
            }
            
            // To display the alert message.
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
