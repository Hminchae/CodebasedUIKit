//
//  DetailPosterCollectionCell.swift
//  MediaApp
//
//  Created by 황민채 on 6/27/24.
//

import UIKit

class DetailPosterCollectionCell: BaseCollectionViewCell {
    
    let posterHeaderImageView = UIImageView()
    
    var isVisibleOverView: Bool = true {
        didSet {
            gradientView.isHidden = !isVisibleOverView
        }
    }
    
    let gradientView = UIView()
    let movieTitleLabel = UILabel()
    let movieOverViewLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientView.frame = bounds
        gradientView.setGradient(color1: .clear, color2: .black)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(posterHeaderImageView)
        contentView.addSubview(gradientView)
    }
    
    override func configureLayout() {
        posterHeaderImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        gradientView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(posterHeaderImageView)
            make.height.equalTo(posterHeaderImageView.snp.height).multipliedBy(0.8)
        }
    }
    
    override func configureView() {
        configureGradientView()
        
        posterHeaderImageView.backgroundColor = .black.withAlphaComponent(0.7)
        posterHeaderImageView.contentMode = .scaleAspectFill
        posterHeaderImageView.clipsToBounds = true
        
        movieTitleLabel.font = .boldSystemFont(ofSize: 22)
        movieTitleLabel.textColor = .white
        
        movieOverViewLabel.font = .systemFont(ofSize: 13)
        movieOverViewLabel.textColor = .white
        movieOverViewLabel.lineBreakMode = .byWordWrapping
        movieOverViewLabel.numberOfLines = 0
    }
    
    private func configureGradientView() {
        gradientView.addSubview(movieTitleLabel)
        gradientView.addSubview(movieOverViewLabel)
        
        movieTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(gradientView.snp.horizontalEdges).inset(12)
            make.height.equalTo(22)
            make.bottom.equalTo(movieOverViewLabel.snp.top).offset(-12)
        }
        
        movieOverViewLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(gradientView.snp.horizontalEdges).inset(12)
            make.bottom.equalTo(gradientView.snp.bottom).inset(15)
        }
    }
}

