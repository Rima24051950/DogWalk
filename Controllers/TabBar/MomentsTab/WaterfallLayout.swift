//
//  WaterfallLayout.swift
//  DogWalk
//
//  Created by MacBook on 26.05.2026.
//

import UIKit

protocol WaterfallLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView,
                        layout: WaterfallLayout,
                        heightForItemAt indexPath: IndexPath) -> CGFloat
}

class WaterfallLayout: UICollectionViewLayout {
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat { collectionView?.bounds.width ?? 0 }
    
    var columns: Int = 2
    var interItemSpacing: CGFloat = 15
    var lineSpacing: CGFloat = 19
    
    weak var delegate: WaterfallLayoutDelegate?
    
    override func prepare() {
        guard cache.isEmpty, let cv = collectionView else { return }
        
        let colWidth = (contentWidth - CGFloat(columns - 1) * interItemSpacing) / CGFloat(columns)
        var xOffset: [CGFloat] = Array(0..<columns).map { CGFloat($0) * (colWidth + interItemSpacing) }
        var yOffset = Array(repeating: CGFloat.zero, count: columns)
        var col = 0
        
        for item in 0..<cv.numberOfItems(inSection: 0) {
            let ip = IndexPath(item: item, section: 0)
            let height = delegate?.collectionView(cv, layout: self, heightForItemAt: ip) ?? 200
            
            let frame = CGRect(x: xOffset[col], y: yOffset[col], width: colWidth, height: height)
            let attr = UICollectionViewLayoutAttributes(forCellWith: ip)
            attr.frame = frame
            cache.append(attr)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[col] += height + lineSpacing
            
            // Находим самую короткую колонку для следующего элемента
            if let minIdx = yOffset.firstIndex(of: yOffset.min()!) {
                col = minIdx
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        cache.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cache.first { $0.indexPath == indexPath }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        newBounds.width != collectionView?.bounds.width
    }
}
