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
    @IBOutlet weak var leftNavButton: UIBarButtonItem!

    var posterImage: UIImage?
    weak var posterImageZoomView: ImageZoomView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.title = self.movie.title
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
            Nuke.loadImage(with: posterRequest, into: imagesCell.posterImage, completion: { [weak self] (response, error) in
                self?.posterImage = response?.image
            })

            var backgropRequest = ImageRequest(url: movie.backgropURL(width: .large))
            backgropRequest.priority = .high
            Nuke.loadImage(with: backgropRequest, into: imagesCell.backdropImage)
            imagesCell.delegate = self
            return imagesCell
        } else {
            let overviewCell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailOverviewCell", for: indexPath) as! MovieDetailOverviewCell
            let label = overviewCell.textLabel!
            label.numberOfLines = 0
            label.attributedText = self.buildAttributedString()
            return overviewCell
        }
    }

    func buildAttributedString() -> NSAttributedString {
        let overviewString = NSMutableAttributedString(string: "\(self.movie.overview)\n")
        let releaseDateString = NSAttributedString(string: "Released: \(self.movie.releaseDate)", attributes: [.font: UIFont.italicSystemFont(ofSize: 18)])
        overviewString.append(releaseDateString)
        return overviewString
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let _ = self.posterImageZoomView {
            self.hideZoomImageView()
            return false
        } else {
            return true
        }
    }

    func showZoomImageView(from view: UIView){
        let zoomImageView = ImageZoomView(frame: self.view.bounds)
        self.view.addSubview(zoomImageView)
        self.posterImageZoomView = zoomImageView
        zoomImageView.show(at: zoomImageView.convert(view.frame, from: view.superview), in: { imageView in
            imageView.contentMode = .scaleAspectFit
            Nuke.loadImage(with: self.movie.posterURL(width: .full), options: ImageLoadingOptions(placeholder: self.posterImage), into: imageView)
        })
        self.tableView.isScrollEnabled = false

        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapGRAction(_:)))
        zoomImageView.addGestureRecognizer(tapGR)
    }

    @objc func tapGRAction(_ sender: UITapGestureRecognizer) {
        self.hideZoomImageView()
        sender.isEnabled = false
    }

    func hideZoomImageView() {
        self.posterImageZoomView?.unShow { Bool in
            self.posterImageZoomView?.removeFromSuperview()
        }
        self.leftNavButton.title = "Done"
        self.tableView.isScrollEnabled = true
    }
}

extension MovieDetailVC: MovieDetailImagesCellDelegate {
    func buttonPosterTUIAction(_ sender: UIButton) {
        self.showZoomImageView(from: sender)
    }
}
