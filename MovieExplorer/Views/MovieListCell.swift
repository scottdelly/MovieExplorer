//
//  MovieListCell.swift
//  MovieExplorer
//
//  Created by Scott Delly on 3/8/19.
//  Copyright © 2019 SD. All rights reserved.
//

import UIKit

class MovieListCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backdropImage: UIImageView!


    override func awakeFromNib() {
        self.posterImage.layer.shouldRasterize = true
        self.posterImage.layer.rasterizationScale = UIScreen.main.scale

        self.backdropImage.layer.shouldRasterize = true
        self.backdropImage.layer.rasterizationScale = UIScreen.main.scale
//        self.posterImage.layer.masksToBounds = true
//        self.posterImage.layer.cornerRadius = 4
        super.awakeFromNib()
    }
}
