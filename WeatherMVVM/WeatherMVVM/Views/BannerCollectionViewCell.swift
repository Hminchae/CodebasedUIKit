//
//  BannerCollectionViewCell.swift
//  WeatherMVVM
//
//  Created by 황민채 on 7/13/24.
//

import UIKit

import SnapKit
import Kingfisher

class BannerCollectionViewCell: BaseCollectionViewCell {
    
    let locationLabel = UILabel()
    let temperatureLabel = UILabel()
    let descriptionLabel = UILabel()
    let maxMinTempLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(locationLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(maxMinTempLabel)
    }
    
    override func configureLayout() {
        
        locationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.snp.top).offset(30)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom).offset(3)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom).offset(3)
        }
        
        maxMinTempLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(3)
        }
    }
    
    override func configureView() {
    
        locationLabel.textAlignment = .center
        temperatureLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        maxMinTempLabel.textAlignment = .center
        
        locationLabel.font = WEFont.M30
        temperatureLabel.font = WEFont.l80
        descriptionLabel.font = WEFont.b16
        maxMinTempLabel.font = WEFont.m16
        
        locationLabel.textColor = .white
        temperatureLabel.textColor = .white
        descriptionLabel.textColor = .white
        maxMinTempLabel.textColor = .white
    }
    
    public func configDetail(location: String, 
                             temperature: Int,
                             description: String,
                             maxTemp: Int,
                             minTemp: Int
    ) {

        locationLabel.text = location
        temperatureLabel.text = " \(temperature)°"
        descriptionLabel.text = description
        maxMinTempLabel.text = "최고: \(maxTemp)° | 최저: \(minTemp)°"
        
    }
}
