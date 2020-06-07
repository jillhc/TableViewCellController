//
//  TableViewSectionController.swift
//  TableViewCellControllers
//
//  Created by Jill Cohen on 4/5/16.
//  Copyright © 2016 Jill Cohen. All rights reserved.
//

#if !os(macOS)

import UIKit


public protocol TableViewSectionController {
    var cellControllers: [TableViewCellController] { get }

    func viewForHeader() -> UIView?
    func heightForHeader() -> CGFloat
}


/// A concrete implementaiton of the protocol that simply stores cellControllers and no header
public class SimpleTableViewSectionController: TableViewSectionController {
    public let cellControllers: [TableViewCellController]

    public init(cellControllers: [TableViewCellController]) {
        self.cellControllers = cellControllers
    }

    public func viewForHeader() -> UIView? {
        return nil
    }

    public func heightForHeader() -> CGFloat {
        return 0
    }
}

#endif
