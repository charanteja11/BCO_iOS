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
                
                // To dismiss the keyboard on tap.
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(RegisterViewController.dismissKeyboard))
                view.addGestureRecognizer(tap)
                
                // Do any additional setup after loading the view.
                
                // Styling of the page.
                self.firstName.layer.borderColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1).cgColor;
                self.firstName.layer.borderWidth = CGFloat(Float(1.0));
                self.firstName.layer.cornerRadius = CGFloat(Float(5.0));
                self.lastName.layer.borderColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1).cgColor;
                self.lastName.layer.borderWidth = CGFloat(Float(1.0));
                self.lastName.layer.cornerRadius = CGFloat(Float(5.0));
                self.email.layer.borderColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1).cgColor;
                self.email.layer.borderWidth = CGFloat(Float(1.0));
                self.email.layer.cornerRadius = CGFloat(Float(5.0));
                self.password.layer.borderColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1).cgColor;
                self.password.layer.borderWidth = CGFloat(Float(1.0));
                self.password.layer.cornerRadius = CGFloat(Float(5.0));
                self.confirmPassword.layer.borderColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1).cgColor;
                self.confirmPassword.layer.borderWidth = CGFloat(Float(1.0));
                self.confirmPassword.layer.cornerRadius = CGFloat(Float(5.0));

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
            
            @IBOutlet weak var firstName: UITextField!
            @IBOutlet weak var lastName: UITextField!

            @IBOutlet weak var email: UITextField!
            @IBOutlet weak var password: UITextField!
            @IBOutlet weak var confirmPassword: UITextField!
            
            // Validation and insertion the data of user onto database.
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
                        print(error!)
                    }
                })
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
