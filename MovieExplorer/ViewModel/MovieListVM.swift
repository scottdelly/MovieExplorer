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

    var lastPage = 0
    var count: Int {
        return self.movieData.value.count
    }

    func fetch(page: Int) -> SignalProducer<[TMDBMovie], MoyaError> {
        self.lastPage = page
        return TMDBRepository.reactive.request(.nowPlaying(page: page))
            .map([DecodeReslt<TMDBMovie>].self, atKeyPath: "results")
            .filterMap({ (results) -> [TMDBMovie] in
                return results.compactMap({ (decodeResults) -> TMDBMovie? in
                    return decodeResults.value
                })
            })
            .on(event: { (event) in
                switch event {
                case let .value(response):
                    let finalResponse = response.compactMap({return $0})
                    if page == 1 {
                        self.movieData.swap(finalResponse)
                    } else {
                        self.movieData.modify({ (movies) in
                            movies.append(contentsOf: finalResponse)
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
