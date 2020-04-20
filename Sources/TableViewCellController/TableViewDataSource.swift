//
//  TableViewDataSource.swift
//  TableViewCellControllers
//
//  Created by Jill Cohen on 4/5/16.
//  Copyright © 2016 Jill Cohen. All rights reserved.
//

import UIKit


class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
            registerCells()
            tableView?.reloadData()
        }
    }

    var sectionControllers = [TableViewSectionController]() {
        didSet {
            registerCells()
            tableView?.reloadData()
        }
    }

    // MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionControllers.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionControllers[section].cellControllers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let controller = cellControllerAt(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: controller).reuseIdentifier, for: indexPath)
        controller.configureCell(cell)

        return cell
    }


    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellControllerAt(indexPath).heightForWidth(width: tableView.frame.size.width)
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return cellControllerAt(indexPath).shouldHighlightCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = cellControllerAt(indexPath)
        controller.cellSelected(tableView.cellForRow(at: indexPath)!)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionControllers[section].sectionTitle
    }
    

    // MARK: Helpers

    private func cellControllerAt(_ indexPath: IndexPath) -> TableViewCellController {
        return sectionControllers[indexPath.section].cellControllers[indexPath.row]
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
