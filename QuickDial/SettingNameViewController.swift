//
//  SettingNameViewController.swift
//  QuickDial
//
//  Created by Kero on 2016/5/9.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class SettingNameViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!

    @IBAction func backToMain(sender: UIButton) {
        if settingName != nil {
            settingName = nil
            settingPhone = nil
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = colorArray[selectedNumber]
        nameTextField.autocorrectionType = UITextAutocorrectionType.No
        nameTextField.returnKeyType = UIReturnKeyType.Next //把鍵盤上的return鍵換成next
        nameTextField.becomeFirstResponder()
        
        isSetting = true
        
        if settingName != nil {
            nameTextField.text = settingName
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if nameTextField.text == ""{
            let myAlert = UIAlertController(title: "Ooops!", message: "Please enter a contact name", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Done", style: .Default, handler: nil)
            myAlert.addAction(action)
            self.presentViewController(myAlert, animated: true, completion: nil)
        }else{
            settingName = nameTextField.text
            self.performSegueWithIdentifier("showSettingNumber", sender: nil)
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
