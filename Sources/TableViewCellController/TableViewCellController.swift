//
//  TableViewCellController.swift
//  TableViewCellControllers
//
//  Created by Jill Cohen on 4/5/16.
//  Copyright © 2016 Jill Cohen. All rights reserved.
//

import UIKit


protocol TableViewCellController {
    static var reuseIdentifier: String { get }
    static var cellClass: UITableViewCell.Type { get }
    static var cellNib: UINib? { get }

    func heightForWidth(width: CGFloat) -> CGFloat
    func configureCell(_ cell: UITableViewCell)
    func cellSelected(_ cell: UITableViewCell)
    func shouldHighlightCell() -> Bool

}

extension TableViewCellController {
    static func registerCell(tableView: UITableView) {
        if let nib = cellNib {
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        } else {
            tableView.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
        }
    }

    static var reuseIdentifier: String {
        return "\(self)"
    }

    func shouldHighlightCell() -> Bool {
        return true
    }

    static var cellClass: UITableViewCell.Type { return UITableViewCell.self }
}
