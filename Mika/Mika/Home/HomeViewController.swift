//
//  HomeViewController.swift
//  Mika
//
//  Created by gaoyuan on 2023/2/22.
//

import UIKit
import SnapKit
import ACKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var noticeArea: UIView!
    @IBOutlet weak var contentArea: UIView!
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth: CGFloat = 60
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        let lineItemNum: CGFloat = 4
        let minimumInteritemSpacing = (Device_ScreenWidth - itemWidth * lineItemNum - 20 * 2) / lineItemNum
        layout.itemSize = itemSize
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: HallTabContentViewCell.self)
        contentArea.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    

}


extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HallTabContentViewCell.self)
        cell.model = dataSource[indexPath.row]
        cell.shaking = isEditing
        return cell
    }
}
