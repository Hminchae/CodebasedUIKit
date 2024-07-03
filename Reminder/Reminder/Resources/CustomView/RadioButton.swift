//
//  RadioButton.swift
//  Reminder
//
//  Created by 황민채 on 7/3/24.
//

import UIKit

final class RadioButton: UIButton {
    
    private let circleLayer = CAShapeLayer()
    private let innerCircleLayer = CAShapeLayer()
    private var style: View.Radio
    
    init(style: View.Radio) {
        self.style = style
        super.init(frame: .zero)
        setupUI()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 바깥 원
        circleLayer.lineWidth = 1
        circleLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(circleLayer)
        
        // 안쪽 원
        innerCircleLayer.fillColor = UIColor.clear.cgColor  // 초기에는 색상을 투명으로 설정
        layer.addSublayer(innerCircleLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 바깥 원 크기
        let outerPath = UIBezierPath(ovalIn: CGRect(x: bounds.midX - 10, y: bounds.midY - 10, width: 20, height: 20))
        circleLayer.path = outerPath.cgPath
        circleLayer.frame = bounds
        
        // 안쪽 원 크기
        let innerPath = UIBezierPath(ovalIn: CGRect(x: bounds.midX - 9.5, y: bounds.midY - 9.5, width: 19, height: 19))
        innerCircleLayer.path = innerPath.cgPath
        innerCircleLayer.frame = bounds
    }
    
    override var isSelected: Bool {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        switch style {
        case .selected(let color):
            circleLayer.strokeColor = color.cgColor
            innerCircleLayer.fillColor = color.cgColor
        case .unselected:
            circleLayer.strokeColor = UIColor.lightGray.cgColor
            innerCircleLayer.fillColor = UIColor.clear.cgColor
        }
    }
}
