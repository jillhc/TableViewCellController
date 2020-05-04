//
//  TableViewSectionController.swift
//  TableViewCellControllers
//
//  Created by Jill Cohen on 4/5/16.
//  Copyright © 2016 Jill Cohen. All rights reserved.
//

import UIKit


public protocol TableViewSectionController {
    var cellControllers: [TableViewCellController] { get }

    var sectionTitle: String? { get }
}


/// A concrete implementaiton of the protocol that simply stores cellControllers and a sectionTitle
public class SimpleTableViewSectionController: TableViewSectionController {
    public let cellControllers: [TableViewCellController]
    public let sectionTitle: String?

    public init(cellControllers: [TableViewCellController], sectionTitle: String?) {
        self.cellControllers = cellControllers
        self.sectionTitle = sectionTitle
    }
}
