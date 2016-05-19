//
//  FoodDetailViewController.swift
//  Taster
//
//  Created by Luis Marcelino on 23/10/15.
//  Copyright © 2015 Empresa Imaginada. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshViews() {
        //if let imagePath = self.food?.mediaFiles?.last {
        if let imagePath = self.food?.mediaFile {
            let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
            
            let filePath = documentsPath.URLByAppendingPathComponent(imagePath, isDirectory: false)
            let path = filePath.path!
            print("FooddetailVC vai buscar a \(path)")
            //self.imageView.image = UIImage(named: imagePath)
            self.imageView.image = UIImage(named: path)
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
        let formater = NSDateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        if let date = self.food?.updated_at {
            self.dateLabel.text = formater.stringFromDate(date)
        }
        
        if self.food != nil {
            self.favouriteButton.image = self.food!.favourite ? UIImage(named: "heart_filled") : UIImage(named: "heart")
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
    
    
    
    @IBAction func favouriteAction(sender: AnyObject) {
        if self.food != nil {
            self.food!.favourite = !self.food!.favourite
            self.favouriteButton.image = self.food!.favourite ? UIImage(named: "heart_filled") : UIImage(named: "heart")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? ShowLocationViewController {
            //controller.location = self.food?.location
            //controller.name = self.food?.name
            controller.food = food
        }
    }
}