//
//  FoodInsertViewController.swift
//  Taster
//
//  Created by Luis Marcelino on 23/10/15.
//  Copyright © 2015 Empresa Imaginada. All rights reserved.
//

import UIKit

class FoodInsertViewController: UIViewController, UITextFieldDelegate {

    var food:Food?

    var rate:Int = 0 {
        didSet {
            self.star1Button.selected = false
            self.star2Button.selected = false
            self.star3Button.selected = false
            self.star4Button.selected = false
            self.star5Button.selected = false

            if rate >= 1 {
                self.star1Button.selected = true
            }
            if rate >= 2 {
                self.star2Button.selected = true
            }
            if rate >= 3 {
                self.star3Button.selected = true
            }
            if rate >= 4 {
                self.star4Button.selected = true
            }
            if rate >= 5 {
                self.star5Button.selected = true
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var localTextField: UITextField!
    
    @IBOutlet weak var star1Button: UIButton!
    @IBOutlet weak var star2Button: UIButton!
    @IBOutlet weak var star3Button: UIButton!
    @IBOutlet weak var star4Button: UIButton!
    @IBOutlet weak var star5Button: UIButton!
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    var activeField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.registerForKeyboardNotifications()
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

    @IBAction func starAction(sender: UIButton) {
        if sender == star1Button {
            self.rate = 1
        }
        else if sender == star2Button {
            self.rate = 2
        }
        else if sender == star3Button {
            self.rate = 3
        }
        else if sender == star4Button {
            self.rate = 4
        }
        else if sender == star5Button {
            self.rate = 5
        }
    }
    
    @IBAction func favouriteAction(sender: AnyObject) {
        self.favouriteButton.selected = !self.favouriteButton.selected
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        if self.food == nil {
            self.food = FoodRepository.createFoodWithName(self.nameTextField.text! , local: self.localTextField.text!)
        }
        self.food?.favourite = self.favouriteButton.selected
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func pictureAction(sender: AnyObject) {
        
    }
    
    // From Apple Documentation
    // https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html
    
    // Call this method somewhere in your view controller setup code.
    func registerForKeyboardNotifications () {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown (notification: NSNotification) {
        
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue.size
        
        let insets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, keyboardSize!.height, 0)
        
        self.scrollView.contentInset = insets
        self.scrollView.scrollIndicatorInsets = insets
        
        
    }
    
    func keyboardWillBeHidden (notification: NSNotification) {
        
        self.scrollView.contentInset = UIEdgeInsetsZero
        self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
        
        
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        activeField = textField;
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        activeField = nil;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
        }
        if textField == localTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
