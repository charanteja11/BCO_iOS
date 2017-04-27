        //
        //  CartViewController.swift
        //  BCO
        //
        //  Created by Mamidala,Sri Sai Ram Kumar on 4/2/17.
        //  Copyright © 2017 Mamidala,Sri Sai Ram Kumar. All rights reserved.
        //

        import UIKit
        import Parse

        class CartViewController: UIViewController, UITextFieldDelegate {

            @IBOutlet weak var itemNameLBL: UILabel!
            @IBOutlet weak var priceLBL: UILabel!

            @IBOutlet weak var quantityTF: UITextField!
            @IBOutlet weak var pickupTime: UITextField!
            
            @IBOutlet weak var timePicker: UIDatePicker!
            //@IBOutlet weak var quantityPicker: UIPickerView!
            //@IBOutlet weak var timePicker: UIPickerView!
           
           // Date picker converted to time.
            @IBAction func timePickerButton(_ sender: Any) {
                
                let formatter = DateFormatter()
                formatter.dateFormat = "hh:mm a"
                pickupTime.text = formatter.string(from: timePicker.date)
            }
            
            
            var item:String = ""
            
            // Picker view of components.
            func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                
                
                
                if pickerView == timePicker {
                    
                    self.pickupTime.text = String(describing: self.timePicker)
                    
                    self.timePicker.isHidden = true
                    
                }
                
            }
            
            
            // Picker comes on editing the text field.
            func textFieldDidBeginEditing(_ textField: UITextField) {
           
                if (textField == self.pickupTime) {
                
               self.timePicker.isHidden = false
           }
                
            }

            
            /*
        //    var quantity = ["1", "2", "3", "4", "5"]
        //    
        //    var timeInMin = ["10", "20", "30", "40", "50", "60"]
            
            
            
            
            func numberOfComponents(in pickerView: UIPickerView) -> Int {
                
                return 3
                
            }
            
            
            
            func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                
                
                
        //        var countrows: Int = quantity.count
        //        
        //        if pickerView == timePicker {
        //            
        //            countrows = self.timeInMin.count
        //            
        //        }
        //        
                return 10
                
            }
            
            
            
            func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                
                
                
        //        if pickerView == quantityPicker {
        //            
        //            let titleRow = quantity[row]
        //            
        //            return titleRow
        //            
        //        }
        //            
        //        else if pickerView == timePicker {
        //            
        //            let titleRow = timeInMin[row]
        //            
        //            return titleRow
        //            
        //        }
                
                return ""
                
            }
            
            
            
            func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                
                
                
                if pickerView == timePicker {
                    
                    self.pickupTime.text = String(describing: self.timePicker)
                    
                    self.timePicker.isHidden = true
                    
                }
                    
        //        else if pickerView == timePicker {
        //            
        //            self.pickupTime.text = self.timeInMin[row]
        //            
        //            self.timePicker.isHidden = true
        //            
        //        }
                
            }
            
            
            
            func textFieldDidBeginEditing(_ textField: UITextField) {
                
                
                
                if (textField == self.quantityTF) {
                    
                    self.timePicker.isHidden = false
                    
                }
                    
        //        else if (textField == self.pickupTime) {
        //            
        //            self.timePicker.isHidden = false
        //            
        //        }
                
            }
            */
            //let datePicker = UIDatePicker()
            
            
            
           
            
            
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                // To dismiss the keyboard on tap.
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(CartViewController.dismissKeyboard))
                view.addGestureRecognizer(tap)
                
                //createdatePicker()
                // Selecting the respective menu item from previous page.
                self.item = (UIApplication.shared.delegate as! AppDelegate).item
                print(self.item+"1")
                
                // Selecting the respective menu item from previous page.
                let query = PFQuery(className: (UIApplication.shared.delegate as! AppDelegate).selectedItem)
                
                //query.whereKeyExists("menu_name")
                // Selecting data from the respective menu item.
                query.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
                    
                    if error == nil
                    {
                        //print(objects!)
                        for obj in objects!
                        {
                            //print(obj["menu_name"]!)
                            if (obj["menu_name"] as! String) == self.item
                            {
                                self.itemNameLBL.text = (obj["menu_name"] as! String)
                                //print(obj["menu_price"])
                                DispatchQueue.main.async
                                {
                                    self.priceLBL.text = String(obj["menu_price"] as! Int)

                                }
                            //print(self.Menu)
                            }
                        }
                        //self.menuTable.reloadData()
                        //print(self.Menu)
                    }
                   
                    
                })
                
                // Retrieve the latest pickup time.
                let query1 = PFQuery(className: "Cart")
                
                query1.findObjectsInBackground(block: { (objects : [PFObject]?, error: Error?) -> Void in
                    
                    if error == nil
                    {
                        
                        for obj in objects!
                        {
                            self.pickupTime.text = String(obj["pickupTime"] as! String)
                        }
                    }
                    
                })

                
                // Do any additional setup after loading the view.
            }

            
        //    func createdatePicker()
        //    {
        //        let toolbar = UIToolbar()
        //        toolbar.sizeToFit()
        //        
        //        let doneButton = UIBarButtonItem(barButtonSystemItem : .done, target : nil, action : #selector(donePressed))
        //        toolbar.setItems([doneButton], animated: false)
        //        
        //        pickupTime.inputAccessoryView = toolbar
        //        pickupTime.inputView = datePicker
        //    }
        //    
        //    func donePressed()
        //    {
        //        pickupTime.text = "\(datePicker.date)"
        //        self.view.endEditing(true)
        //    }
            
            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
            
            // Addition of item to the cart.
            @IBAction func addToCartBTN(_ sender: Any) {
                
        //        let dateString = "Thu, 22 Oct 2015 07:45:17 +0000"
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        //        dateFormatter.locale = Locale.init(identifier: "en_GB")
        //        
        //        let dateObj = dateFormatter.date(from: pickupTime.text!)
                
                
                if(pickupTime.text!.isEmpty || quantityTF.text!.isEmpty)
                {
                    self.displayMyAlertMessage(userMessage: "All fields are required.")
                }
                else if(Int(quantityTF.text!)! > 10 )
                {
                    self.displayMyAlertMessage(userMessage: "Item quantity should not exceed 10.")
                }
                else
                {
                    let cartitem = CartItems(item_name: itemNameLBL.text!, quantity: Int(quantityTF.text!)!, price: Int(priceLBL.text!)!, pickupTime : pickupTime.text!)
                    //cartitem.item_name = "qwerty"
                    cartitem.saveInBackground(block: { (success, error) -> Void in
                        
                        if success
                        {
                            self.displayMyAlertMessage(userMessage: "Added Successfully.")
                        }
                        else
                        {
                            print(error!)
                        }
                    })
                    

                }
                
            }
            
            // Unwind segue to go back to cart.
            @IBAction func Cartunwind(unwindSegue:UIStoryboardSegue)
            {
                
                _ = unwindSegue.source as! PaymentViewController
                
            }
            
            // Alert function to display messages.
            func displayMyAlertMessage(userMessage:String)
                
            {
                let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
                let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
                myAlert.addAction(okAction);
                self.present(myAlert, animated:true, completion:nil);
            }
            
            // Function to implement keyboard dismissal.
            func dismissKeyboard()
            {
                view.endEditing(true)
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
