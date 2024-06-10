//
//  TrendTableViewCell.swift
//  MediaApp
//
//  Created by 황민채 on 6/10/24.
//
//
import UIKit

import SnapKit

class TrendTableViewCell: UITableViewCell {
    
    private let dateLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 11)
        v.textColor = .darkGray
        
        return v
    }()
    
    private let categoryLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 17)
        v.textColor = .black
        
        return v
    }()
    
    private let containerView: UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.cornerRadius = 10
        
        return v
    }()

    private let clipButton: UIButton = {
        let v = UIButton()
        v.backgroundColor = .white
        v.tintColor = .black
        v.setImage(UIImage(systemName: "paperclip"), for: .normal)
        v.layer.cornerRadius = 10
        
        return v
    }()
    
    private let mediaImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        
        return v
    }()
    
    private let gradeFrontLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 11)
        v.textColor = .white
        
        return v
    }()
    
    private let gradeFrontLabelView: UIView = {
        let v = UIView()
        v.backgroundColor = .pointColor
        
        return v
    }()
    
    private let gradeBackLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 11)
        v.textColor = .black
        
        return v
    }()
    
    private let gradeBackLabelView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        
        return v
    }()
    
    private let trendTitleLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 17, weight: .medium)
        v.textColor = .black
        
        return v
    }()
    
    private let trendSubtitleLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 13)
        v.textColor = .black
        
        return v
    }()
    
    private let separator: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        
        return v
    }()
    
    private let readMoreLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 13)
        v.textColor = .black
        
        return v
    }()
    
    private let readMoreButton: UIButton = {
        let v = UIButton()
        v.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        v.tintColor = .black
        
        return v
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(containerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
    }
    
    func configureLayout() {
        setGradeView()
        setContainerView()
        configureContainerViewLayout()
        
        // 날짜
        // 카테고리
        // 컨테이너뷰
    }
    
    func configureContainerViewLayout() {
        mediaImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges)
            make.top.equalTo(containerView.snp.top)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.65)
        }
        
        clipButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalTo(containerView.snp.top).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).inset(10)
        }
        
        gradeFrontLabelView.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(15)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.bottom.equalTo(mediaImageView.snp.bottom).inset(10)
        }
        
        gradeBackLabelView.snp.makeConstraints { make in
            make.width.equalTo(gradeFrontLabelView)
            make.height.equalTo(gradeFrontLabelView)
            make.leading.equalTo(gradeFrontLabelView.snp.trailing)
            make.bottom.equalTo(gradeFrontLabelView)
        }
        
        trendTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mediaImageView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(10)
            make.height.equalTo(17)
        }
        
        trendSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(trendTitleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(10)
            make.height.equalTo(15)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(trendSubtitleLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(10)
            make.height.equalTo(1)
        }
        
        readMoreLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(15)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.height.equalTo(15)
        }
        
        readMoreButton.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(15)
            make.trailing.equalTo(containerView.snp.trailing).inset(10)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
    }
    
    func setContainerView() {
        containerView.addSubview(clipButton)
        containerView.addSubview(mediaImageView)
        containerView.addSubview(gradeFrontLabelView)
        containerView.addSubview(gradeBackLabelView)
        containerView.addSubview(trendTitleLabel)
        containerView.addSubview(trendSubtitleLabel)
        containerView.addSubview(separator)
        containerView.addSubview(readMoreLabel)
    }
   
    func setGradeView() {
        gradeFrontLabelView.addSubview(gradeFrontLabel)
        gradeBackLabelView.addSubview(gradeBackLabel)
        
        gradeFrontLabel.snp.makeConstraints { make in
            make.edges.equalTo(gradeFrontLabelView).inset(5)
        }
        
        gradeBackLabel.snp.makeConstraints { make in
            make.edges.equalTo(gradeBackLabelView).inset(5)
        }
    }
}
