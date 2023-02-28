//
//  HomeViewController.swift
//  Mika
//
//  Created by gaoyuan on 2023/2/22.
//

import UIKit
//import SnapKit
import ACKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var noticeArea: UIView!
    @IBOutlet weak var contentArea: UIView!
    
    private var collectionView: UICollectionView!
    
    private var homeModel = HomeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        let layout = HomeViewFlowLayout()
//        layout.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.gray
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: HomeDateCell.self)
        collectionView.register(cellType: HomeMissingCell.self)
        collectionView.register(cellType: HomeReceiveMissingCell.self)
        collectionView.register(cellType: HomeAlbumCell.self)
        contentArea.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    

}

extension HomeViewController: HomeViewFlowLayoutDelegate {
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let model = homeModel.dataSource[indexPath.row] as? HomeViewItemLayout {
            return model.sizeType.rawValue
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemModel = homeModel.dataSource[indexPath.row]
        if let model = itemModel as? HomeDateModel {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeDateCell.self)
            return cell
        }
        if let model = itemModel as? HomeAlbumModel {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeAlbumCell.self)
            return cell
        }
        if let model = itemModel as? HomeMissingModel {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeMissingCell.self)
            return cell
        }
        if let model = itemModel as? HomeReceiveMissingModel {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeReceiveMissingCell.self)
            return cell
        }
        return UICollectionViewCell()
    }
}
