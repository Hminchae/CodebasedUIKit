//
//  HorizontalScrollViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/11/24.
//

import UIKit

import SnapKit

class HorizontalScrollViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let imageView = UIImageView()
    let label = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierachy()
    }
    
    func configureHierachy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        configureLayout()
        configureContentView()
    }
    
    func configureLayout() {
        scrollView.backgroundColor = .lightGray
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        
        contentView.backgroundColor = .systemMint
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width) // 가로는 정해주기!
            make.verticalEdges.equalTo(scrollView)
        }
    }
    
    func configureContentView() {
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        contentView.addSubview(button)
        
        label.backgroundColor = .orange
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            //make.bottom.equalTo(imageView.snp.top).inset(20)
            make.height.equalTo(400)
        }
        
        button.backgroundColor = .systemBlue
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.bottom.equalTo(imageView.snp.top).offset(-20)
        }
        
        imageView.backgroundColor = .systemPink
        imageView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(400)
        }
    }
}
