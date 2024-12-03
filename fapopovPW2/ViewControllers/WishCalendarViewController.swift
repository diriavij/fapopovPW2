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
    private let addButton: UIButton = UIButton(type: .system)
    
    private var events: [WishEventModel] = []
    private let defaults = UserDefaults.standard
    
    // MARK: - Constants
    
    private enum Const {
        static let reuseIdentifier = "cell"
        static let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static let collectionTop: Double = 10
        
        static let cellOffset: CGFloat = 10
        static let cellHeight: CGFloat = 120
        
        static let buttonHeight: Double = 40
        static let buttonOffset: Double = 15
        
        static let buttonColor: UIColor = .white
        static let buttonTitleColor: UIColor = .black
        static let buttonTitle = "Add an event"
        static let buttonCornerRadius: CGFloat = 10
        
        static let key = "Events"
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WishMakerViewController.currentColor
        configureAddButton()
        configureCollection()
        getEventsFromDefaults()
    }
    
    private func getEventsFromDefaults() {
        let decoder = JSONDecoder()
        if let savedEvents = UserDefaults.standard.object(forKey: Const.key) as? Data,
           let loadedEvents = try? decoder.decode([WishEventModel].self, from: savedEvents) {
            events = loadedEvents
            return
        }
        events = []
    }
    
    // MARK: - Configuring Methods
    
    private func configureAddButton() {
        view.addSubview(addButton)
        addButton.setHeight(Const.buttonHeight)
        addButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        addButton.pinHorizontal(to: view, Const.buttonOffset)
        addButton.backgroundColor = Const.buttonColor
        addButton.setTitle(Const.buttonTitle, for: .normal)
        addButton.setTitleColor(Const.buttonTitleColor, for: .normal)
        addButton.layer.cornerRadius = Const.buttonCornerRadius
        addButton.addTarget(self, action: #selector(addButtonWasPressed), for: .touchUpInside)
    }
    
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
        defaults.array(forKey: Const.key)
        
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: addButton.bottomAnchor, Const.collectionTop)
    }
    
    private func configureLayoutForCollection() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.invalidateLayout()
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func addButtonWasPressed() {
        let creation = WishEventCreationView()
        creation.addDelegate(addNewEvent)
        present(creation, animated: true)
    }
    
    private func addNewEvent(_ newEvent: WishEventModel) {
        events.append(newEvent)
        collectionView.reloadData()
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(events) {
            defaults.set(encodedData, forKey: Const.key)
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
        return events.count
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
        
        let event = events[indexPath.row]
        wishEventCell.configure(with: event)
        
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
