//
//  WishCollectionViewCell.swift
//  MediaApp
//
//  Created by 황민채 on 6/30/24.
//

import UIKit

final class WishCollectionViewCell: BaseCollectionViewCell {
    
    private var containerView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
        view.backgroundColor = .container
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    var movieImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private var dashedLineView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        
        return view
    }()
    
    // 제목
    // 상영시간
    // 날짜 | 평점 | 봤어요
    
    var movieTitleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    var filmRateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private let releaseDateTitleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "개봉날짜"
        
        return label
    }()
    
    var releaseDateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        
        return label
    }()
    
    private let leftSeparator = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    private let voteAverageTitleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "평점"
        
        return label
    }()
    
    var voteAverageLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        
        return label
    }()
    
    private let rightSeparator = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    var sawButton = UIButton()
    
    override func configureHierarchy() {
        contentView.addSubview(containerView)
    }
    
    override func configureView() {
        configureContainerView()
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.snp.edges)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dashedLineView.setDashedLineView()
    }
    
    private func configureContainerView() {
        containerView.addSubview(movieImageView)
        containerView.addSubview(dashedLineView)
        containerView.addSubview(movieTitleLabel)
        containerView.addSubview(releaseDateTitleLabel)
        containerView.addSubview(releaseDateLabel)
        containerView.addSubview(leftSeparator)
        containerView.addSubview(voteAverageTitleLabel)
        containerView.addSubview(voteAverageLabel)
        containerView.addSubview(rightSeparator)
        containerView.addSubview(sawButton)
        
        movieImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges)
            make.height.equalTo(containerView).multipliedBy(0.7)
        }
        
        dashedLineView.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom)
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dashedLineView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(10)
            make.height.equalTo(25)
        }
        
        // 릴리즈 날짜
        releaseDateTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(18)
            make.trailing.equalTo(leftSeparator.snp.leading).offset(-1)
            make.width.equalTo(90)
            make.height.equalTo(15)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateTitleLabel.snp.bottom).offset(5)
            make.trailing.equalTo(leftSeparator.snp.leading).offset(-1)
            make.width.equalTo(90)
            make.height.equalTo(17)
        }
        
        leftSeparator.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.trailing.equalTo(voteAverageTitleLabel.snp.leading).offset(-1)
            make.top.equalTo(releaseDateTitleLabel.snp.top).offset(2)
            make.bottom.equalTo(releaseDateLabel.snp.bottom).offset(-2)
        }
        
        // 투표 평점
        voteAverageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(18)
            make.centerX.equalTo(containerView.snp.centerX)
            make.width.equalTo(90)
            make.height.equalTo(15)
        }
        
        voteAverageLabel.snp.makeConstraints { make in
            make.top.equalTo(voteAverageTitleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(containerView.snp.centerX)
            make.width.equalTo(90)
            make.height.equalTo(17)
        }
        
        rightSeparator.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.leading.equalTo(voteAverageTitleLabel.snp.trailing).offset(1)
            make.top.equalTo(releaseDateTitleLabel.snp.top).offset(2)
            make.bottom.equalTo(releaseDateLabel.snp.bottom).offset(-2)
        }
        
        sawButton.snp.makeConstraints { make in
            make.centerY.equalTo(voteAverageLabel.snp.top)
            make.centerX.equalTo(voteAverageLabel.snp.trailing).offset(45)
            make.size.equalTo(50)
        }
    }
}
