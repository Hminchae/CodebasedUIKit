//
//  ViewController.swift
//  aeWeather
//
//  Created by 황민채 on 6/22/24.
//

import UIKit
import SnapKit
import AVFoundation

class MainViewController: UIViewController {
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
//    private let backgroundImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.image = UIImage(named: "rain")
//        
//        return imageView
//    }()
    
    private let locationIconImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.fill")
        imageView.tintColor = .black
        
        return imageView
    }()
    
    private let locationLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "서울시 동작구"
        
        return label
    }()
    
    lazy private var settingButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(settingButtonClicked), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        return button
    }()

    lazy private var refreshButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(refreshButtonClicked), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        return button
    }()
    
    private let toUserLabel = {
        let label = UILabel()
        label.font = UIFont(name: "Ownglyph_jooreeletter-Rg", size: 24)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "To. User"
        
        return label
    }()
    
    private let letterContentsLabel = {
        let label = UILabel()
        label.font = UIFont(name: "Ownglyph_jooreeletter-Rg", size: 24)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "안녕하세요 민채님\n지금은 9도 예요.\n78% 만큼 습해요.\n1m/s의 바람이 불어요\n\n오늘도 행복한 하루가 되길 바래요."
        label.numberOfLines = 6
        
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.font = UIFont(name: "Ownglyph_jooreeletter-Rg", size: 20)
        label.textAlignment = .left
        label.textColor = .black
        
        return label
    }()
    
    private let fromWeatherLabel = {
        let label = UILabel()
        label.font = UIFont(name: "Ownglyph_jooreeletter-Rg", size: 24)
        label.text = "From. 너의 날씨"
        label.textAlignment = .left
        label.textColor = .black
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        setupBackgroundVideo()
        
    }
    
    private func configureUI() {
        //view.addSubview(backgroundImageView)
        view.addSubview(locationIconImageView)
        view.addSubview(locationLabel)
        view.addSubview(settingButton)
        view.addSubview(refreshButton)
        view.addSubview(toUserLabel)
        view.addSubview(letterContentsLabel)
        view.addSubview(dateLabel)
        view.addSubview(fromWeatherLabel)
        
        configureLayout()
    }
    
    private func configureLayout() {
//        backgroundImageView.snp.makeConstraints { make in
//            make.edges.equalTo(view.snp.edges)
//        }
        
        locationIconImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.centerY.equalTo(locationLabel.snp.centerY)
            make.size.equalTo(30)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(locationIconImageView.snp.trailing).offset(8)
            make.height.equalTo(30)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).inset(20)
            make.centerY.equalTo(locationLabel.snp.centerY)
            make.size.equalTo(30)
        }
        
        settingButton.snp.makeConstraints { make in
            make.centerY.equalTo(locationLabel.snp.centerY)
            make.trailing.equalTo(refreshButton.snp.leading).inset(-8)
            make.size.equalTo(30)
        }
        
        toUserLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(20)
        }
        
        letterContentsLabel.snp.makeConstraints { make in
            make.top.equalTo(toUserLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(200)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(letterContentsLabel.snp.bottom).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.height.equalTo(20)
        }
        
        fromWeatherLabel.snp.makeConstraints { make in
            make.top.equalTo(letterContentsLabel.snp.bottom).offset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(20)
        }
    }
    
    private func setupBackgroundVideo() {
           guard let path = Bundle.main.path(forResource: "rainVideo", ofType: "mp4") else {
               print("Background video not found.")
               return
           }

           let url = URL(fileURLWithPath: path)
           player = AVPlayer(url: url)
           playerLayer = AVPlayerLayer(player: player)
           playerLayer?.frame = view.bounds
           playerLayer?.videoGravity = .resizeAspectFill
           view.layer.insertSublayer(playerLayer!, at: 0)

           player?.actionAtItemEnd = .none
           NotificationCenter.default.addObserver(
               self,
               selector: #selector(playerItemDidReachEnd),
               name: .AVPlayerItemDidPlayToEndTime,
               object: player?.currentItem
           )

           player?.play()
       }

       @objc func playerItemDidReachEnd() {
           player?.seek(to: .zero)  // 비디오 루프를 위해 처음으로 이동
       }
       
       deinit {
           NotificationCenter.default.removeObserver(self)
       }
    
    @objc private func settingButtonClicked() {
        
    }
    
    @objc private func refreshButtonClicked() {
        
    }
}

