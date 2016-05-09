//
//  ChooseDeleteViewController.swift
//  QuickDial
//
//  Created by Kero on 2016/5/9.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

class ChooseDeleteViewController: UIViewController {

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func backToMain(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func deleteThisEntry(sender: UIButton) {
        nameArray[selectedNumber] = ""
        phoneArray[selectedNumber] = ""
        NSUserDefaults.standardUserDefaults().setObject(nameArray, forKey: "contactName")
        NSUserDefaults.standardUserDefaults().setObject(phoneArray, forKey: "contactPhone")
        settingName = nil
        settingPhone = nil
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    
    @IBAction func editThisEntry(sender: UIButton) {
        settingName = nameArray[selectedNumber]
        settingPhone = phoneArray[selectedNumber]
        self.performSegueWithIdentifier("edit", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorArray[selectedNumber]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
