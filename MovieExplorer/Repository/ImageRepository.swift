//
//  ImageRepository.swift
//  MovieExplorer
//
//  Created by Scott Delly on 3/10/19.
//  Copyright © 2019 SD. All rights reserved.
//

import UIKit
import Nuke

protocol ImageRepositoryProtocol {
    func loadImage(with url: URL, into view: ImageDisplayingView)

    func loadImage(with url: URL,
    options: ImageLoadingOptions,
    into view: ImageDisplayingView,
    completion: ImageTask.Completion?)
}

class ImageRepository: ImageRepositoryProtocol {
    func loadImage(with url: URL, into view: ImageDisplayingView) {
        Nuke.loadImage(with: url, into: view)
    }

    func loadImage(with url: URL,
                   options: ImageLoadingOptions = ImageLoadingOptions.shared,
                   into view: ImageDisplayingView,
                   completion: ImageTask.Completion? = nil) {
        Nuke.loadImage(with: url, options: options, into: view, completion: completion)
    }
}
