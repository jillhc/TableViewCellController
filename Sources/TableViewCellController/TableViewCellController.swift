//
//  TableViewCellController.swift
//  TableViewCellControllers
//
//  Created by Jill Cohen on 4/5/16.
//  Copyright © 2016 Jill Cohen. All rights reserved.
//

#if !os(macOS)

import UIKit


public protocol TableViewCellController {

    /// Default implementation returns cellClass name
    static var reuseIdentifier: String { get }

    /// Must be overridden
    static var cellClass: UITableViewCell.Type { get }

    /// Default implementation returns a nib if the cellClass conforms to NibBacked
    static var cellNib: UINib? { get }

    /// Must be overridden
    func heightForWidth(width: CGFloat) -> CGFloat
    /// Must be overridden
    func configureCell(_ cell: UITableViewCell)

    /// Default implementation returns false
    func shouldHighlightCell() -> Bool

    /// Default implementation does nothing
    func cellSelected(_ cell: UITableViewCell)

    /// Default implementation does nothing
    func beginDisplayingCell(_ cell: UITableViewCell)

    /// Default implementation does nothing
    func endDisplayingCell(_ cell: UITableViewCell?)
}

public extension TableViewCellController {
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
        return false
    }

    func cellSelected(_ cell: UITableViewCell) {}
    func beginDisplayingCell(_ cell: UITableViewCell) {}
    func endDisplayingCell(_ cell: UITableViewCell?) {}
}

#endif
