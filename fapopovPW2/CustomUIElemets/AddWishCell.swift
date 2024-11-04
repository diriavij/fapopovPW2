//
//  AddWishCell.swift
//  fapopovPW2
//
//  Created by Фома Попов on 04.11.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
    
    static let reuseId: String = "AddWishCell"
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
    }
    private let wishField: UITextView = UITextView()
    private let wrap: UIView = UIView()
    private let submissionButton: UIButton = UIButton(type: .system)
    var addWish: ((String) -> ())?
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(wrap)
        
        wrap.isUserInteractionEnabled = true
        contentView.addSubview(wrap)
        
        wishField.isUserInteractionEnabled = true
        wishField.isEditable = true
        wishField.text = "Write your wish here"
        wishField.textColor = .black
        
        wrap.addSubview(wishField)
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        wrap.addSubview(wishField)
        wishField.pin(to: wrap, Constants.wishLabelOffset)
        
        submissionButton.backgroundColor = .systemGray4
        submissionButton.setTitleColor(.systemPink, for: .normal)
        submissionButton.layer.cornerRadius = Constants.wrapRadius
        submissionButton.setWidth(100)
        submissionButton.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
        submissionButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        wrap.addSubview(submissionButton)
        submissionButton.pinTop(to: wrap)
        submissionButton.pinBottom(to: wrap)
        submissionButton.pinRight(to: wrap)
        
        submissionButton.setTitle("SUBMIT", for: .normal)
        
    }
    
    func configureAddWish(action: @escaping (String) -> ()) {
        addWish = action
    }
    
    @objc func buttonTouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.submissionButton.backgroundColor = .systemGray2
        }
    }
    
    @objc
    func buttonWasPressed() {
        UIView.animate(withDuration: 0.1) {
            self.submissionButton.backgroundColor = .systemGray4
        }
        
        if wishField.text.isEmpty || wishField.text == "Write your wish here" {
            return
        }
        
        guard let wish = wishField.text else { return }
        addWish?(wish)
    }
}
