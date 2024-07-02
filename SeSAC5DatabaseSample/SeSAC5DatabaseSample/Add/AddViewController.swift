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
    let titleTextField = UITextField()
    let contentTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(moneyButton)
        view.addSubview(categoryButton)
        view.addSubview(memoButton)
        view.addSubview(photoImageView)
        view.addSubview(addButton)
        view.addSubview(titleTextField)
        view.addSubview(contentTextField)
    }
    
    @objc func saveButtonClicked() {
        print(#function)
        // 1. 텍스트필드에 작성한 텍스트가 저장되도록 수정
        // 2. 제목이 비어있다면(isEmpty) 저장되지않고 얼럿 띄우기
        // 3. 저장 완료 이후에는 메인 화면으로 전환
        
        // Create 1️⃣ Realm 위치 찾기
        let realm = try! Realm() // 데이터가 있는 위치를 찾아가는 코드
        
        guard let title = titleTextField.text, !title.isEmpty,
              let content = contentTextField.text
        else {
            // 1.
            let alert = UIAlertController(
                title: "제목이 비어있습니다!!",
                message: "제목은 옵셔널이 아니라서 입력해야합니다ㅡㅡ",
                preferredStyle: .alert)
            
            // 2.
            let confirm = UIAlertAction(
                title: "확인",
                style: .default)
            
            // 3.
            alert.addAction(confirm)
            
            // 4.
            present(alert, animated: true)
            return
        }
        
        let data = TodoTable(momoTitle: title, memoContent: content, money: Int.random(in: 1...100) * 1000, category: "식비", resisterDate: Date())
        try! realm.write {
            realm.add(data)
            print("Realm Create Succeed")
        }
        
        navigationController?.popViewController(animated: true)
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
        
        titleTextField.placeholder = "제목을 입력해보세요"
        contentTextField.placeholder = "내용을 입력해보세요"
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
        
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(addButton.snp.bottom).offset(20)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
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
