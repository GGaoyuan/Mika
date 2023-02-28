//
//  HomeModel.swift
//  Mika
//
//  Created by gaoyuan on 2023/2/22.
//

import UIKit

class HomeModel: NSObject {
    
//    static let dataSource = HomeModel()
//
    var dataSource = [
        HomeDateModel(),
        HomeDateModel(),
        HomeDateModel(),
        HomeDateModel(),
        HomeDateModel(),
        HomeDateModel(),
        HomeDateModel(),
        HomeMissingModel(),
        HomeReceiveMissingModel(),
        HomeAlbumModel()
    ]
}

