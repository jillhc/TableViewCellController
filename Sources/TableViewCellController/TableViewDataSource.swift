//
//  TableViewDataSource.swift
//  TableViewCellControllers
//
//  Created by Jill Cohen on 4/5/16.
//  Copyright © 2016 Jill Cohen. All rights reserved.
//

#if !os(macOS)

import UIKit


public class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    public var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
            registerCells()
            tableView?.reloadData()
        }
    }

    public var sectionControllers = [TableViewSectionController]() {
        willSet {
            // Clean up old cells, since the tableView will call endDisplaying on the old indexPaths only upon reloadData(), at which point the newValue is stored
            for sectionController in sectionControllers {
                for cellController in sectionController.cellControllers {
                    cellController.endDisplayingCell(nil)
                }
            }
        }
        didSet {
            registerCells()
            tableView?.reloadData()
        }
    }

    // MARK: UITableViewDataSource

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionControllers.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionControllers[section].cellControllers.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let controller = cellControllerAt(indexPath)! // Force unwrap because we are guaranteed to have a cell controller matching the indexPath here
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: controller).reuseIdentifier, for: indexPath)
        controller.configureCell(cell)

        return cell
    }


    // MARK: UITableViewDelegate

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellControllerAt(indexPath)?.heightForWidth(width: tableView.frame.size.width) ?? 0
    }

    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return cellControllerAt(indexPath)?.shouldHighlightCell() ?? false
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellControllerAt(indexPath)?.cellSelected(tableView.cellForRow(at: indexPath)!)
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return (section < sectionControllers.count) ? sectionControllers[section].viewForHeader() : nil
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section < sectionControllers.count) ? sectionControllers[section].heightForHeader() : 0
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellControllerAt(indexPath)?.beginDisplayingCell(cell)
    }

    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellControllerAt(indexPath)?.endDisplayingCell(cell)
    }


    // MARK: Helpers

    private func cellControllerAt(_ indexPath: IndexPath) -> TableViewCellController? {
        if indexPath.section < sectionControllers.count {
            let sectionController = sectionControllers[indexPath.section]
            if indexPath.row < sectionController.cellControllers.count {
                return sectionController.cellControllers[indexPath.row];
            }
        }

        return nil
    }

    private func registerCells() {
        guard let tableView = tableView else {
            return
        }

        for section in sectionControllers {
            for cellController in section.cellControllers {
                type(of: cellController).registerCell(tableView: tableView)
            }
        }
    }

}

#endif
