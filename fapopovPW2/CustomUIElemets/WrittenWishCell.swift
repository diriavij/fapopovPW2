//
//  WrittenWishCell.swift
//  fapopovPW2
//
//  Created by Фома Попов on 04.11.2024.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    
    static let reuseId: String = "WrittenWishCell"
    
    // MARK: - Constants
    
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let buttonBackgroundColor: UIColor = .systemGray5
        static let buttonHighlightedColor: UIColor = .systemGray4
        static let buttonTitleColor: UIColor = .systemPink
        static let wishTextColor: UIColor = .black
        
        static let wrapCornerRadius: CGFloat = 16
        static let wrapVerticalOffset: CGFloat = 5
        static let wrapHorizontalOffset: CGFloat = 10
        static let wishLabelVerticalOffset: CGFloat = 8
        static let wishLabelHorizontalOffset: CGFloat = 40
        static let buttonWidth: CGFloat = 32
        static let animationDuration: TimeInterval = 0.1
        static let fontSize: CGFloat = 16
        static let fontWeightValue: CGFloat = 1
        
        static let binIconName: String = "cross"
        static let editIconName: String = "edit"
        static let checkIconName: String = "check"
    }
    
    // MARK: - UI Elements
    
    private let wishLabel: UILabel = UILabel()
    private let wishField: UITextView = UITextView()
    private let wrap: UIView = UIView()
    private let deleteButton: UIButton = UIButton(type: .system)
    private let editButton: UIButton = UIButton(type: .system)
    private let editIcon = UIImageView()
    
    var editWish: ((Int, String) -> ())?
    var deleteWish: ((Int) -> ())?
    var wishIndex: Int = 0
    private var mode: Int = 0
    
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
    
    func configure(with wish: String, with index: Int) {
        wishLabel.text = wish
        wishField.text = wish
        wishIndex = index
    }
    
    private func configureUI() {
        configureCell()
        configureWishLabel()
        configureDeleteButton()
        configureEditButton()
        configureWishField()
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
    
    private func configureWishLabel() {
        wrap.addSubview(wishLabel)
        wishLabel.pinVertical(to: wrap, Constants.wishLabelVerticalOffset)
        wishLabel.pinHorizontal(to: wrap, Constants.wishLabelHorizontalOffset)
        wishLabel.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: UIFont.Weight(Constants.fontWeightValue))
        wishLabel.textColor = Constants.wishTextColor
    }
    
    private func configureDeleteButton() {
        deleteButton.backgroundColor = Constants.buttonBackgroundColor
        deleteButton.setTitleColor(Constants.buttonTitleColor, for: .normal)
        deleteButton.layer.cornerRadius = Constants.wrapCornerRadius
        deleteButton.setWidth(Constants.buttonWidth)
        deleteButton.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        
        let binIcon = UIImageView()
        binIcon.image = UIImage(named: Constants.binIconName)
        wrap.addSubview(deleteButton)
        deleteButton.addSubview(binIcon)
        deleteButton.pinTop(to: wrap)
        deleteButton.pinBottom(to: wrap)
        deleteButton.pinRight(to: wrap)
        binIcon.pinCenter(to: deleteButton)
        binIcon.pinWidth(to: deleteButton.widthAnchor)
        binIcon.pinHeight(to: deleteButton.heightAnchor)
    }
    
    private func configureEditButton() {
        editButton.backgroundColor = Constants.buttonBackgroundColor
        editButton.setTitleColor(Constants.buttonTitleColor, for: .normal)
        editButton.layer.cornerRadius = Constants.wrapCornerRadius
        editButton.setWidth(Constants.buttonWidth)
        editButton.addTarget(self, action: #selector(editButtonWasPressed), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButtonTouchDown), for: .touchDown)
        
        editIcon.image = UIImage(named: Constants.editIconName)
        wrap.addSubview(editButton)
        editButton.addSubview(editIcon)
        editButton.pinTop(to: wrap)
        editButton.pinBottom(to: wrap)
        editButton.pinLeft(to: wrap)
        editIcon.pinCenter(to: editButton)
        editIcon.pinWidth(to: editButton.widthAnchor)
        editIcon.pinHeight(to: editButton.heightAnchor)
    }
    
    private func configureWishField() {
        wishField.isUserInteractionEnabled = true
        wishField.isEditable = true
        wishField.textColor = Constants.wishTextColor
        wishField.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: UIFont.Weight(Constants.fontWeightValue))
        wrap.addSubview(wishField)
        wishField.pinVertical(to: wrap, Constants.wishLabelVerticalOffset)
        wishField.pinHorizontal(to: wrap, Constants.wishLabelHorizontalOffset)
        wishField.isHidden = true
    }
    
    func configureDeleteWish(action: @escaping (Int) -> ()) {
        deleteWish = action
    }
    
    func configureEditWish(action: @escaping (Int, String) -> ()) {
        editWish = action
    }
    
    // MARK: - Interactions Processing Methods
    
    @objc func buttonTouchDown() {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.deleteButton.backgroundColor = Constants.buttonBackgroundColor
        }
    }
    
    @objc
    func buttonWasPressed() {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.deleteButton.backgroundColor = Constants.buttonHighlightedColor
        }
        deleteWish?(wishIndex)
    }
    
    @objc func editButtonTouchDown() {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.editButton.backgroundColor = Constants.buttonBackgroundColor
        }
    }
    
    @objc
    func editButtonWasPressed() {
        UIView.animate(withDuration: Constants.animationDuration) {
            self.deleteButton.backgroundColor = Constants.buttonHighlightedColor
        }
        if mode == 0 {
            wishLabel.isHidden = true
            wishField.isHidden = false
            wishField.text = wishLabel.text
            editIcon.image = UIImage(named: Constants.checkIconName)
            mode = 1
        } else {
            mode = 0
            wishLabel.text = wishField.text
            editWish?(wishIndex, wishField.text)
            wishLabel.isHidden = false
            wishField.isHidden = true
            editIcon.image = UIImage(named: Constants.editIconName)
        }
        
    }
}

