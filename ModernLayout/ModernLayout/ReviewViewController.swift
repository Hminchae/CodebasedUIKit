//
//  ReviewViewController.swift
//  ModernLayout
//
//  Created by 황민채 on 7/14/24.
//

import UIKit

class ReviewViewController: UIViewController {
    init(id: Int, contentType: ContentType) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        
        print(id, contentType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
