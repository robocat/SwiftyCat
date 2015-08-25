//
//  StyledTableViewDelegate.swift
//  Thermo2
//
//  Created by Ulrik Damm on 27/07/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

class DeclarableTableViewDelegate: NSObject, UITableViewDelegate {
	weak var dataSource: DeclarableTableViewDataSource?
	
	init(dataSource: DeclarableTableViewDataSource? = nil) {
		self.dataSource = dataSource
	}
	
	func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return dataSource?.rowAtIndexPath(indexPath).type is PressableRowType ?? true
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if let row = dataSource?.rowAtIndexPath(indexPath).type as? PressableRowType {
			row.action()
		}
	}
	
	func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
		if dataSource?.rowAtIndexPath(proposedDestinationIndexPath).type is MovableRowType {
			return proposedDestinationIndexPath
		} else {
			return sourceIndexPath
		}
	}
}
