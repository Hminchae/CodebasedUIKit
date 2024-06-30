//
//  WishViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/24/24.
//

import UIKit

class WishViewController: UIViewController {
    
    var movieId: Int? = 786892
    
    let flowLayout = ZoomAndSnapFlowLayout()
    var collectionView: UICollectionView!
    
    var movieDetailInfo: MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "WishList"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionView()
        configureNetwork()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.dataSource = self
        collectionView.register(WishCollectionViewCell.self, forCellWithReuseIdentifier: WishCollectionViewCell.identifier)
        collectionView.contentInsetAdjustmentBehavior = .always
    }
    
    private func configureNetwork() {
        guard let movieId = movieId else { return }
        
        DispatchQueue.global().async {
            NetworkManager.shared.detailMovieCallRequest(api: .movieDetail(movieID: movieId)
            ) { result in
                switch result {
                case .success(let value):
                    DispatchQueue.main.async {
                        print(value)
                        self.movieDetailInfo = value
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension WishViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishCollectionViewCell.identifier, for: indexPath) as? WishCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let movieDetailInfo = movieDetailInfo {
            let imageUrl = movieDetailInfo.backdropPath
            let url = URL(string: MediaAPI.imageURL(imagePath: imageUrl).entireUrl)
            cell.movieImageView.kf.setImage(with: url)
            cell.movieTitleLabel.text = movieDetailInfo.title
            cell.releaseDateLabel.text = movieDetailInfo.releaseDate?.transDateString(from: "yyyy-MM-dd", to: "yyyy.MM.dd")
            cell.voteAverageLabel.text = String(Double(Int(movieDetailInfo.voteAverage * 10)) / 10)
            
            // 봤어요 버튼 관련
            cell.sawButton.backgroundColor = sawMovie ? .white : .black.withAlphaComponent(0.5)
            cell.sawButton.tintColor = sawMovie ? .black : .white
            cell.sawButton.setImage(sawMovie ? UIImage(systemName: "sunglasses.fill") : UIImage(systemName: "sunglasses") , for: .normal)
            cell.sawButton.tag = indexPath.row
            cell.sawButton.addTarget(self, action: #selector(sawButtonClicked), for: .touchUpInside)
        }
        
        return cell
    }
    
    @objc private func sawButtonClicked(_ sender: UIButton) {
        let index = sender.tag
        guard let targetId = movieId else { return }
        
        basketDictionary[targetId] = !(basketDictionary[targetId] ?? false)
        collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
}
