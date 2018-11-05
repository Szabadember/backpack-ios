//
//  BadgesView.swift
//  Backpack Native
//
//  Created by George Gillams on 05/11/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class BadgesView: UIView {
    @IBOutlet weak var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    override required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("BadgesView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
