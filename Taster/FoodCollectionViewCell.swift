//
//  FoodCollectionViewCell.swift
//  Taster
//
//  Created by Luis Marcelino on 16/02/16.
//  Copyright © 2016 Empresa Imaginada. All rights reserved.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var food:Food? {
        didSet {
            self.nameLabel.text = self.food?.name
            self.locationLabel.text = self.food?.local
            if let imageStr = self.food?.mediaFiles?.first {
                if let image = UIImage(named: imageStr) {
                    self.imageView.image = image
                }
                else {
                    self.imageView.image = nil
                }
            }
            else {
//                self.imageView.image = UIImage(named: "")
                self.imageView.image = nil
            }
        }
    }
    
}
