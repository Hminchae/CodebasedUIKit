//
//  VerticalScrollViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by 황민채 on 7/11/24.
//

import UIKit

import SnapKit

class VerticalScrollViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.backgroundColor = .blue
        
        scrollView.backgroundColor = .yellow
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(50)
        }
        
        stackView.spacing = 10
        
        let label = UILabel()
        label.backgroundColor = .orange
        label.text = "1oda;flj;laksd;flk'a;ldkf;aldkflaf"
        stackView.addArrangedSubview(label)
        
        let label2 = UILabel()
        label2.backgroundColor = .brown
        label2.text = "1oda;flj;laksd;flk'a;ldkf;aldkflaf"
        stackView.addArrangedSubview(label2)
    }
}
