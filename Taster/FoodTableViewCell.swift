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
    
    var food:Food? {
        didSet {
            self.foodNameLabel.text = self.food?.name
            self.locationLabel.text = self.food?.local
            if let imageStr = self.food?.mediaFiles?.first {
                if let image = UIImage(named: imageStr) {
                    self.backgroundImageView.image = image
                }
                else {
                    self.backgroundImageView.image = nil
                }
            }
            else {
                //                self.imageView.image = UIImage(named: "")
                self.backgroundImageView.image = nil
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
