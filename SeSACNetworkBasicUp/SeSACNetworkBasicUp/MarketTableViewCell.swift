//
//  MarketTableViewCell.swift
//  SeSACNetworkBasicUp
//
//  Created by 황민채 on 6/5/24.
//

import UIKit
import SnapKit

class MarketTableViewCell: UITableViewCell {
    static let identifier = "MarketTableViewCell"
    let nameLabel = UILabel()
    
    // ✏️ NIB == XIB >>> XIB가 없다면 이 코드는 실행 X
    // ⬇️ 그릇을 세팅해주는 초기화 구문
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // codebase에선 awakeFrmoNib 를 못쓰기때문에 아래 초기화 구문을 사용하여야 함
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // VC view => contentView
        // ✅ contentView.addSubview 를 해야 버튼 동작에 이슈가 없음
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        nameLabel.textColor = .brown
        nameLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
