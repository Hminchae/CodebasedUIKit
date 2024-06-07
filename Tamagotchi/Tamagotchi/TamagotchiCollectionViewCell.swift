//
//  TamagotchiCollectionViewCell.swift
//  Tamagotchi
//
//  Created by 황민채 on 6/7/24.
//

import UIKit
import SnapKit

class TamagotchiCollectionViewCell: UICollectionViewCell {
    
    private let label: UILabel = {
        let v = UILabel()
        v.textColor = .darkGray
        v.font = .systemFont(ofSize: 13)
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.textAlignment = .center
        v.clipsToBounds = true
        v.layer.cornerRadius = 5
        
        return v
    }()
    
    private let imageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        label.text = nil
    }
    
    func configureUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        configureLayout()
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide.snp.horizontalEdges)
        }

        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            make.height.equalTo(22)
            make.bottom.equalTo(contentView.snp.bottom).inset(5)
        }
    }
    
    func configure(with model: Tamagotchi) {
        label.text = model.name
        imageView.image = UIImage(named: model.face)
    }
}
