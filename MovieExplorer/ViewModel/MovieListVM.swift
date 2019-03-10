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

typealias MovieRequest = (TMDB, DispatchQueue?) -> SignalProducer<Response, MoyaError>

class MoviewListVM: MovieListVMProtocol {

    fileprivate var movieData = MutableProperty<[TMDBMovie]>([])

    var request: MovieRequest = TMDBRepository.reactive.request

    var lastPage = 0
    var count: Int {
        return self.movieData.value.count
    }

    func fetch() -> SignalProducer<[TMDBMovie], MoyaError> {
        return self.fetch(page: 1)
    }

    func fetchNext() -> SignalProducer<[TMDBMovie], MoyaError> {
        return self.fetch(page: self.lastPage + 1)
    }

    func fetch(page: Int) -> SignalProducer<[TMDBMovie], MoyaError> {
        self.lastPage = page
        return self.request(.nowPlaying(page: page), nil).map([DecodeReslt<TMDBMovie>].self, atKeyPath: "results")
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
