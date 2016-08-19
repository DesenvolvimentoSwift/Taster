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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        refreshViews()
        
//        if let filePath = NSBundle.mainBundle().pathForResource("cup", ofType: "mp3") {
//            myPlayer = try? AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: filePath))
//        }
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
            let documentsPath = URL(fileURLWithPath: FoodRepository.repository.mediaPath())
            
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
    
}
