//
//  CustomSlider.swift
//  fapopovPW2
//
//  Created by Фома Попов on 23.10.2024.
//

import UIKit

final class CustomSlider: UIView {
    var valueChanged: ((Double) -> Void)?
    
    var slider = UISlider()
    var titleView = UILabel()
    
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleView.pinCenterX(to: centerXAnchor)
        titleView.pinTop(to:topAnchor, 10)
        titleView.pinLeft(to: leadingAnchor, 20)
        slider.pinTop(to: titleView.bottomAnchor)
        slider.pinCenterX(to: centerXAnchor)
        slider.pinBottom(to: bottomAnchor, 10)
        slider.pinLeft(to: leadingAnchor, 20)
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
