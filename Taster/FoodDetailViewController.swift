//
//  FoodDetailViewController.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
//

import UIKit
import AVFoundation
import Social

class FoodDetailViewController: UIViewController, AVAudioPlayerDelegate {
    
    var food:Food?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var star1Image: UIImageView!
    @IBOutlet weak var star2Image: UIImageView!
    @IBOutlet weak var star3Image: UIImageView!
    @IBOutlet weak var star4Image: UIImageView!
    @IBOutlet weak var star5Image: UIImageView!
    
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    
    // Código para a secção 6.3
    var myPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        refreshViews()
        
        /////////////////////////////////
        //
        // Código para a secção 6.3
        
        if let filePath = Bundle.main.path(forResource: "cup", ofType: "mp3") {
            myPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: filePath))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshViews() {
        if let imagePath = self.food?.mediaFile {
            let documentsPath = URL(fileURLWithPath: FoodRepository.mediaPath())
            
            let filePath = documentsPath.appendingPathComponent(imagePath, isDirectory: false)
            self.imageView.image = UIImage(named: filePath.path)
        }
        else {
            self.imageView.image = UIImage(named: "dish_light")
        }
        self.nameLabel.text = self.food?.name
        self.localLabel.text = self.food?.local
        self.descriptionLable.text = self.food?.foodDescription
        self.title = self.food?.name
        
        self.star1Image.image = UIImage(named: "star")
        self.star2Image.image = UIImage(named: "star")
        self.star3Image.image = UIImage(named: "star")
        self.star4Image.image = UIImage(named: "star")
        self.star5Image.image = UIImage(named: "star")
        if let rating = self.food?.rating {
            if rating > 0 {
                self.star1Image.image = UIImage(named: "star_yellow")
            }
            if rating > 1 {
                self.star2Image.image = UIImage(named: "star_yellow")
            }
            if rating > 2 {
                self.star3Image.image = UIImage(named: "star_yellow")
            }
            if rating > 3 {
                self.star4Image.image = UIImage(named: "star_yellow")
            }
            if rating > 4 {
                self.star5Image.image = UIImage(named: "star_yellow")
            }
        }
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        if let date = self.food?.updated_at {
            self.dateLabel.text = formater.string(from: date as Date)
        }
        
        if self.food != nil {
            self.favouriteButton.image = self.food!.favourite ? UIImage(named: "heart_filled") : UIImage(named: "heart")
        }
    }
    
    @IBAction func favouriteAction(_ sender: AnyObject) {
        if self.food != nil {
            self.food!.favourite = !self.food!.favourite
            self.favouriteButton.image = self.food!.favourite ? UIImage(named: "heart_filled") : UIImage(named: "heart")
            
            /////////////////////////////////
            //
            // Código para a secção 6.3
            
            myPlayer?.play()

        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ShowLocationViewController {
            //controller.location = self.food?.location
            //controller.name = self.food?.name
            controller.food = food
        }
        else if let controller = segue.destination as? FoodInsertViewController {
            controller.food = self.food
        }

    }
    
    /////////////////////////////////
    //
    // Código para a secção 8.3
    
    @IBAction func shareOnSocialNet(_ sender: AnyObject) {
        /*
        let actionSheet = UIAlertController(title: "", message: "Share your food", preferredStyle: UIAlertControllerStyle.actionSheet)
        let facebookAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.default) { (action) -> Void in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                if let facebookVC = SLComposeViewController(forServiceType:
                    SLServiceTypeFacebook) {
                    // Com conta ativa
                    if let name = self.nameLabel.text {
                        facebookVC.setInitialText("Nice food: \(name)")
                    }
                    self.present(facebookVC, animated: true, completion: nil)
                }
            } else {
                // Sem conta ativa
                self.sharingError(message: "Your must first log on to your Facebook account.")
            }
        }
        let twitterAction = UIAlertAction(title: "Share on Twitter", style: UIAlertActionStyle.default) { (action) -> Void in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                if let twitterVC = SLComposeViewController(forServiceType:SLServiceTypeTwitter) {
                    if let name = self.nameLabel.text {
                        twitterVC.setInitialText("Nice food: \(name)")
                    }
                    self.present(twitterVC, animated: true, completion: nil)
                }
            } else {
                // Sem conta ativa
                self.sharingError(message: "Your must first log on to your Twitter account.")
            }
        }
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel) { (action) -> Void in
        }
        actionSheet.addAction(facebookAction)
        actionSheet.addAction(twitterAction)
        actionSheet.addAction(dismissAction)
        present(actionSheet, animated: true, completion: nil)
         */
        guard let name = nameLabel.text else {
            sharingError(message: "Food has no name")
            return
        }
        guard let image = imageView.image else {
            sharingError(message: "Food has no image")
            return
        }
        let viewController = UIActivityViewController(activityItems: [name, image], applicationActivities: nil)
        present(viewController, animated: true, completion: nil)
    }
    
    func sharingError (message:String) -> Void {
        let alert = UIAlertController(title: "Sharing error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated:  true, completion:  nil)
    }
}
