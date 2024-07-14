//
//  NormalCaroselCollectionViewCell.swift
//  ModernLayout
//
//  Created by 황민채 on 7/13/24.
//

//import UIKit
//
//class NormalCaroselCollectionViewCell: UICollectionViewCell {
//    
//    static let id = "NormalCaroselCollectionViewCell"
//    
//    private let mainImage = UIImageView()
//    private let titleLabel = UILabel()
//    private let subTitleLabel = UILabel()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        setUI()
//    }
//    
//    private func setUI() {
//        // Snapkit
//        addSubview(mainImage)
//        addSubview(titleLabel)
//        addSubview(subTitleLabel)
//        
//        mainImage.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//            make.height.equalTo(80)
//        }
//        
//        titleLabel.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(mainImage.snp.bottom).offset(8)
//        }
//        
//        subTitleLabel.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(titleLabel.snp.bottom).offset(8)
//        }
//    }
//    
//    public func config(imageUrl: String, title: String, subTitle: String?) {
//        
//        let url = URL(string: imageUrl)
//        mainImage.kf.setImage(with: url)
//        titleLabel.text = title
//        subTitleLabel.text = subTitle
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
