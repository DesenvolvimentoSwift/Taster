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
            if let imageStr = self.food?.mediaFile {
                let documentsPath = NSURL(fileURLWithPath: FoodRepository.repository.mediaPath())
                
                let filePath = documentsPath.URLByAppendingPathComponent(imageStr, isDirectory: false)
                let path = filePath.path!
                
                if let image = UIImage(named: path) {
                    self.imageView.image = image
                }
                else {
                    self.imageView.image = nil
                }
            }
            else {
                self.imageView.image = nil
            }
        }
    }
    
}
