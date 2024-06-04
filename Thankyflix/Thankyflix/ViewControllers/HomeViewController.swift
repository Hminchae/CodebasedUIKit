//
//  HomeViewController.swift
//  Thankyflix
//
//  Created by 황민채 on 6/4/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let topTitle = UILabel()
    
    let mainPosterUIView = UIView()
    let mainPosterImageView = UIImageView()
    let playButton = UIButton()
    let pickButton = UIButton()
    
    let risingContentsLabel = UILabel()
    let risingContentsStack = UIStackView()
    
    let firstContent = UIImageView()
    let secondContent = UIImageView()
    let thirdContent = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureHierarchy()
        
        configureTopTitleLayout()
        configureMainPosterView()
        
        configureUI()
        
        configureRisingContentsView()
    }
    
    func configureHierarchy() {
        view.addSubview(topTitle)
        view.addSubview(mainPosterUIView)
        
        mainPosterUIView.addSubview(mainPosterImageView)
        mainPosterUIView.addSubview(playButton)
        mainPosterUIView.addSubview(pickButton)
        
        view.addSubview(risingContentsLabel)
        view.addSubview(risingContentsStack)
    }
    
    func configureTopTitleLayout() {
        topTitle.translatesAutoresizingMaskIntoConstraints = false // 오토리사이징 off
        
        let top = NSLayoutConstraint(item: topTitle,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: view,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: 50)
        
        let leading = NSLayoutConstraint(item: topTitle,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: view,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: 50)
        
        let trailing = NSLayoutConstraint(item: topTitle,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: -50)
        
        let height = NSLayoutConstraint(item: topTitle,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 20)
        view.addConstraints([top, leading, trailing, height])
    }
    
    func configureMainPosterView() {
        mainPosterUIView.translatesAutoresizingMaskIntoConstraints = false
        mainPosterImageView.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        pickButton.translatesAutoresizingMaskIntoConstraints = false
        risingContentsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // UIView
        NSLayoutConstraint.activate([
            mainPosterUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainPosterUIView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            mainPosterUIView.heightAnchor.constraint(equalToConstant: 450),
            mainPosterUIView.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: 15)
        ])
        
        // UIImageView
        NSLayoutConstraint.activate([
            mainPosterImageView.centerXAnchor.constraint(equalTo: mainPosterUIView.centerXAnchor),
            mainPosterImageView.widthAnchor.constraint(equalTo: mainPosterUIView.widthAnchor),
            mainPosterImageView.heightAnchor.constraint(equalTo: mainPosterUIView.heightAnchor),
            mainPosterImageView.topAnchor.constraint(equalTo: mainPosterUIView.topAnchor)
        ])
        
        // Buttons
        NSLayoutConstraint.activate([
            playButton.widthAnchor.constraint(equalTo: mainPosterUIView.widthAnchor, multiplier: 0.5, constant: -20),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.bottomAnchor.constraint(equalTo: mainPosterUIView.bottomAnchor, constant: -10),
            playButton.leadingAnchor.constraint(equalTo: mainPosterUIView.leadingAnchor, constant: 10),
            
            pickButton.widthAnchor.constraint(equalTo: playButton.widthAnchor),
            pickButton.heightAnchor.constraint(equalTo: playButton.heightAnchor),
            pickButton.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
            pickButton.trailingAnchor.constraint(equalTo: mainPosterUIView.trailingAnchor, constant: -10),
            pickButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 20)
        ])
        
        // label
        NSLayoutConstraint.activate([
            risingContentsLabel.widthAnchor.constraint(equalTo: mainPosterUIView.widthAnchor, multiplier: 1, constant: -40),
            risingContentsLabel.heightAnchor.constraint(equalToConstant: 25),
            risingContentsLabel.topAnchor.constraint(equalTo: mainPosterUIView.bottomAnchor, constant: 10)
        ])
    }
    
    func configureRisingContentsView() {
        risingContentsStack.translatesAutoresizingMaskIntoConstraints = false // 오토 레이아웃 사용 설정
        risingContentsStack.axis = .horizontal
        risingContentsStack.spacing = 10
        risingContentsStack.distribution = .fillEqually
        risingContentsStack.alignment = .fill
        risingContentsStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        risingContentsStack.isLayoutMarginsRelativeArrangement = true
        
        risingContentsStack.addArrangedSubview(firstContent)
        risingContentsStack.addArrangedSubview(secondContent)
        risingContentsStack.addArrangedSubview(thirdContent)
        
        NSLayoutConstraint.activate([
            risingContentsStack.topAnchor.constraint(equalTo: risingContentsLabel.bottomAnchor, constant: 5),
            risingContentsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            risingContentsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            risingContentsStack.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
    func configureUI() {
        topTitle.text = "Thanky님"
        topTitle.font = .boldSystemFont(ofSize: 20)
        topTitle.textColor = .white
        topTitle.textAlignment = .center
        
        mainPosterImageView.image = UIImage(named: "노량")
        mainPosterImageView.clipsToBounds = true
        mainPosterImageView.layer.cornerRadius = 10
        
        playButton.backgroundColor = .white
        playButton.setTitle(" 재생", for: .normal)
        playButton.tintColor = .black
        playButton.layer.cornerRadius = 7
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        
        pickButton.backgroundColor = .darkGray
        pickButton.setTitle(" 내가 찜한 리스트", for: .normal)
        pickButton.tintColor = .white
        pickButton.layer.cornerRadius = 7
        pickButton.setImage(UIImage(systemName: "plus"), for: .normal)
        pickButton.setTitleColor(.white, for: .normal)
        pickButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        firstContent.image = UIImage(named: "밀수")
        firstContent.clipsToBounds = true
        firstContent.layer.cornerRadius = 7
        
        secondContent.image = UIImage(named: "범죄도시3")
        secondContent.clipsToBounds = true
        secondContent.layer.cornerRadius = 7
        
        thirdContent.image = UIImage(named: "육사오")
        thirdContent.clipsToBounds = true
        thirdContent.layer.cornerRadius = 7
        
        risingContentsLabel.text = "지금 뜨는 콘텐츠"
        risingContentsLabel.textColor = .white
    }
    
    // 임시 로그인 버튼 액션
    @objc func playButtonTapped() {
        let vc = LoginViewController()
        present(vc, animated: true)
    }
}

