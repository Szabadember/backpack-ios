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
    @IBOutlet weak var typeLabel: UILabel!

    // TODO add type property, which will be used to set Label text and also set badge types

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        print("HERE")
        Bundle.main.loadNibNamed("BadgesView", owner: self, options: nil)
        self.addSubview(self.contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
