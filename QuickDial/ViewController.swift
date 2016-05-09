//
//  ViewController.swift
//  QuickDial
//
//  Created by Kero on 2016/5/3.
//  Copyright © 2016年 Kero. All rights reserved.
//

import UIKit

var colorArray:[UIColor]!
var selectedNumber:Int = -1
var nameArray = ["","","","",""]
var phoneArray = ["","","","",""]
var isSetting = false
var settingName:String?
var settingPhone:String?

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: BigLabelButton!
    @IBOutlet weak var button2: BigLabelButton!
    @IBOutlet weak var button3: BigLabelButton!
    @IBOutlet weak var button4: BigLabelButton!
    @IBOutlet weak var button5: BigLabelButton!
    @IBAction func buttonTouched1(sender: BigLabelButton) {
        let buttonNumber = sender.tag - 100
        buttonArray[buttonNumber].backgroundColor = colorPressArray[buttonNumber]
        buttonArray[buttonNumber].bigLabel.textColor = colorPressArray[5]
    }

    @IBAction func PressEnded(sender: BigLabelButton) {
        let buttonNumber = sender.tag - 100
        buttonArray[buttonNumber].backgroundColor = colorArray[buttonNumber]
        buttonArray[buttonNumber].bigLabel.textColor = colorArray[5]
        let thisName:String? = nameArray[buttonNumber]
        let thisNumber:String? = phoneArray[buttonNumber]
        if thisName != nil{
            if UIApplication.sharedApplication().canOpenURL(NSURL(string:"tel://\(thisNumber!)")!) == true {
                let url = NSURL(string: "tel://\(thisNumber!)")
                UIApplication.sharedApplication().openURL(url!)
            }
        }
    }

    @IBAction func outsideEnded(sender: BigLabelButton) {
        let buttonNumber = sender.tag - 100
        buttonArray[buttonNumber].backgroundColor = colorArray[buttonNumber]
        buttonArray[buttonNumber].bigLabel.textColor = colorArray[5]

    }
    
    override func viewWillAppear(animated: Bool) {
        isSetting = false
        settingName = nil
        settingPhone = nil
        for var i=0 ; i<buttonArray.count ; i++ {
            buttonArray[i].backgroundColor = colorArray[i]
            buttonArray[i].bigLabel.textColor = colorArray[5]
        }
        var isEmpty = true
        
        for var i = 1 ; i < 5 ; i++ {
            if nameArray[i] != "" {
                isEmpty = false
            }
        }
        
        if isEmpty == true {
            for var i = 0 ; i < 5 ; i++ {
                buttonArray[i].bigLabel.text = ""
                buttonArray[i].bigLabel.hidden = true
            }
            buttonArray[1].bigLabel.text = "Long Press "
            buttonArray[1].bigLabel.hidden = false
        }else{
            for var i = 0 ; i < 5 ; i++ {
                if nameArray[i] != "" {
                    buttonArray[i].bigLabel.text = nameArray[i]
                    buttonArray[i].bigLabel.hidden = false
                }else{
                    buttonArray[i].bigLabel.hidden = true
                }
                
            }
        }
        
    }
    
    var buttonArray:[BigLabelButton]!
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    
    var colorPressArray:[UIColor]!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWidth = view.frame.size.width
        viewHeight = view.frame.size.height
        
        //setting up BigLabelButton Sizes
        buttonArray = [button1,button2,button3,button4,button5]
        for var i=0 ; i<buttonArray.count ; i++ {
            
            //Generate every button
            buttonArray[i].bigLabel.frame = CGRectMake(28, 0, viewWidth-38, viewHeight/5)
            buttonArray[i].bigLabel.font = UIFont(name: "Arial-BoldMT",size: 45*(viewHeight/600))
            
            //Generate Long Press Gesture Recognizer
            let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("longPress:")) //加上冒號是找有參數的longPress方法
            longPressGestureRecognizer.minimumPressDuration = 1.5
            buttonArray[i].addGestureRecognizer(longPressGestureRecognizer)
            
        }
        //Setting BigLabelButton Colors
            colorArray=[
                UIColor(red: 232/255, green: 68/255, blue: 32/255, alpha: 1),
                UIColor(red: 250/255, green: 168/255, blue: 8/255, alpha: 1),
                UIColor(red: 2/255, green: 160/255, blue: 131/255, alpha: 1),
                UIColor(red: 9/255, green: 171/255, blue: 219/255, alpha: 1),
                UIColor(red: 3/255, green: 127/255, blue: 208/255, alpha: 1),
                UIColor.whiteColor()
            ]
            
            colorPressArray=[
                UIColor(red: 202/255, green: 38/255, blue: 1/255, alpha: 1),
                UIColor(red: 220/255, green: 138/255, blue: 0, alpha: 1),
                UIColor(red: 0, green: 130/255, blue: 101/255, alpha: 1),
                UIColor(red: 0, green: 141/255, blue: 189/255, alpha: 1),
                UIColor(red: 0, green: 97/255, blue: 178/255, alpha: 1),
                UIColor.grayColor()
            
            ]
        
        if NSUserDefaults.standardUserDefaults().objectForKey("contactName") != nil{
            nameArray.removeAll(keepCapacity: true)
            nameArray = NSUserDefaults.standardUserDefaults().objectForKey("contactName") as! Array
        }
        
            
        if NSUserDefaults.standardUserDefaults().objectForKey("contactPhone") != nil{
            phoneArray.removeAll(keepCapacity: true)
            phoneArray = NSUserDefaults.standardUserDefaults().objectForKey("contactPhone") as! Array
        }
    
    }
    
    //get input from Long Press Gesture Recognizer
    func longPress(sender:UILongPressGestureRecognizer){
        if sender.state == .Began{ //剛按下去的時候
            selectedNumber = sender.view!.tag - 100
            if nameArray[selectedNumber] != "" {
                self.performSegueWithIdentifier("showChooseDelete", sender: nil)
            }else{
                self.performSegueWithIdentifier("showSettingName", sender: nil)
            }
            //self.performSegueWithIdentifier("showSettingName", sender: nil)
        }
    }

    

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class BigLabelButton:UIButton{
    
    let bigLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bigLabel.text = "+ Long Press"
        bigLabel.textColor = UIColor.whiteColor()
        bigLabel.shadowColor = UIColor.blackColor()
        self.addSubview(bigLabel)
    }
}
