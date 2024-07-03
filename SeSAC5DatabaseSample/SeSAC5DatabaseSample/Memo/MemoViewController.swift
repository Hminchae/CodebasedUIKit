//
//  MemoViewController.swift
//  SeSAC5DatabaseSample
//
//  Created by jack on 7/2/24.
//

import UIKit
import SnapKit
 
class MemoViewController: BaseViewController {

    let memoTextField = UITextField()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver( //post보다 addObserver 가 항상 먼저 등록이 되어야 한다
            self,
            selector: #selector(sendMemoNotification),
            name: NSNotification.Name("SendMemo"),
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.post(
            name: NSNotification.Name("memoReceived"),
            object: nil,
            userInfo: ["content": memoTextField.text!]
        )
    }
    
    @objc func sendMemoNotification(notification: NSNotification) {
        print("✅✅✅✅")
        if let info = notification.userInfo?["memo"] as? String {
            memoTextField.text = info
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(memoTextField)
    }
 
    override func configureView() {
        super.configureView()
        memoTextField.placeholder = "한 줄 메모를 입력해보세요"
        memoTextField.keyboardType = .default
    }
    
    override func configureConstraints() {
        memoTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }

    deinit {
        print("MemoViewController", self)
    }
}
