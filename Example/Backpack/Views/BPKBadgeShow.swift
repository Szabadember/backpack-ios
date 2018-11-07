//
//  BPKBadgeShow.swift
//  Backpack Native
//
//  Created by George Gillams on 06/11/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

// TODO Add label, stack view and badges
// TODO Add api for setting badge type
// TODO On value changed, set title and badge types

import UIKit

class BPKBadgeShow: UIView {
    var label: UILabel!
    var imageView: UIImageView!

    var caption: String? {
        get { return label?.text }
        set { label.text = newValue }
    }

    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    func initSubviews() {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 30))
//        label.textColor = UIColor(white: 0.9, alpha: 1.0)
        label.text = "BADGE TYPE"
        addSubview(label)
        
        // sets the image's frame to fill our view
//        imageView = UIImageView(frame: bounds)
//        imageView.contentMode = UIView.ContentMode.scaleAspectFill
//        imageView.clipsToBounds = true
//        addSubview(imageView)

//         caption has translucent grey background 30 points high and span across bottom of view
        let captionBackgroundView = UIView(frame: CGRect(x: 0, y: label.bounds.height, width: bounds.width, height: bounds.height - label.bounds.height))
        captionBackgroundView.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
        addSubview(captionBackgroundView)
    }
}
