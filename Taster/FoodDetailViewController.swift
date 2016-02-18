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
        if let imagePath = self.food?.mediaFiles?.last {
            self.imageView.image = UIImage(named: imagePath)
        }
        else {
            self.imageView.image = UIImage(named: "dish_light")
        }
        self.nameLabel.text = self.food?.name
        self.localLabel.text = self.food?.local
        self.descriptionLable.text = self.food?.description
        self.title = self.food?.name

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
    }
}
