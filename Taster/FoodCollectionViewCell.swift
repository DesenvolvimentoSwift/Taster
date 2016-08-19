//
//  FoodCollectionViewCell.swift
//  pt.fca.Taster
//
//  © 2016 Luis Marcelino e Catarina Silva
//  Desenvolvimento em Swift para iOS
//  FCA - Editora de Informática
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
                let documentsPath = URL(fileURLWithPath: FoodRepository.repository.mediaPath())
                
                let filePath = documentsPath.appendingPathComponent(imageStr, isDirectory: false)
                let path = filePath.path
                
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
