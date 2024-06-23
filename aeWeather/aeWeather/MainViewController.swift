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
    
    private let backgroundView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.6)
        
        return view
    }()
    
    private let locationIconImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.fill")
        imageView.tintColor = .black
        
        return imageView
    }()
    
    private let locationLabel = {
        let label = UILabel()
        label.font = UIFont(name: "GowunBatang-Regular", size: 18)
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
        
        return button
    }()
    
    lazy private var refreshButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(refreshButtonClicked), for: .touchUpInside)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    private let letterView = UIView()
    
    private let toUserLabel = {
        let label = UILabel()
        label.font = UIFont(name: "GowunBatang-Regular", size: 20)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "To. User"
        
        return label
    }()
    
    private let letterContentsLabel = {
        let label = UILabel()
        label.font = UIFont(name: "GowunBatang-Regular", size: 20)
        label.textAlignment = .left
        label.textColor = .black
        label.text = "안녕하세요 민채님\n지금은 9도 예요.\n78% 만큼 습해요.\n1m/s의 바람이 불어요\n\n오늘도 행복한 하루가 되길 바래요."
        label.numberOfLines = 6
        
        return label
    }()
    
    lazy private var dateLabel = {
        let label = UILabel()
        label.font = UIFont(name: "GowunBatang-Regular", size: 16)
        label.textAlignment = .left
        label.textColor = .black
        label.text = self.makeDate()
        
        return label
    }()
    
    private let fromWeatherLabel = {
        let label = UILabel()
        label.font = UIFont(name: "GowunBatang-Regular", size: 20)
        label.text = "From. 날씨"
        label.textAlignment = .left
        label.textColor = .black
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        setupBackgroundVideo()
        
        requestUserLocation()
    }
    
    private func requestUserLocation() {
        LocationManager.shared.updateUserLocation = { coordinate in
            print(coordinate.latitude, coordinate.longitude)
        }
    }
    
    private func configureUI() {
        view.addSubview(backgroundView)
        view.addSubview(locationIconImageView)
        view.addSubview(locationLabel)
        view.addSubview(settingButton)
        view.addSubview(refreshButton)
        view.addSubview(letterView)
        
        configureLetterView()
        configureLayout()
    }
    
    private func configureLetterView() {
        letterView.addSubview(toUserLabel)
        letterView.addSubview(letterContentsLabel)
        letterView.addSubview(dateLabel)
        letterView.addSubview(fromWeatherLabel)
        
        toUserLabel.snp.makeConstraints { make in
            make.top.equalTo(letterView.snp.top)
            make.horizontalEdges.equalTo(letterView.snp.horizontalEdges)
            make.height.equalTo(20)
        }
        
        letterContentsLabel.snp.makeConstraints { make in
            make.top.equalTo(toUserLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(letterView.snp.horizontalEdges)
            make.height.equalTo(200)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(letterContentsLabel.snp.bottom).offset(50)
            make.leading.equalTo(letterView.snp.leading)
            make.height.equalTo(18)
        }
        
        fromWeatherLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dateLabel.snp.bottom)
            make.trailing.equalTo(letterView.snp.trailing)
            make.height.equalTo(20)
        }
    }
    
    private func configureLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.snp.trailing).inset(30)
            make.size.equalTo(23)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(refreshButton.snp.leading).inset(-10)
            make.size.equalTo(23)
        }
        
        locationIconImageView.snp.makeConstraints { make in
            make.bottom.equalTo(settingButton.snp.bottom)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.size.equalTo(15)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.bottom.equalTo(settingButton.snp.bottom)
            make.leading.equalTo(locationIconImageView.snp.trailing).offset(8)
            make.height.equalTo(18)
        }
        
        letterView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY).offset(-50)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(30)
            make.height.equalTo(300)
        }
    }
    
    private func setupBackgroundVideo() {
        guard let path = Bundle.main.path(forResource: "fineVideo", ofType: "mp4") else {
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
    
    // 비디오 루프를 위해 처음으로 이동
    @objc func playerItemDidReachEnd() {
        player?.seek(to: .zero)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func settingButtonClicked() {
        
    }
    
    @objc private func refreshButtonClicked() {
        
    }
    
    func makeDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 dd일 HH시 mm분"
        let currentDate = formatter.string(from: Date())
        
        return currentDate
    }
}

