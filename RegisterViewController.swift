//
//  RegisterViewController.swift
//  BCO
//
//  Created by Mamidala,Sri Sai Ram Kumar on 4/2/17.
//  Copyright © 2017 Mamidala,Sri Sai Ram Kumar. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBAction func registerButton(_ sender: Any) {
        let userfn = firstName.text!
        let userln = lastName.text!
        let userem = email.text!
        let userps = password.text!
        let usercps = confirmPassword.text!
        
        if((userem.isEmpty) || (userps.isEmpty) || (usercps.isEmpty) || (userfn.isEmpty) || (userln.isEmpty))
            
        {
            // Display alert message
            displayMyAlertMessage(userMessage: "All fields are required");
            return;
            
        }
        //Check if passwords match
        if(userps != usercps)
        {
            // Display an alert message
            
            displayMyAlertMessage(userMessage: "Passwords do not match");
            return;
        }
        
        //let customer = PFUser()
        let customer = PFObject(className: "Customer")
        //let customer = PFQuery(className: "Customer")
        customer["firstName"] = userfn
        customer["lastName"] = userln
        customer["email"] = userem
        customer["password"] = userps
        customer.saveInBackground(block: { (success, error) -> Void in
            
            if success
            {
                self.displayMyAlertMessage(userMessage: "Registered Successfully.")
            }
            else
            {
                print(error)
            }
        })
    }
    
    
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
