//
//  CollectionViewCell.swift
//  BottleRocketTest
//
//  Created by Vlastimir Radojevic on 3/1/20.
//  Copyright © 2020 Vlastimir. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var restaurant: Restaurant? {
        didSet {
           updateView()
        }
    }
    
    fileprivate func updateView() {
        
        if let imageUrl = restaurant?.backgroundImageURL {
            backgroundImage.loadImage(fromURL: imageUrl)
        }
        nameLabel.text = restaurant?.name
        categoryLabel.text = restaurant?.category
    }
    
    
    override func prepareForReuse() {
        
        nameLabel.text = ""
        categoryLabel.text = ""
        backgroundImage.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
