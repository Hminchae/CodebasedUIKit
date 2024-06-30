//
//  WishViewController.swift
//  MediaApp
//
//  Created by 황민채 on 6/24/24.
//

import UIKit

class WishViewController: UIViewController {
    
    private var user = UserDefaultManager.shared
    
    let flowLayout = ZoomAndSnapFlowLayout()
    
    var collectionView: UICollectionView!
    var movieDetailInfo: [MovieDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "WishList"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .point
        
        configureCollectionView()
        configureNetwork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WishCollectionViewCell.self, forCellWithReuseIdentifier: WishCollectionViewCell.identifier)
        collectionView.contentInsetAdjustmentBehavior = .always
    }
    
    private func configureNetwork() {
        guard user.movieWishList != [] else { return }
        
        for movieId in user.movieWishList {
            DispatchQueue.global().async {
                NetworkManager.shared.detailMovieCallRequest(api: .movieDetail(movieID: movieId)
                ) { result in
                    switch result {
                    case .success(let value):
                        DispatchQueue.main.async {
                            self.movieDetailInfo.append(value)
                            self.collectionView.reloadData()
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}

extension WishViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDetailInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishCollectionViewCell.identifier, for: indexPath) as? WishCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = movieDetailInfo[indexPath.row]
        
        let imageUrl = data.backdropPath
        let url = URL(string: MediaAPI.imageURL(imagePath: imageUrl).entireUrl)
        cell.movieImageView.kf.setImage(with: url)
        
        cell.movieTitleLabel.text = data.title
        cell.releaseDateLabel.text = data.releaseDate?.transDateString(from: "yyyy-MM-dd", to: "yyyy.MM.dd")
        cell.voteAverageLabel.text = String(Double(Int(data.voteAverage * 10)) / 10)
        
        // 봤어요 버튼 관련
        let sawMovie = user.movieSawDictionary[data.id] ?? false
        
        cell.sawButton.tintColor = sawMovie ? .point : .white
        cell.sawButton.setImage(sawMovie ? UIImage(systemName: "sunglasses.fill") : UIImage(systemName: "sunglasses") , for: .normal)
        cell.sawButton.tag = indexPath.row
        cell.sawButton.addTarget(self, action: #selector(sawButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let data = movieDetailInfo[indexPath.row]
        
        vc.movieId = data.id
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func sawButtonClicked(_ sender: UIButton) {
        let index = sender.tag
        let targetId = user.movieWishList[index]
        
        user.movieSawDictionary[targetId] = !(user.movieSawDictionary[targetId] ?? false)
        
        // 버튼만 깜빡이도록
        if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? WishCollectionViewCell {
            let sawMovie = user.movieSawDictionary[targetId] ?? false
            cell.sawButton.tintColor = sawMovie ? .point : .white
            cell.sawButton.setImage(sawMovie ? UIImage(systemName: "sunglasses.fill") : UIImage(systemName: "sunglasses"), for: .normal)
        }
    }
}
