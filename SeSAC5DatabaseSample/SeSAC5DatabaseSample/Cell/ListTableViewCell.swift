//
//  ListTableViewCell.swift
//  SeSAC5DatabaseSample
//
//  Created by jack on 7/2/24.
//

import UIKit
import SnapKit

class ListTableViewCell: BaseTableViewCell {
    
    let thumbnailImageView = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let overviewLabel = UILabel()

    func testUI() {
        thumbnailImageView.backgroundColor = .black
        titleLabel.text = "Asdfsafd"
        subTitleLabel.text = "ASdfdsafd"
        overviewLabel.text = "Asdfdsasdf"
    }
    
    override func configureLayout() {
        thumbnailImageView.snp.makeConstraints { make in
          make.leading.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
          make.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
          make.trailing.top.equalTo(contentView.safeAreaLayoutGuide).inset(16)
          make.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
          make.height.equalTo(18)
        }
        
        subTitleLabel.snp.makeConstraints { make in
          make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
          make.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
          make.top.equalTo(titleLabel.snp.bottom)
          make.height.equalTo(18)
        }
        
        overviewLabel.snp.makeConstraints { make in
          make.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
          make.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
          make.top.equalTo(subTitleLabel.snp.bottom)
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(overviewLabel)
    }
    
    override func configureView() {
        thumbnailImageView.contentMode = .scaleAspectFill
        overviewLabel.numberOfLines = 0
        overviewLabel.font = .systemFont(ofSize: 13)
    }
}
