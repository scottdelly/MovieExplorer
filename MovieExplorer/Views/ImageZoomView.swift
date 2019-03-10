//
//  ImageZoomView.swift
//  MovieExplorer
//
//  Created by Scott Delly on 3/9/19.
//  Copyright © 2019 SD. All rights reserved.
//

import UIKit

class ImageZoomView: UIScrollView {
    static let AnimationTime = 0.2

    weak var zoomImageView: UIImageView!
    var imageStartFrame: CGRect

    override init(frame: CGRect) {
        self.imageStartFrame = frame

        let zoomImageView = UIImageView(frame: frame)
        self.zoomImageView = zoomImageView

        super.init(frame: frame)
        self.addSubview(zoomImageView)
        self.minimumZoomScale = 1.0
        self.maximumZoomScale = 6.0
        self.backgroundColor = .black
        self.bounces = true
        self.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(at frame: CGRect? = nil, in block: (UIImageView) -> (), completion: ((Bool) -> Void)? = nil) {
        self.imageStartFrame = frame ?? self.imageStartFrame
        self.zoomImageView.frame = self.imageStartFrame
        block(self.zoomImageView)
        UIView.animate(withDuration: ImageZoomView.AnimationTime, animations: {
            self.zoomImageView.frame = self.bounds
        }, completion: completion)
    }

    func unShow(to frame: CGRect? = nil, completion: ((Bool) -> Void)? = nil) {
        self.imageStartFrame = frame ?? self.imageStartFrame

        UIView.animate(withDuration: ImageZoomView.AnimationTime, animations: {
            self.zoomImageView.frame = self.imageStartFrame
            self.backgroundColor = .clear
        }, completion: completion)
    }
}

//Secondary ScrollView Delegate
extension ImageZoomView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.zoomImageView
    }
}
