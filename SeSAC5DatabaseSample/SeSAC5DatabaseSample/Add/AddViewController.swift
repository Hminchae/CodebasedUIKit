//
//  AddViewController.swift
//  SeSAC5DatabaseSample
//
//  Created by jack on 7/2/24.
//

import UIKit

import SnapKit
import RealmSwift

class AddViewController: BaseViewController {
     
    let moneyButton = UIButton()
    let categoryButton = UIButton()
    let memoButton = UIButton()
    let photoImageView = UIImageView()
    let addButton = UIButton()
     
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    override func configureHierarchy() {
        view.addSubview(moneyButton)
        view.addSubview(categoryButton)
        view.addSubview(memoButton)
        view.addSubview(photoImageView)
        view.addSubview(addButton)
    }
    
    @objc func saveButtonClicked() {
        print(#function)
          // Create 1️⃣
        let realm = try! Realm() // 데이터가 있는 위치를 찾아가는 코드
        
        let data = TodoTable(momoTitle: "메모 제목 \(Int.random(in: 1...100))", memoContent: nil, money: Int.random(in: 1...100) * 1000, category: "식비", resisterDate: Date())
        try! realm.write {
            realm.add(data)
            print("Realm Create Succeed")
        }
    }
    
    override func configureView() {
        super.configureView()
        
        addButton.backgroundColor = .black
        addButton.setTitleColor(.white, for: .normal)
        addButton.setTitle("이미지 추가", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        photoImageView.backgroundColor = .lightGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        moneyButton.backgroundColor = .black
        moneyButton.setTitleColor(.white, for: .normal)
        moneyButton.setTitle("금액", for: .normal)
        moneyButton.addTarget(self, action: #selector(moneyButtonClicked), for: .touchUpInside)
        
        categoryButton.backgroundColor = .black
        categoryButton.setTitleColor(.white, for: .normal)
        categoryButton.setTitle("카테고리", for: .normal)
        categoryButton.addTarget(self, action: #selector(categoryButtonClicked), for: .touchUpInside)
        
        memoButton.backgroundColor = .black
        memoButton.setTitleColor(.white, for: .normal)
        memoButton.setTitle("메모", for: .normal)
        memoButton.addTarget(self, action: #selector(memoButtonClicked), for: .touchUpInside)
    }
    
    override func configureConstraints() {
         
        moneyButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        categoryButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(moneyButton.snp.bottom).offset(20)
        }
        
        memoButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(categoryButton.snp.bottom).offset(20)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view)
            make.top.equalTo(memoButton.snp.bottom).offset(20)
        }
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
        }
    }
    
    @objc func addButtonClicked() {
        print(#function)
    }
    
    @objc func memoButtonClicked() {
        
        let vc = MemoViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }

    @objc func moneyButtonClicked() {
        
        let vc = MoneyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func categoryButtonClicked() {
        
        let vc = CategoryViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
