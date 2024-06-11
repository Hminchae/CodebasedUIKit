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
    
    let dateLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 13)
        v.textColor = .darkGray
        
        return v
    }()
    
    let categoryLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 17)
        v.textColor = .black
        
        return v
    }()
    
    let containerView: UIView = {
        let v = UIView()
        v.clipsToBounds = true
        v.layer.cornerRadius = 10
        v.layer.borderColor = UIColor.darkGray.cgColor
        v.layer.borderWidth = 0.2
        
        return v
    }()
    
    private let clipButton: UIButton = {
        let v = UIButton()
        v.backgroundColor = .white
        v.tintColor = .black
        v.setImage(UIImage(systemName: "paperclip"), for: .normal)
        v.layer.cornerRadius = 15
        
        return v
    }()
    
    let mediaImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        
        return v
    }()
    
    private let gradeFrontLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 13)
        v.textColor = .white
        v.text = "평점"
        
        return v
    }()
    
    private let gradeFrontLabelView: UIView = {
        let v = UIView()
        v.backgroundColor = .pointColor
        
        return v
    }()
    
    let gradeBackLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 13)
        v.textColor = .black
        v.textAlignment = .center
        
        return v
    }()
    
    private let gradeBackLabelView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        
        return v
    }()
    
    let trendTitleLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 17, weight: .medium)
        v.textColor = .black
        
        return v
    }()
    
    let trendSubtitleLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 13)
        v.textColor = .darkGray
        
        return v
    }()
    
    private let separator: UIView = {
        let v = UIView()
        v.backgroundColor = .darkGray
        
        return v
    }()
    
    let readMoreLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 13)
        v.textColor = .black
        v.text = "자세히 보기"
        
        return v
    }()
    
    let readMoreButton: UIButton = {
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
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        setGradeView()
        setContainerView()
        configureContainerViewLayout()

        
        // 날짜
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.width.equalTo(200)
            make.height.equalTo(13)
        }
        // 카테고리
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.height.equalTo(20)
        }
        // 컨테이너뷰
        containerView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(7)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges).inset(15)
            make.height.equalTo(containerView.snp.width)
        }
    }
    
    func configureContainerViewLayout() {
        mediaImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges)
            make.top.equalTo(containerView.snp.top)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.67)
        }
        
        clipButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.top.equalTo(containerView.snp.top).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).inset(10)
        }
        
        gradeFrontLabelView.snp.makeConstraints { make in
            make.width.equalTo(33)
            make.height.equalTo(23)
            make.leading.equalTo(containerView.snp.leading).offset(18)
            make.bottom.equalTo(mediaImageView.snp.bottom).inset(18)
        }
        
        gradeBackLabelView.snp.makeConstraints { make in
            make.width.equalTo(gradeFrontLabelView)
            make.height.equalTo(gradeFrontLabelView)
            make.leading.equalTo(gradeFrontLabelView.snp.trailing)
            make.bottom.equalTo(gradeFrontLabelView)
        }
        
        trendTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mediaImageView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(20)
            make.height.equalTo(17)
        }
        
        trendSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(trendTitleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(20)
            make.height.equalTo(15)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(trendSubtitleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(20)
            make.height.equalTo(1)
        }
        
        readMoreLabel.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom).inset(15)
            make.leading.equalTo(containerView.snp.leading).offset(20)
            make.height.equalTo(20)
        }
        
        readMoreButton.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom).inset(15)
            make.trailing.equalTo(containerView.snp.trailing).inset(20)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
    }
    
    func setContainerView() {
        containerView.addSubview(mediaImageView)
        containerView.addSubview(gradeFrontLabelView)
        containerView.addSubview(gradeBackLabelView)
        containerView.addSubview(trendTitleLabel)
        containerView.addSubview(trendSubtitleLabel)
        containerView.addSubview(separator)
        containerView.addSubview(readMoreLabel)
        containerView.addSubview(readMoreButton)
        containerView.addSubview(clipButton)
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
