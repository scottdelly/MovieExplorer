//
//  MovieListVC.swift
//  MovieExplorer
//
//  Created by Scott Delly on 3/8/19.
//  Copyright © 2019 SD. All rights reserved.
//

import UIKit
import ReactiveSwift
import Alamofire
import Nuke
import Toucan

class MovieListVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let movieList = MoviewListVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieList.fetch(page: 1).startWithCompleted {
            self.collectionView.reloadData()
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        let movie = self.movieList[indexPath.item]
        movieCell.titleLabel.text = movie.title
        Nuke.loadImage(with: movie.posterURL(width: .mini), into: movieCell.posterImage)
        Nuke.loadImage(with: movie.backgropURL(width: .large), into: movieCell.backdropImage)
        return movieCell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        return CGSize(width: width, height: (14*width/25)+38)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail" {
            if let indexPath = collectionView.indexPathsForSelectedItems?[0] {
                let movieDetail = (segue.destination as! UINavigationController).topViewController as! MovieDetailVC
                movieDetail.movie = self.movieList[indexPath.item]
            }
        }
    }

    @IBAction
    func prepareForUnwind(segue: UIStoryboardSegue) {
        //
    }
}

