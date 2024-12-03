//
//  WishStoringViewController.swift
//  fapopovPW2
//
//  Created by Фома Попов on 04.11.2024.
//

import UIKit

// MARK: - Wish Storing ViewController

final class WishStoringViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = []
    private let defaults = UserDefaults.standard
    
    
    // MARK: - Constants
    
    private enum Const {
        static let tableCornerRadius: CGFloat = 20
        static let tableOffset: CGFloat = 30
        static let buttonWidth: CGFloat = 32
        
        static let numberOfSections: Int = 2
        
        static let backgroundColor: UIColor = UIColor(red: 0.6, green: 0.8, blue: 0.8, alpha: 1)
        static let tableBackgroundColor: UIColor = UIColor(red: 0.8, green: 0.95, blue: 0.95, alpha: 1)
        
        static let userDefaultsKey: String = "User"
        
        static let sectionAddWish: Int = 0
        static let sectionWishes: Int = 1
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WishMakerViewController.currentColor
        wishArray = defaults.array(forKey: Const.userDefaultsKey) as? [String] ?? []
        configureTable()
    }
    
    // MARK: - Configuring Methods
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = WishMakerViewController.currentColor
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Const.tableCornerRadius
        table.pin(to: view, Const.tableOffset)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    // MARK: - Action Methods
    
    public func addWishAction(wish: String) {
        wishArray.append(wish)
        defaults.set(wishArray, forKey: Const.userDefaultsKey)
        table.reloadData()
    }
    
    public func deleteWishAction(index: Int) {
        wishArray.remove(at: index)
        defaults.set(wishArray, forKey: Const.userDefaultsKey)
        table.reloadData()
    }
    
    public func editWishAction(index: Int, wish: String) {
        wishArray.remove(at: index)
        wishArray.insert(wish, at: index)
        defaults.set(wishArray, forKey: Const.userDefaultsKey)
        table.reloadData()
    }
}

    // MARK: - UITableViewDataSource

extension WishStoringViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Const.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Const.sectionAddWish {
            return 1
        } else {
            return wishArray.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if indexPath.section == Const.sectionAddWish {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            )
            
            guard let addWishCell = cell as? AddWishCell else { return cell }
            
            addWishCell.configureAddWish { [weak self] wish in
                self?.addWishAction(wish: wish)
            }
            return addWishCell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            )
            
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            
            wishCell.configure(with: wishArray[indexPath.row], with: indexPath.row)
            wishCell.configureDeleteWish { [weak self] ind in
                self?.deleteWishAction(index: ind)
            }
            wishCell.configureEditWish { [weak self] ind, wish in
                self?.editWishAction(index: ind, wish: wish)
            }
            return wishCell
        }
    }
}
