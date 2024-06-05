//
//  MovieTableViewCell.swift
//  MovieBoxOffice
//
//  Created by 황민채 on 6/5/24.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieTableViewCell"
    
    let rankingLabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 17)
        
        return label
    }()
    
    let movieTitleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        
        return label
    }()
    
    let openDateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        
        return label
    }()
    
    let allView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(allView)
        
        allView.addSubview(rankingLabel)
        allView.addSubview(movieTitleLabel)
        allView.addSubview(openDateLabel)
        
        allView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        rankingLabel.snp.makeConstraints { make in
            make.top.equalTo(allView.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(allView.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(35)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(allView.safeAreaLayoutGuide).offset(5)
            make.leading.equalTo(rankingLabel.snp_trailingMargin).offset(20)
            make.height.equalTo(50)
        }
        
        openDateLabel.snp.makeConstraints { make in
            make.top.equalTo(allView.safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(allView.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(80)
            make.leading.equalTo(movieTitleLabel.snp_trailingMargin).offset(20)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
