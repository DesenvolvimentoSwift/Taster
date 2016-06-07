//
//  FoodTableViewCell.swift
//  Taster
//
//  Created by Luis Marcelino on 16/02/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import UIKit


class FoodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    
    var food:Food? {
        didSet {
            self.foodNameLabel.text = self.food?.name
            self.locationLabel.text = self.food?.local
            if let imageFileName = self.food?.mediaFile {
                let documentsPath = NSURL(fileURLWithPath: FoodRepository.repository.mediaPath())
                
                let filePath = documentsPath.URLByAppendingPathComponent(imageFileName, isDirectory: false)
                let path = filePath.path!
                
                if let image = UIImage(named: path) {
                    self.backgroundImageView.image = image
                }
                else {
                    self.backgroundImageView.image = nil
                }
            }
            else {
                self.backgroundImageView.image = nil
            }
            if self.food?.favourite == true {
                self.favouriteImageView.image = UIImage(named: "heart_filled")
            }
            else {
                self.favouriteImageView.image = UIImage(named: "heart")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
