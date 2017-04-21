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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var expiryDate: UITextField!
    @IBOutlet weak var bearcatID: UITextField!
    
    @IBAction func doneButton(_ sender: Any) {
        
        let usercn = cardNumber.text!
        let usercvv = cvv.text!
        let usered = expiryDate.text!
        let userID = bearcatID.text!
        
        if((usercn.isEmpty) || (usercvv.isEmpty) || (usered.isEmpty) || (userID.isEmpty))
            
        {
            // Display alert message
            displayMyAlertMessage(userMessage: "All fields are required");
            return;
            
        }
        else
        {
            performSegue(withIdentifier: "Done", sender: self)
            displayMyAlertMessage(userMessage: "Payment Done");
            
        }
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
