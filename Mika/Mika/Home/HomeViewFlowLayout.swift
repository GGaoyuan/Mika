//
//  HomeViewFlowLayout.swift
//  Mika
//
//  Created by gaoyuan on 2023/2/28.
//

import UIKit

class HomeViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        scrollDirection = .vertical
        
    }
}
