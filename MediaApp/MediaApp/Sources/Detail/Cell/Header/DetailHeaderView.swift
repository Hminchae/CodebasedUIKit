//
//  DetailHeaderView.swift
//  MediaApp
//
//  Created by 황민채 on 6/27/24.
//

import UIKit

class DetailHeaderView: BaseView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.isUserInteractionEnabled = false
    
        return pageControl
    }()
    
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 0
        let cellSpacing: CGFloat = 0
        let width = UIScreen.main.bounds.width
        
        layout.itemSize = CGSize(width: width, height: 450)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing,
                                           left: sectionSpacing,
                                           bottom: sectionSpacing,
                                           right: sectionSpacing)
        
        return layout
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
            make.height.equalTo(15)
        }
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(pageControl)
        
        collectionView.delegate = self
    }
    
    override func configureView() {
        collectionView.register(DetailHeaderCollectionCell.self, forCellWithReuseIdentifier: DetailHeaderCollectionCell.identifier)
        collectionView.backgroundColor = .bg
        collectionView.indicatorStyle = .black
        collectionView.isPagingEnabled = true
    }
}

// Page Control
extension DetailHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        pageControl.currentPage = visibleIndexPath?.row ?? 0
    }
    
    func setNumberOfPages(_ count: Int) {
        pageControl.numberOfPages = count
    }
}
