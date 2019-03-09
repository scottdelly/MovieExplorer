//
//  TMDBRepository.swift
//  MovieExplorer
//
//  Created by Scott Delly on 3/8/19.
//  Copyright © 2019 SD. All rights reserved.
//

import UIKit
import Moya
import Alamofire

fileprivate let TMDBAPIKey = "1e1c266b3ca81dad5aea7386cd74c596"

let TMDBRepository = MoyaProvider<TMDB>(plugins: [NetworkLoggerPlugin(verbose: true)])

enum TMDB {
    case nowPlaying(page: Int)
}

extension TMDB: TargetType {
    static var baseURL: URL { return URL(string:"https://api.themoviedb.org/3")! }
    var baseURL: URL { return TMDB.baseURL }
    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        }
    }
    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        switch self {
        case .nowPlaying:
            return TMDBSampleJson.data(using: String.Encoding.utf8)!
        }
    }

    var task: Task {
        switch self {
        case .nowPlaying(let page):
            return .requestParameters(parameters: ["api_key":TMDBAPIKey, "page":page], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return nil
    }
}

let TMDBSampleJson = """
{
  "results": [
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
    {
      "vote_count": 488,
      "id": 299537,
      "video": false,
      "vote_average": 7.1,
      "title": "Captain Marvel",
      "popularity": 303.066,
      "poster_path": "/AtsgWhDnHTq68L0lLsUrCnM7TjG.jpg",
      "original_language": "en",
      "original_title": "Captain Marvel",
      "genre_ids": [
        28,
        12,
        878
      ],
      "backdrop_path": "/w2PMyoyLU22YvrGK3smVM9fW1jj.jpg",
      "adult": false,
      "overview": "The story follows Carol Danvers as she becomes one of the universe’s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races. Set in the 1990s, Captain Marvel is an all-new adventure from a previously unseen period in the history of the Marvel Cinematic Universe.",
      "release_date": "2019-03-06"
    },
    {
      "vote_count": 4147,
      "id": 297802,
      "video": false,
      "vote_average": 6.8,
      "title": "Aquaman",
      "popularity": 262.724,
      "poster_path": "/5Kg76ldv7VxeX9YlcQXiowHgdX6.jpg",
      "original_language": "en",
      "original_title": "Aquaman",
      "genre_ids": [
        28,
        12,
        14,
        878
      ],
      "backdrop_path": "/5A2bMlLfJrAfX9bqAibOL2gCruF.jpg",
      "adult": false,
      "overview": "Once home to the most advanced civilization on Earth, the city of Atlantis is now an underwater kingdom ruled by the power-hungry King Orm. With a vast army at his disposal, Orm plans to conquer the remaining oceanic people -- and then the surface world. Standing in his way is Aquaman, Orm's half-human, half-Atlantean brother and true heir to the throne. With help from royal counselor Vulko, Aquaman must retrieve the legendary Trident of Atlan and embrace his destiny as protector of the deep.",
      "release_date": "2018-12-07"
    },
    {
      "vote_count": 638,
      "id": 449563,
      "video": false,
      "vote_average": 6.4,
      "title": "Isn't It Romantic",
      "popularity": 158.982,
      "poster_path": "/5xNBYXuv8wqiLVDhsfqCOr75DL7.jpg",
      "original_language": "en",
      "original_title": "Isn't It Romantic",
      "genre_ids": [
        35,
        14,
        10749
      ],
      "backdrop_path": "/8DRsq8rz0rZ25TIMomwHrLTA31Y.jpg",
      "adult": false,
      "overview": "For a long time, Natalie, an Australian architect living in New York City, had always believed that what she had seen in rom-coms is all fantasy. But after thwarting a mugger at a subway station only to be knocked out while fleeing, Natalie wakes up and discovers that her life has suddenly become her worst nightmare—a romantic comedy—and she is the leading lady.",
      "release_date": "2019-02-13"
    },
    {
      "vote_count": 1649,
      "id": 450465,
      "video": false,
      "vote_average": 6.6,
      "title": "Glass",
      "popularity": 153.87,
      "poster_path": "/svIDTNUoajS8dLEo7EosxvyAsgJ.jpg",
      "original_language": "en",
      "original_title": "Glass",
      "genre_ids": [
        53,
        9648,
        18,
        14
      ],
      "backdrop_path": "/lvjscO8wmpEbIfOEZi92Je8Ktlg.jpg",
      "adult": false,
      "overview": "In a series of escalating encounters, security guard David Dunn uses his supernatural abilities to track Kevin Wendell Crumb, a disturbed man who has twenty-four personalities. Meanwhile, the shadowy presence of Elijah Price emerges as an orchestrator who holds secrets critical to both men.",
      "release_date": "2019-01-16"
    },
    {
      "vote_count": 2030,
      "id": 490132,
      "video": false,
      "vote_average": 8.3,
      "title": "Green Book",
      "popularity": 150.952,
      "poster_path": "/7BsvSuDQuoqhWmU2fL7W2GOcZHU.jpg",
      "original_language": "en",
      "original_title": "Green Book",
      "genre_ids": [
        18,
        35,
        10402
      ],
      "backdrop_path": "/Arxw3x7Y1jmkYryy0CodKce0Cms.jpg",
      "adult": false,
      "overview": "Tony Lip, a bouncer in 1962, is hired to drive pianist Don Shirley on a tour through the Deep South in the days when African Americans, forced to find alternate accommodations and services due to segregation laws below the Mason-Dixon Line, relied on a guide called The Negro Motorist Green Book.",
      "release_date": "2018-11-16"
    },
    {
      "vote_count": 903,
      "id": 166428,
      "video": false,
      "vote_average": 7.9,
      "title": "How to Train Your Dragon: The Hidden World",
      "popularity": 149.205,
      "poster_path": "/xvx4Yhf0DVH8G4LzNISpMfFBDy2.jpg",
      "original_language": "en",
      "original_title": "How to Train Your Dragon: The Hidden World",
      "genre_ids": [
        16,
        10751,
        12
      ],
      "backdrop_path": "/h3KN24PrOheHVYs9ypuOIdFBEpX.jpg",
      "adult": false,
      "overview": "As Hiccup fulfills his dream of creating a peaceful dragon utopia, Toothless’ discovery of an untamed, elusive mate draws the Night Fury away. When danger mounts at home and Hiccup’s reign as village chief is tested, both dragon and rider must make impossible decisions to save their kind.",
      "release_date": "2019-01-03"
    },
    {
      "vote_count": 53,
      "id": 487297,
      "video": false,
      "vote_average": 6.1,
      "title": "What Men Want",
      "popularity": 129.62,
      "poster_path": "/30IiwvIRqPGjUV0bxJkZfnSiCL.jpg",
      "original_language": "en",
      "original_title": "What Men Want",
      "genre_ids": [
        35,
        14,
        10749
      ],
      "backdrop_path": "/umecegsPpKr2ZXA62Da9CQBVoIO.jpg",
      "adult": false,
      "overview": "Magically able to hear what men are thinking, a sports agent uses her newfound ability to turn the tables on her overbearing male colleagues.",
      "release_date": "2019-02-08"
    },
    {
      "vote_count": 45,
      "id": 445629,
      "video": false,
      "vote_average": 7,
      "title": "Fighting with My Family",
      "popularity": 129.552,
      "poster_path": "/3TZCBAdKQiz0cGKGEjZiyZUA01O.jpg",
      "original_language": "en",
      "original_title": "Fighting with My Family",
      "genre_ids": [
        35,
        18
      ],
      "backdrop_path": "/mYKP6qcDUimVMAHQWLOuDHjO19S.jpg",
      "adult": false,
      "overview": "Born into a tight-knit wrestling family, Paige and her brother Zak are ecstatic when they get the once-in-a-lifetime opportunity to try out for the WWE. But when only Paige earns a spot in the competitive training program, she must leave her loved ones behind and face this new cutthroat world alone. Paige's journey pushes her to dig deep and ultimately prove to the world that what makes her different is the very thing that can make her a star.",
      "release_date": "2019-02-14"
    },
    {
      "vote_count": 1591,
      "id": 480530,
      "video": false,
      "vote_average": 6.6,
      "title": "Creed II",
      "popularity": 126.963,
      "poster_path": "/v3QyboWRoA4O9RbcsqH8tJMe8EB.jpg",
      "original_language": "en",
      "original_title": "Creed II",
      "genre_ids": [
        18
      ],
      "backdrop_path": "/6JHYYbvoSuQ95ceGx8Oeg8zzAjg.jpg",
      "adult": false,
      "overview": "Between personal obligations and training for his next big fight against an opponent with ties to his family's past, Adonis Creed is up against the challenge of his life.",
      "release_date": "2018-11-21"
    },
    {
      "vote_count": 39,
      "id": 450001,
      "video": false,
      "vote_average": 6,
      "title": "Master Z: Ip Man Legacy",
      "popularity": 108.4,
      "poster_path": "/2WfjB6FUDTIBVI2y02UGbnHR82s.jpg",
      "original_language": "cn",
      "original_title": "葉問外傳：張天志",
      "genre_ids": [
        28
      ],
      "backdrop_path": "/nv4KsjnhcSIZtuw2mkT9IxoQ5oq.jpg",
      "adult": false,
      "overview": "After being defeated by Ip Man, Cheung Tin Chi is attempting to keep a low profile. While going about his business, he gets into a fight with a foreigner by the name of Davidson, who is a big boss behind the bar district. Tin Chi fights hard with Wing Chun and earns respect.",
      "release_date": "2018-12-20"
    },
    {
      "vote_count": 1737,
      "id": 404368,
      "video": false,
      "vote_average": 7.3,
      "title": "Ralph Breaks the Internet",
      "popularity": 90.85,
      "poster_path": "/lvfIaThG5HA8THf76nghKinjjji.jpg",
      "original_language": "en",
      "original_title": "Ralph Breaks the Internet",
      "genre_ids": [
        10751,
        16,
        35,
        14
      ],
      "backdrop_path": "/88poTBTafMXaz73vYi3c74g0y2k.jpg",
      "adult": false,
      "overview": "Video game bad guy Ralph and fellow misfit Vanellope von Schweetz must risk it all by traveling to the World Wide Web in search of a replacement part to save Vanellope's video game, \"Sugar Rush.\" In way over their heads, Ralph and Vanellope rely on the citizens of the internet -- the netizens -- to help navigate their way, including an entrepreneur named Yesss, who is the head algorithm and the heart and soul of trend-making site BuzzzTube.",
      "release_date": "2018-11-20"
    },
    {
      "vote_count": 353,
      "id": 491418,
      "video": false,
      "vote_average": 7.6,
      "title": "Instant Family",
      "popularity": 89.476,
      "poster_path": "/xYV1mODz99w7AjKDSQ7h2mzZhVe.jpg",
      "original_language": "en",
      "original_title": "Instant Family",
      "genre_ids": [
        35,
        18
      ],
      "backdrop_path": "/lwICpzZudw8BZ0bODaHgRWCdioB.jpg",
      "adult": false,
      "overview": "When Pete and Ellie decide to start a family, they stumble into the world of foster care adoption. They hope to take in one small child but when they meet three siblings, including a rebellious 15 year old girl, they find themselves speeding from zero to three kids overnight.",
      "release_date": "2018-11-16"
    },
    {
      "vote_count": 8,
      "id": 474214,
      "video": false,
      "vote_average": 5.9,
      "title": "Trading Paint",
      "popularity": 79.47,
      "poster_path": "/369lMjt2Z0Zl9DaNDw5SqKSs7es.jpg",
      "original_language": "en",
      "original_title": "Trading Paint",
      "genre_ids": [
        28
      ],
      "backdrop_path": "/7yCJIBlOJYial2srRLq1Wtxy6II.jpg",
      "adult": false,
      "overview": "The love and rivalry between a racing veteran and his fellow driver son creates many conflicts for a family.",
      "release_date": "2019-02-22"
    },
    {
      "vote_count": 201,
      "id": 438650,
      "video": false,
      "vote_average": 5.2,
      "title": "Cold Pursuit",
      "popularity": 76.291,
      "poster_path": "/hXgmWPd1SuujRZ4QnKLzrj79PAw.jpg",
      "original_language": "en",
      "original_title": "Cold Pursuit",
      "genre_ids": [
        53,
        28,
        18
      ],
      "backdrop_path": "/7Wg6FOEvhduISlxSzSCutAl4lPq.jpg",
      "adult": false,
      "overview": "Nels Coxman's quiet life comes crashing down when his beloved son dies under mysterious circumstances. His search for the truth soon becomes a quest for revenge as he seeks coldblooded justice against a drug lord and his inner circle.",
      "release_date": "2019-02-07"
    },
    {
      "vote_count": 908,
      "id": 400650,
      "video": false,
      "vote_average": 6.8,
      "title": "Mary Poppins Returns",
      "popularity": 73.114,
      "poster_path": "/uTVGku4LibMGyKgQvjBtv3OYfAX.jpg",
      "original_language": "en",
      "original_title": "Mary Poppins Returns",
      "genre_ids": [
        14,
        10751,
        35
      ],
      "backdrop_path": "/cwiJQXezWz876K3jS57Sq56RYCZ.jpg",
      "adult": false,
      "overview": "In Depression-era London, a now-grown Jane and Michael Banks, along with Michael's three children, are visited by the enigmatic Mary Poppins following a personal loss. Through her unique magical skills, and with the aid of her friend Jack, she helps the family rediscover the joy and wonder missing in their lives.",
      "release_date": "2018-12-13"
    },
    {
      "vote_count": 287,
      "id": 512196,
      "video": false,
      "vote_average": 6.2,
      "title": "Happy Death Day 2U",
      "popularity": 71.094,
      "poster_path": "/whtt9F8PFqvEgc4fDSHZPkitFk4.jpg",
      "original_language": "en",
      "original_title": "Happy Death Day 2U",
      "genre_ids": [
        27,
        9648,
        53,
        878,
        35
      ],
      "backdrop_path": "/7trJGwprMUMKhvSx94lmsq6d985.jpg",
      "adult": false,
      "overview": "Collegian Tree Gelbman wakes up in horror to learn that she's stuck in a parallel universe. Her boyfriend Carter is now with someone else, and her friends and fellow students seem to be completely different versions of themselves. When Tree discovers that Carter's roommate has been altering time, she finds herself once again the target of a masked killer. When the psychopath starts to go after her inner circle, Tree soon realizes that she must die over and over again to save everyone.",
      "release_date": "2019-02-13"
    },
    {
      "vote_count": 1460,
      "id": 375262,
      "video": false,
      "vote_average": 7.7,
      "title": "The Favourite",
      "popularity": 68.103,
      "poster_path": "/cwBq0onfmeilU5xgqNNjJAMPfpw.jpg",
      "original_language": "en",
      "original_title": "The Favourite",
      "genre_ids": [
        18,
        36,
        35
      ],
      "backdrop_path": "/ekWMoBZ4B9rM60INZEh5FAD2HFR.jpg",
      "adult": false,
      "overview": "England, early 18th century. The close relationship between Queen Anne and Sarah Churchill is threatened by the arrival of Sarah's cousin, Abigail Hill, resulting in a bitter rivalry between the two cousins to be the Queen's favourite.",
      "release_date": "2018-11-23"
    },
    {
      "vote_count": 207,
      "id": 465914,
      "video": false,
      "vote_average": 7.3,
      "title": "If Beale Street Could Talk",
      "popularity": 65.105,
      "poster_path": "/8tZx0OX7kxv6F2VNWZoPr2bWDgE.jpg",
      "original_language": "en",
      "original_title": "If Beale Street Could Talk",
      "genre_ids": [
        18,
        10749,
        80
      ],
      "backdrop_path": "/1BeMxME8SPuJgCTmyEBzGWSZrAR.jpg",
      "adult": false,
      "overview": "After her fiance is falsely imprisoned, a pregnant African-American woman sets out to clear his name and prove his innocence.",
      "release_date": "2018-11-30"
    },
    {
      "vote_count": 774,
      "id": 504172,
      "video": false,
      "vote_average": 6.5,
      "title": "The Mule",
      "popularity": 64.187,
      "poster_path": "/oeZh7yEz3PMnZLgBPhrafFHRbVz.jpg",
      "original_language": "en",
      "original_title": "The Mule",
      "genre_ids": [
        80,
        18,
        53
      ],
      "backdrop_path": "/bTeRgkAavyw1eCtSkaww18wLYNP.jpg",
      "adult": false,
      "overview": "Earl Stone, a man in his 80s who is broke, alone, and facing foreclosure of his business when he is offered a job that simply requires him to drive. Easy enough, but, unbeknownst to Earl, he’s just signed on as a drug courier for a Mexican cartel. He does so well that his cargo increases exponentially, and Earl hit the radar of hard-charging DEA agent Colin Bates.",
      "release_date": "2018-12-14"
    }
  ],
  "page": 1,
  "total_results": 1014,
  "dates": {
    "maximum": "2019-03-13",
    "minimum": "2019-01-24"
  },
  "total_pages": 51
}
"""
