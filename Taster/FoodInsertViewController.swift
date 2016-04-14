//
//  FoodInsertViewController.swift
//  Taster
//
//  Copyright © 2015 Empresa Imaginada. All rights reserved.
//

import UIKit
import CoreLocation

class FoodInsertViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, writeValueBackDelegate {

    var food:Food?
    var location:CLLocationCoordinate2D?

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
    var newImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.registerForKeyboardNotifications()
        
        updateFoodView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateFoodView() {
        self.nameTextField.text = food?.name
        if let imageName = food?.mediaFiles?.first {
            self.imageView?.image = UIImage(named: imageName)
        }
        else {
            
        }
        self.descriptionTextView.text = food?.foodDescription
        self.rate = food?.rating ?? 0
        self.favouriteButton.selected = food?.favourite ?? false
        self.localTextField.text = food?.local
        self.ingredientsLabel.text = food?.ingredientesString()
        
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
        self.food?.rating = self.rate
        self.food?.foodDescription = self.descriptionTextView.text
        self.food?.location = self.location
        
        // Save image to path
        if let image = self.newImage {
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let timestamp = Int(NSDate().timeIntervalSinceReferenceDate)
            let filePath = "\(paths[0])/image-\(timestamp).png"
            UIImagePNGRepresentation(image)?.writeToFile(filePath, atomically: true)
            self.food?.mediaFiles = [filePath]
        }
        // Save location
        if let local = self.localTextField.text {
            self.food?.local = local
        }
        
//        if let loc = location {
//            self.food?.location = loc
//        }

        self.food?.location = location
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func pictureAction(sender: AnyObject) {
        let alert = UIAlertController(title: "Origem da Imagem", message: nil, preferredStyle: .ActionSheet)
        
        if UIImagePickerController.isCameraDeviceAvailable(.Rear) {
            alert.addAction(UIAlertAction(title: "Câmara", style: .Default, handler: { (action) -> Void in
                let cameraUI = UIImagePickerController()
                cameraUI.sourceType = UIImagePickerControllerSourceType.Camera
                cameraUI.delegate = self
                self.presentViewController(cameraUI, animated: true, completion: nil)
            }))
        }
        alert.addAction(UIAlertAction(title: "Galeria", style: .Default, handler: { (action) -> Void in
            let galleryUI = UIImagePickerController()
            galleryUI.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.PhotoLibrary)!
            galleryUI.delegate = self
            self.presentViewController(galleryUI, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil))

        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // From Apple Documentation
    // https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html
    
    // Call this method somewhere in your view controller setup code.
    func registerForKeyboardNotifications () {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FoodInsertViewController.keyboardWasShown(_:)), name: UIKeyboardDidShowNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FoodInsertViewController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
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
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController,
                                 didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
            self.newImage = image
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func writeValueBack(value: CLLocationCoordinate2D?) {
        location = value
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? PickLocationViewController {
            controller.location = self.location
            print(self.location)
            controller.delegate = self
        }
    }
}
