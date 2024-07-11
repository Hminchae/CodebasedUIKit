//
//  ImageZoomViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/11/24.
//

import UIKit

import SnapKit

/* 🇰🇷🇰🇷🇰🇷🇰🇷🇰🇷🇰🇷
 배너 : 10개 이미지, 1개가 100M 인 경우
 1. 컬렉션뷰로 구성하는 경우: 재사용 매커니즘, 보일 때 로드 -> 100M
 2. 페이지뷰로 구성하는 경우: 300M
 3. 스크롤뷰로 구성하는 경우: 1G
 */
class ImageZoomViewController: UIViewController {
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .green
        view.maximumZoomScale = 4
        view.minimumZoomScale = 1
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        
        return view
    }()
    
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .yellow
        view.image = UIImage(systemName: "star")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        
        scrollView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func doubleTapGesture() {
        print("Tap!")
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(3, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
}

extension ImageZoomViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
