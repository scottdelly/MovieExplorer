//
//  MovieListVC.swift
//  MovieExplorer
//
//  Created by Scott Delly on 3/8/19.
//  Copyright © 2019 SD. All rights reserved.
//

import UIKit
import ReactiveSwift
import Moya
import Alamofire
import Nuke
import Toucan

class MoviewListVM {

    var movieData = MutableProperty<[TMDBMovie]>([])

    func fetch(page: Int) -> SignalProducer<[TMDBMovie], MoyaError> {
        return TMDBRepository.reactive.request(.nowPlaying(page: page))
            .map([TMDBMovie].self, atKeyPath: "results")
            .on(event: { (event) in
            switch event {
            case let .value(response):
                if page == 1 {
                    self.movieData.swap(response)
                } else {
                    self.movieData.modify({ (movies) in
                        movies.append(contentsOf: response)
                    })
                }
            case let .failed(error):
                print("ERR: \(error)")
            default:
                break
            }
        })
    }
}

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
        return self.movieList.movieData.value.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        let movie = self.movieList.movieData.value[indexPath.item]
        movieCell.titleLabel.text = movie.title

        var posterRequest = ImageRequest(url: movie.posterURL(width: .mini))
        posterRequest.priority = .high
        Nuke.loadImage(with: posterRequest, into: movieCell.posterImage)

        var backgropRequest = ImageRequest(url: movie.backgropURL(width: .large))
        backgropRequest.priority = .high
        Nuke.loadImage(with: backgropRequest, into: movieCell.backdropImage)

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
                movieDetail.movie = self.movieList.movieData.value[indexPath.item]
            }
        }
    }

    @IBAction
    func prepareForUnwind(segue: UIStoryboardSegue) {
        //
    }
}

