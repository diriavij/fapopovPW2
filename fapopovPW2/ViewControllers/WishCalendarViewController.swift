//
//  WishCalendarViewController.swift
//  fapopovPW2
//
//  Created by Фома Попов on 03.12.2024.
//

import Foundation
import UIKit

// MARK: - WishCalendarViewController
class WishCalendarViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    //private let addButton: UIButton = UIButton(type: .system)
    
    // MARK: - Constants
    
    private enum Const {
        static let reuseIdentifier = "cell"
        static let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static let collectionTop: Double = 10
        
        static let numberOfItems: Int = 10
        static let cellOffset: CGFloat = 10
        static let cellHeight: CGFloat = 120
        
        static let buttonHeight: Double = 40
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WishMakerViewController.currentColor
        //configureAddButton()
        configureCollection()
    }
    
    // MARK: - Configuring Methods
    
//    private func configureAddButton() {
//        view.addSubview(addButton)
//        addButton.setHeight(Const.buttonHeight)
//        addButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
//        
//    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = WishMakerViewController.currentColor
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Const.contentInset

        configureLayoutForCollection()
        collectionView.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseIdentifier
        )
        
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Const.collectionTop)
    }
    
    private func configureLayoutForCollection() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.invalidateLayout()
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return Const.numberOfItems
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath)
        
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }
        wishEventCell.configure(
            with: WishEventModel(
                title: "Test",
                description: "Test description",
                startDate: "Start date",
                endDate: "End date"
            )
        )
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // Adjust cell size as needed
        return CGSize(width: collectionView.bounds.width - Const.cellOffset, height: Const.cellHeight)
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
