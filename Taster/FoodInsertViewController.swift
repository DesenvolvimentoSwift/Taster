//
//  FoodInsertViewController.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import UIKit
import CoreLocation

class FoodInsertViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, writeValueBackDelegate {
    
    var food:Food?
    
    var location:CLLocationCoordinate2D?
    
    var rate:Int = 0 {
        didSet {
            self.star1Button.isSelected = false
            self.star2Button.isSelected = false
            self.star3Button.isSelected = false
            self.star4Button.isSelected = false
            self.star5Button.isSelected = false
            
            if rate >= 1 {
                self.star1Button.isSelected = true
            }
            if rate >= 2 {
                self.star2Button.isSelected = true
            }
            if rate >= 3 {
                self.star3Button.isSelected = true
            }
            if rate >= 4 {
                self.star4Button.isSelected = true
            }
            if rate >= 5 {
                self.star5Button.isSelected = true
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
        
        self.descriptionTextView.text = ""
        
        if self.food != nil {
            updateFoodView()
        }
        
        /////////////////////////////////
        //
        // Código para a secção 6.1.1.1

        // Criar o objeto de reconhecimento de gesto
        let tapRecog = UITapGestureRecognizer(target: self, action: #selector(tapIngredientsAction))
        // Associar o objeto à vista
        ingredientsLabel.addGestureRecognizer(tapRecog)
        // Permitir a interação com a etiqueta
        ingredientsLabel.isUserInteractionEnabled = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateFoodView() {
        self.title = self.food?.name
        self.nameTextField.text = self.food?.name
        self.descriptionTextView.text = self.food?.foodDescription
        self.localTextField.text = self.food?.local
        self.rate = self.food?.rating ?? 0
        
        if let imagePath = self.food?.mediaFile {
            let documentsPath = URL(fileURLWithPath: FoodRepository.repository.mediaPath())
            
            let filePath = documentsPath.appendingPathComponent(imagePath, isDirectory: false)
            self.imageView.image = UIImage(named: filePath.path)
        }
        else {
            self.imageView.image = UIImage(named: "dish_light")
        }
        
        if self.food != nil {
            self.favouriteButton.isSelected = self.food!.favourite
        }

    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func starAction(_ sender: UIButton) {
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
    
    @IBAction func favouriteAction(_ sender: AnyObject) {
        self.favouriteButton.isSelected = !self.favouriteButton.isSelected
    }
    
    @IBAction func saveAction(_ sender: AnyObject) {
        if self.food == nil {
            self.food = FoodRepository.repository.createFoodWithName(self.nameTextField.text! , local: self.localTextField.text!)
        }
        self.food?.favourite = self.favouriteButton.isSelected
        self.food?.rating = self.rate
        self.food?.foodDescription = self.descriptionTextView.text
        
        // Save image to path
        if let image = self.newImage {
            let timestamp = Int(Date().timeIntervalSinceReferenceDate)
            let imageFileName = "image-\(timestamp).png"
            let filePath = "\(FoodRepository.repository.mediaPath())/\(imageFileName)"
            
            try? UIImagePNGRepresentation(image)?.write(to: URL(fileURLWithPath: filePath), options: [.atomic])
            self.food?.mediaFile = imageFileName
        }
        
        // Save location
        if let local = self.localTextField.text {
            self.food?.local = local
        }
        
        if let loc = location {
            self.food?.location = loc
        } else {
            if let local = food?.local {
                let geocoder = CLGeocoder()
                geocoder.geocodeAddressString(local, completionHandler: { (placemarks, error) in
                    if let coord = placemarks?.first?.location {
                        self.food?.location = coord.coordinate
                        
                    }
                })
                
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pictureAction(_ sender: AnyObject) {
        self.imageView.layer.borderColor = UIColor.white.cgColor
//        UIView.animateWithDuration(3.0) {
        
            // Secção 6.2.1 - Animaçõe de vista
//            self.imageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            
            // Secção 6.2.2 - Animação de camada
//            self.imageView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI/2.0), 1, 0, 0)
        
//        }

        // Secção 6.2.2 - Animação explícita
        let anim = CABasicAnimation(keyPath: "borderWidth")
        anim.fromValue = 0.0
        anim.toValue = 10.0
        anim.duration = 5.0
        self.imageView.layer.add(anim, forKey: "Anima")
        self.imageView.layer.borderWidth = 10.0

        let alert = UIAlertController(title: "Image source", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isCameraDeviceAvailable(.rear) {
            alert.addAction(UIAlertAction(title: "Câmara", style: .default, handler: { (action) -> Void in
                let cameraUI = UIImagePickerController()
                cameraUI.sourceType = UIImagePickerControllerSourceType.camera
                cameraUI.delegate = self
                self.present(cameraUI, animated: true, completion: nil)
            }))
        }
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (action) -> Void in
            let galleryUI = UIImagePickerController()
            galleryUI.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.photoLibrary)!
            galleryUI.delegate = self
            self.present(galleryUI, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) -> Void in
            UIView.animate(withDuration: 3.0) {
                self.imageView.layer.transform = CATransform3DIdentity

                self.imageView.layer.borderWidth = 0.0
            }
            }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // From Apple Documentation
    // https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html
    
    // Call this method somewhere in your view controller setup code.
    func registerForKeyboardNotifications () {
        NotificationCenter.default.addObserver(self, selector: #selector(FoodInsertViewController.keyboardWasShown(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(FoodInsertViewController.keyboardWillBeHidden(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown (_ notification: Notification) {
        
        let info : NSDictionary = (notification as NSNotification).userInfo!
        let keyboardSize = info.object(forKey: UIKeyboardFrameBeginUserInfoKey)?.cgRectValue.size
        
        let insets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, keyboardSize!.height, 0)
        
        self.scrollView.contentInset = insets
        self.scrollView.scrollIndicatorInsets = insets
        
        
    }
    
    func keyboardWillBeHidden (_ notification: Notification) {
        
        self.scrollView.contentInset = UIEdgeInsetsZero
        self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        activeField = textField;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        activeField = nil;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
        }
        if textField == localTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                                 didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
            self.newImage = image
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func writeValueBack(_ value: CLLocationCoordinate2D?) {
        location = value
        let geocoder = CLGeocoder()
        let loc = CLLocation(latitude: location!.latitude, longitude: location!.longitude)
        
        geocoder.reverseGeocodeLocation(loc) { (placemarks, error) in
            self.localTextField.text = placemarks?.first?.locality
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PickLocationViewController {
            controller.location = self.location
            print(self.location)
            controller.delegate = self
        }
    }
    
    func tapIngredientsAction(_ regognizer: UITapGestureRecognizer) {
        // Controlador a mostrar com campo de texto
        let alert = UIAlertController(title: "Ingredients", message: "Lista de ingredientes", preferredStyle: .alert)
        // Configurar o campo de texto
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = self.ingredientsLabel.text
        })
        // Ação quando o utilizador pressiona OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.ingredientsLabel.text = textField.text
        }))
        // Apresenta o controlador
        self.present(alert, animated: true, completion: nil)
    }
}
