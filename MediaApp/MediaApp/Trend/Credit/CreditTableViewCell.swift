//
//  CreditTableViewCell.swift
//  MediaApp
//
//  Created by 황민채 on 6/11/24.
//

import UIKit

import SnapKit

class CreditTableViewCell: UITableViewCell {
    
    let actorProfieImageView : UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.layer.cornerRadius = 5
        
        return v
    }()
    
    let actorName: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 15)
        v.textColor = .white
        
        return v
    }()
    
    let roleName: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 13)
        v.textColor = .lightGray
        
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
        configureView()
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        contentView.addSubview(actorProfieImageView)
        contentView.addSubview(actorName)
        contentView.addSubview(roleName)
        
        configureLayout()
    }
    
    func configureLayout() {
        actorProfieImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(5)
            //make.centerY.equalTo(contentView.snp.centerX)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.width.equalTo(45)
        }
        
        actorName.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalTo(actorProfieImageView.snp.trailing).offset(20)
            make.height.equalTo(20)
        }
        
        roleName.snp.makeConstraints { make in
            make.top.equalTo(actorName.snp.bottom).offset(5)
            make.leading.equalTo(actorProfieImageView.snp.trailing).offset(20)
            make.height.equalTo(15)
        }
    }
}
