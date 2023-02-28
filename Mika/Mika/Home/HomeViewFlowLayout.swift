//
//  HomeViewFlowLayout.swift
//  Mika
//
//  Created by gaoyuan on 2023/2/28.
//

import UIKit

enum HomeViewItemSize {
    case smallSquare
    case midSquare
    case bigSquare
    case rectangle
    
    var rawValue: CGSize {
        switch self {
        case .smallSquare:
            return CGSize(width: 50, height: 50)
        case .midSquare:
            return CGSize(width: 100, height: 100)
        case .bigSquare:
            return CGSize(width: 200, height: 200)
        case .rectangle:
            return CGSize(width: 200, height: 100)
        }
    }
}

protocol HomeViewItemLayout: NSObjectProtocol {
    var sizeType: HomeViewItemSize { get }
}


extension HomeAlbumModel: HomeViewItemLayout {
    var sizeType: HomeViewItemSize {
        .smallSquare
    }
}

extension HomeReceiveMissingModel: HomeViewItemLayout {
    var sizeType: HomeViewItemSize {
        .midSquare
    }
}
extension HomeMissingModel: HomeViewItemLayout {
    var sizeType: HomeViewItemSize {
        .bigSquare
    }
}

extension HomeDateModel: HomeViewItemLayout {
    var sizeType: HomeViewItemSize {
        .rectangle
    }
}







protocol HomeViewFlowLayoutDelegate: UICollectionViewDelegateFlowLayout {}

class HomeViewFlowLayout: UICollectionViewFlowLayout {
    weak var delegate: HomeViewFlowLayoutDelegate!
    
    private var lastAttribute: UICollectionViewLayoutAttributes?
    private var attributes = [UICollectionViewLayoutAttributes]()
    private var xOffset: CGFloat = 0
    private var yOffset: CGFloat = 0
    /// 奇数时最大的y
    private var maxOddY: CGFloat = 0
    /// 偶数时最大的y
    private var maxEvenY: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        scrollDirection = .vertical
        
        
        let Section = 0
        guard let collectionView = collectionView else { return }
        //获取元素个数
        let count = collectionView.numberOfItems(inSection: Section)
        //获取collectionView的组边距
        guard let sectionEdgeInsets = delegate.collectionView?(collectionView, layout: self, insetForSectionAt: Section) else { return }
        //自定义属性赋初值
        xOffset = sectionEdgeInsets.left
        yOffset = sectionEdgeInsets.top
        maxOddY = yOffset
        maxEvenY = yOffset
        //对于每个cell
        for i in 0 ..< count{
          print(i)
            let indexPath = IndexPath(row: i, section: Section)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            //获取对应的cell的大小
            if let itemSize = delegate.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath) {
                let y = lastAttribute?.frame.maxY ?? 10
                attribute.frame = CGRect(x: 20, y: y, width: itemSize.width, height: itemSize.height)
                lastAttribute = attribute
            }
            
            
            attributes.append(attribute)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
}
