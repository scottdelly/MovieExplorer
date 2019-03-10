//
//  MovieDetailImagesCell.swift
//  MovieExplorer
//
//  Created by Scott Delly on 3/8/19.
//  Copyright © 2019 SD. All rights reserved.
//

import UIKit

protocol MovieDetailImagesCellDelegate: class {
    func buttonPosterTUIAction(_ sender: UIButton)
}

class MovieDetailImagesCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backdropImage: UIImageView!

    @IBOutlet weak var buttonPoster: UIButton!

    weak var delegate: MovieDetailImagesCellDelegate?


    override func awakeFromNib() {
        self.posterImage.layer.shouldRasterize = true
        self.posterImage.layer.rasterizationScale = UIScreen.main.scale

        self.backdropImage.layer.shouldRasterize = true
        self.backdropImage.layer.rasterizationScale = UIScreen.main.scale
                self.posterImage.layer.masksToBounds = true
                self.posterImage.layer.cornerRadius = 4
        super.awakeFromNib()
    }
    @IBAction func buttonPosterTUIAction(_ sender: UIButton) {
        self.delegate?.buttonPosterTUIAction(sender)
    }

}
