//
//  SpiritCollectionViewCell.swift
//  NasaAPI-Turker
//
//  Created by Gülşah Alan on 29.09.2021.
//

import UIKit

class SpiritCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet private weak var roverPhotos: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureRoverOutlets(on model: Rover) {
        roverPhotos.fetchImage(from: "\(model.img_src ?? "")")
       
    }
    
}
