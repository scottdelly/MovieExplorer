//
//  MovieDetailVC.swift
//  MovieExplorer
//
//  Created by Scott Delly on 3/8/19.
//  Copyright © 2019 SD. All rights reserved.
//

import UIKit
import Nuke

class MovieDetailVC: UITableViewController {

    var movie: TMDBMovie!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.movie.title
        // Do any additional setup after loading the view.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            //images cell
            let imagesCell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailImagesCell", for: indexPath) as! MovieDetailImagesCell

            var posterRequest = ImageRequest(url: movie.posterURL(width: .mini))
            posterRequest.priority = .high
            Nuke.loadImage(with: posterRequest, into: imagesCell.posterImage)

            var backgropRequest = ImageRequest(url: movie.backgropURL(width: .large))
            backgropRequest.priority = .high
            Nuke.loadImage(with: backgropRequest, into: imagesCell.backdropImage)
            return imagesCell
        } else {
            let overviewCell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailOverviewCell", for: indexPath) as! MovieDetailOverviewCell
            let label = overviewCell.textLabel!
            label.numberOfLines = 0
            label.attributedText = self.buildAttributedString()
            return overviewCell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 210
        } else {
            return UITableView.automaticDimension
//            let overviewString = self.buildAttributedString()
//            print(self.view.bounds.size)
//            let rect = overviewString.boundingRect(with: self.view.bounds.size, options: [], context: nil)
//            print(rect.size)
//            return rect.size.height
        }
    }

    func buildAttributedString() -> NSAttributedString {
        let overviewString = NSMutableAttributedString(string: "\(self.movie.overview!)\n")
        let releaseDateString = NSAttributedString(string: "Released: \(self.movie.release_date!)", attributes: [.font: UIFont.italicSystemFont(ofSize: 18)])
        overviewString.append(releaseDateString)
        return overviewString
    }

}
