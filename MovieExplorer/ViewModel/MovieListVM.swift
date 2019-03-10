//
//  MovieListVM.swift
//  MovieExplorer
//
//  Created by Scott Delly on 3/9/19.
//  Copyright © 2019 SD. All rights reserved.
//

import UIKit
import ReactiveSwift
import Moya

class MoviewListVM {

    fileprivate var movieData = MutableProperty<[TMDBMovie]>([])

    var count: Int {
        return self.movieData.value.count
    }

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

    subscript(i: Int) -> TMDBMovie {
        get {
            return self.movieData.value[i]
        }
    }
}
