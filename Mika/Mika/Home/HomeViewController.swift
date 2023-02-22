//
//  HomeViewController.swift
//  Mika
//
//  Created by gaoyuan on 2023/2/22.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var noticeArea: UIView!
    @IBOutlet weak var contentArea: UIView!
    
    enum HomeItemType {
        case date
        case miss
        case receiveMiss
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    

}
