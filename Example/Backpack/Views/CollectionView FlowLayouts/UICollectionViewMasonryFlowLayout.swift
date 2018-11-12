//
//  CollectionViewCenterLayout.swift
//  CenteredCollectionView-Sample
//
//  Created by Dejan Skledar on 17/04/2018.
//  Copyright © 2018 Dejan Skledar. All rights reserved.
//

import UIKit

class CollectionViewRow {
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0

    init(spacing: CGFloat) {
        self.spacing = spacing
    }

    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }

    func leftAlignLayout(collectionViewWidth: CGFloat) {
        var offset = CGFloat(0.0)
        for attribute in attributes {
            attribute.frame.origin.x = offset
            offset += attribute.frame.width + spacing
        }
    }
}

class UICollectionViewMasonryFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var rows = [CollectionViewRow]()
        var currentRow: CGFloat = -1

        for attribute in attributes {
            if currentRow != attribute.frame.origin.y {
                currentRow = attribute.frame.origin.y
                rows.append(CollectionViewRow(spacing: self.minimumInteritemSpacing))
            }
            rows.last?.add(attribute: attribute)
        }

        rows.forEach { $0.leftAlignLayout(collectionViewWidth: collectionView?.frame.width ?? 0) }
        return rows.flatMap { $0.attributes }
    }
}
