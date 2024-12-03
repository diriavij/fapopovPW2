//
//  WIshEventCell.swift
//  fapopovPW2
//
//  Created by Фома Попов on 03.12.2024.
//

import Foundation
import UIKit

// MARK: - WishEventCell
class WishEventCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    static let reuseIdentifier: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    enum Const {
        static let cornerRadius: CGFloat = 10
        static let offset: CGFloat = 10
        
        static let backgroundColor: UIColor = .white
    
        static let titleFont: UIFont = .systemFont(ofSize: 16)
        static let basicFont: UIFont = .systemFont(ofSize: 12)
        static let titleTop: Double = 10
        static let leadingOffset: Double = 10
        static let numberOfLines = 0
        
        static let bottomOffset: Double = 10
        static let verticalOffset: Double = 5
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
    // MARK: - UI Configuration
    
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, Const.offset)
        wrapView.layer.cornerRadius = Const.cornerRadius
        wrapView.backgroundColor = Const.backgroundColor
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.pinTop(to: wrapView, Const.titleTop)
        titleLabel.font = Const.titleFont
        titleLabel.pinLeft(to: wrapView, Const.leadingOffset)
    }
    
    private func configureDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.font = Const.basicFont
        descriptionLabel.numberOfLines = Const.numberOfLines
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Const.verticalOffset)
        descriptionLabel.pinHorizontal(to: wrapView, Const.leadingOffset)
    }
    
    private func configureStartDateLabel() {
        wrapView.addSubview(startDateLabel)
        startDateLabel.font = Const.basicFont
        startDateLabel.pinHorizontal(to: wrapView, Const.leadingOffset)
        startDateLabel.pinTop(to: descriptionLabel.bottomAnchor, Const.verticalOffset)
    }
    
    private func configureEndDateLabel() {
        wrapView.addSubview(endDateLabel)
        endDateLabel.font = Const.basicFont
        endDateLabel.pinHorizontal(to: wrapView, Const.leadingOffset)
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, Const.verticalOffset)
        endDateLabel.pinBottom(to: wrapView, Const.bottomOffset)
    }
    
}
