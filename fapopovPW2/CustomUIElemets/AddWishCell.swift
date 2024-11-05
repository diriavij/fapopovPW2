//
//  AddWishCell.swift
//  fapopovPW2
//
//  Created by Фома Попов on 04.11.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
    
    static let reuseId: String = "AddWishCell"
    
    // MARK: - Constants
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let submissionButtonBackgroundColor: UIColor = .systemGray5
        static let submissionButtonHighlightedColor: UIColor = .systemGray4
        static let submissionButtonTitleColor: UIColor = .systemPink
        static let wishFieldTextColor: UIColor = .black
        
        static let wrapCornerRadius: CGFloat = 16
        static let wrapVerticalOffset: CGFloat = 5
        static let wrapHorizontalOffset: CGFloat = 10
        static let wishFieldVerticalOffset: CGFloat = 8
        static let wishFieldHorizontalOffset: CGFloat = 40
        static let submissionButtonWidth: CGFloat = 32
        static let animationDuration: TimeInterval = 0.1
        static let fontSize: CGFloat = 16
        static let fontWeightValue: CGFloat = 1
        
        static let wishFieldPlaceholder: String = "Write your wish here"
        
        static let plusIconName: String = "submit"
    }
    
    // MARK: - UI Elements
    
    private let wishField: UITextView = UITextView()
    private let wrap: UIView = UIView()
    private let submissionButton: UIButton = UIButton(type: .system)
    private let plusIcon: UIImageView = UIImageView()
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
    
    // MARK: - Configuring Methods
    
    private func configureUI() {
        configureCell()
        configureWishField()
        configureSubmissionButton()
    }
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(wrap)
        
        wrap.isUserInteractionEnabled = true
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapCornerRadius
        wrap.pinVertical(to: self, Constants.wrapVerticalOffset)
        wrap.pinHorizontal(to: self, Constants.wrapHorizontalOffset)
    }
    
    private func configureWishField() {
        wishField.isUserInteractionEnabled = true
        wishField.isEditable = true
        wishField.text = Constants.wishFieldPlaceholder
        wishField.textColor = Constants.wishFieldTextColor
        wishField.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: UIFont.Weight(Constants.fontWeightValue))
        wrap.addSubview(wishField)
        wishField.pinVertical(to: wrap, Constants.wishFieldVerticalOffset)
        wishField.pinHorizontal(to: wrap, Constants.wishFieldHorizontalOffset)
    }
    
    private func configureSubmissionButton() {
        submissionButton.backgroundColor = Constants.submissionButtonBackgroundColor
        submissionButton.setTitleColor(Constants.submissionButtonTitleColor, for: .normal)
        submissionButton.layer.cornerRadius = Constants.wrapCornerRadius
        submissionButton.setWidth(Constants.submissionButtonWidth)
        submissionButton.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
        submissionButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        plusIcon.image = UIImage(named: Constants.plusIconName)
        submissionButton.addSubview(plusIcon)
        wrap.addSubview(submissionButton)
        submissionButton.pinTop(to: wrap)
        submissionButton.pinBottom(to: wrap)
        submissionButton.pinRight(to: wrap)
        plusIcon.pinCenter(to: submissionButton)
        plusIcon.pinWidth(to: submissionButton.widthAnchor)
        plusIcon.pinHeight(to: submissionButton.heightAnchor)
    }
    
    func configureAddWish(action: @escaping (String) -> ()) {
        addWish = action
    }
    
    // MARK: - Interactions Processing Methods
    
    @objc private func buttonTouchDown() {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.submissionButton.backgroundColor = Constants.submissionButtonBackgroundColor
        }
    }
    
    @objc private func buttonWasPressed() {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.submissionButton.backgroundColor = Constants.submissionButtonHighlightedColor
        }
        
        if wishField.text.isEmpty || wishField.text == Constants.wishFieldPlaceholder {
            return
        }
        
        let wishText = wishField.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !wishText.isEmpty else { return }
        addWish?(wishText)
    }
}
