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
        self.load()
        self.collectionView.alwaysBounceVertical = true
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(pulledToRefresh(_:)), for: .valueChanged)
        self.collectionView.addSubview(refresher)
    }

    @objc func pulledToRefresh(_ sender: UIRefreshControl) {
        self.load {
            sender.endRefreshing()
        }
    }

    func load(then block: (()-> ())? = nil){
        self.movieList.fetch(page: 1).startWithCompleted {
            self.collectionView.reloadData()
            block?()
        }
    }

    func loadMore() {
        self.movieList.fetch(page: self.movieList.lastPage + 1).start { (event) in
            switch event {
            case .value(let movies):
                self.collectionView.performBatchUpdates({
                    var paths: [IndexPath] = []
                    let existingItemsCount = self.collectionView.numberOfItems(inSection: 0)
                    let newItemsCount = existingItemsCount + movies.count
                    for i in existingItemsCount..<newItemsCount {
                        paths.append(IndexPath(item: i, section: 0))
                    }
                    self.collectionView.insertItems(at: paths)
                }, completion: { (finished) in
                    print("added \(movies.count) movies")
                })
            case .failed(let error):
                print("failed to load more movies:\n\(error)")
            default:
                break
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item > self.movieList.count - 2 {
            //almost at the end, load next page
            self.loadMore()
        }
        let movieCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        let movie = self.movieList[indexPath.item]
        movieCell.titleLabel.text = movie.title
        Nuke.loadImage(with: movie.posterURL(width: .mini), into: movieCell.posterImage)
        Nuke.loadImage(with: movie.backgropURL(width: .large), into: movieCell.backdropImage)
        return movieCell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loadMoreFooter", for: indexPath)
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

