//
//  WishStoringViewController.swift
//  fapopovPW2
//
//  Created by Фома Попов on 04.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    
    private let table: UITableView = UITableView(frame: .zero)
    
    private enum Const {
        static let tableCornerRadius: CGFloat = 20
        static let tableOffset: Double = 30
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Const.tableCornerRadius
        table.pin(to: view, Const.tableOffset)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
