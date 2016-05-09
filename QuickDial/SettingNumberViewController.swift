//
//  SettingNumberViewController.swift
//  QuickDial
//
//  Created by Kero on 2016/5/9.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class SettingNumberViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBAction func backToSettingName(sender: UIButton) {
        let vc = self.navigationController?.childViewControllers[1]
        self.navigationController?.popToViewController(vc!, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorArray[selectedNumber]
        phoneTextField.becomeFirstResponder()
        phoneTextField.returnKeyType = UIReturnKeyType.Done
        if settingPhone != nil {
            phoneTextField.text = settingPhone
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if phoneTextField.text == ""{
            let myAlert = UIAlertController(title: "Ooops!", message: "Please enter a phone number", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Done", style: .Default, handler: nil)
            myAlert.addAction(action)
            self.presentViewController(myAlert, animated: true, completion: nil)
        }else{
            settingPhone = phoneTextField.text
            //self.performSegueWithIdentifier("showSettingNumber", sender: nil)
            nameArray[selectedNumber] = settingName!
            phoneArray[selectedNumber] = settingPhone!
            NSUserDefaults.standardUserDefaults().setObject(nameArray, forKey: "contactName")
            NSUserDefaults.standardUserDefaults().setObject(phoneArray, forKey: "contactPhone")
            isSetting = false
            settingName = nil
            settingPhone = nil
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
