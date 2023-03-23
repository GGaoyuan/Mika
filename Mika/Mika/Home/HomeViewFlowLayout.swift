//
//  HomeViewFlowLayout.swift
//  Mika
//
//  Created by gaoyuan on 2023/2/28.
//

import UIKit

fileprivate let ItemSpace: CGFloat = 10
fileprivate let EdgeSpace: CGFloat = 16 //左右间距
fileprivate let LineSpace: CGFloat = 10 //行间距

enum HomeViewItemSize {
    case smallSquare
    case midSquare
    case bigSquare
    case rectangle
    
    var rawValue: CGSize {
        switch self {
        case .smallSquare:
            let width = (ACScreenWidth - (2 * EdgeSpace) - (3 * ItemSpace)) / 4
            return CGSize(width: width, height: width)
        case .midSquare:
            let width = (ACScreenWidth - (2 * EdgeSpace) - ItemSpace) / 2
            return CGSize(width: width, height: width)
        case .bigSquare:
            let width = (ACScreenWidth - (2 * EdgeSpace))
            return CGSize(width: width, height: width)
        case .rectangle:
            let width = (ACScreenWidth - (2 * EdgeSpace))
            let height = width / 2
            return CGSize(width: width, height: height)
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
        
//        let itemSpace: CGFloat = 10
//        let edge: CGFloat = 20
        //对于每个cell
        for i in 0 ..< count{
            let indexPath = IndexPath(row: i, section: Section)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            //获取对应的cell的大小
            if let itemSize = delegate.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath) {
                attribute.frame = CGRect(x: 0, y: 0, width: itemSize.width, height: itemSize.height)
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
