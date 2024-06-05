//
//  ViewController.swift
//  MovieBoxOffice
//
//  Created by 황민채 on 6/5/24.
//

import UIKit

import Alamofire
import SnapKit

class ViewController: UIViewController {

    let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "bgImage")
        
        return imageView
    }()
    
    let bgView = {
        let bgView = UIView()
        bgView.backgroundColor = .black.withAlphaComponent(0.9)
        
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureViewHierachy()
        configureViewLayout()
    }
    
    func configureViewHierachy() {
        view.addSubview(imageView)
        view.addSubview(bgView)
    }
    
    func configureViewLayout() {
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

}

