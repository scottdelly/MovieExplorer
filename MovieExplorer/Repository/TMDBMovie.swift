//
//  TMDBMovie.swift
//  MovieExplorer
//
//  Created by Scott Delly on 3/8/19.
//  Copyright © 2019 SD. All rights reserved.
//

import Foundation

struct TMDBMovie {
    static let imageBaseURL = "https://image.tmdb.org/t/p/w"

    let id: Int
    let posterPath: String
    let overview: String
    let releaseDate: String
    let title: String
    let backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case title
        case backdropPath = "backdrop_path"
    }

//    Unused
//    let adult: Bool?
//    let genre_ids: [Int]?
//    let original_title: String?
//    let original_language: String?
//    let popularity: Float?
//    let vote_count: Int?
//    let video: Bool?
//    let vote_average: Float?

    enum PosterSize: Int {
        case mini = 200
        case small = 300
        case large = 400
        case full = 500
    }

    func posterURL(width: PosterSize) -> URL {
        return URL(string: "\(TMDBMovie.imageBaseURL)\(width.rawValue)")!.appendingPathComponent(self.posterPath)
    }
    func backgropURL(width: PosterSize) -> URL {
        return URL(string: "\(TMDBMovie.imageBaseURL)\(width.rawValue)")!.appendingPathComponent(self.backdropPath)
    }
}

extension TMDBMovie: Codable {}

let sampleData = """
    {
      "vote_count": 1282,
      "id": 399579,
      "video": false,
      "vote_average": 6.8,
      "title": "Alita: Battle Angel",
      "popularity": 321.12,
      "poster_path": "/xRWht48C2V8XNfzvPehyClOvDni.jpg",
      "original_language": "en",
      "original_title": "Alita: Battle Angel",
      "genre_ids": [
        28,
        878,
        53,
        12
      ],
      "backdrop_path": "/aQXTw3wIWuFMy0beXRiZ1xVKtcf.jpg",
      "adult": false,
      "overview": "When Alita awakens with no memory of who she is in a future world she does not recognize, she is taken in by Ido, a compassionate doctor who realizes that somewhere in this abandoned cyborg shell is the heart and soul of a young woman with an extraordinary past.",
      "release_date": "2019-01-31"
    },
"""
