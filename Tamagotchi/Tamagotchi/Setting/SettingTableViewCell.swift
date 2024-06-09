//
//  SettingTableViewCell.swift
//  Tamagotchi
//
//  Created by 황민채 on 6/9/24.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    
   let icon: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.tintColor = .fontColor
       
        return v
    }()
    
    let settingName: UILabel = {
        let v = UILabel()
        v.textColor = .black
        v.font = .boldSystemFont(ofSize: 15)
        
        return v
    }()
    
    let detailName: UILabel = {
        let v = UILabel()
        v.textColor = .lightGray
        v.font = .systemFont(ofSize: 15)
        v.textAlignment = .right
        
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
        contentView.addSubview(icon)
        contentView.addSubview(settingName)
        contentView.addSubview(detailName)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        icon.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.verticalEdges.equalTo(contentView.snp.verticalEdges)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.width.equalTo(20)
        }
        
        settingName.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(5)
            make.leading.equalTo(icon.snp.trailing).offset(20)
        }
        
        detailName.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
        }
    }
}
