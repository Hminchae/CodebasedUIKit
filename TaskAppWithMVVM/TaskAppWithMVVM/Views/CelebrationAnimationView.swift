//
//  CelebrationAnimationView.swift
//  TaskAppWithMVVM
//
//  Created by 황민채 on 6/7/24.
//

import Lottie
import UIKit

class CelebrationAnimationView: UIView {
    
    var animationView: LottieAnimationView
    
    init(fileName: String) {
        let animation = LottieAnimation.named(fileName)
        self.animationView = LottieAnimationView(animation: animation)
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        addSubview(animationView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func play(completion: @escaping (Bool) -> Void) {
        animationView.play(completion: completion)
    }
}
