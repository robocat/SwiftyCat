//
//  StyledTableViewDiff.swift
//  Thermo2
//
//  Created by Ulrik Damm on 28/07/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

class DeclarableTableViewDiff {
	let tableView: UITableView
	
	init(tableView: UITableView) {
		self.tableView = tableView
	}
	
	func updateTableView(from: [Section], to: [Section]) {
		let (sectionChanges, rowChanges) = diffSections(from: from, to: to)
		
		if sectionChanges.count > 0 || rowChanges.count > 0 {
			tableView.beginUpdates()
			
			for change in sectionChanges {
				applySectionChange(change)
			}
			
			for (section, changes) in rowChanges {
				for change in changes {
					applyRowChange(section, change: change)
				}
			}
			
			tableView.endUpdates()
		}
	}
	
	func sectionEquals(section1: Identifiable, section2: Identifiable) -> Bool {
		if let section1 = section1 as? Section, section2 = section2 as? Section {
			return section1 == section2
		} else {
			return false
		}
	}
	
	func rowEquals(row1: Identifiable, row2: Identifiable) -> Bool {
		if let row1 = row1 as? Row, row2 = row2 as? Row {
			if row1 == row2 {
				if let rowType1 = row1.type as? RowTypeRefresh {
					return rowType1.shouldRefresh(to: row2.type)
				} else {
					return true
				}
			}
		}
		
		return false
	}
	
	func diffSections(from from: [Section], to: [Section]) -> (sectionChanges: [Diff.Change], rowChanges: [Int: [Diff.Change]]) {
		let fromIds = from.map { $0 as Identifiable }
		let toIds = to.map { $0 as Identifiable }
		
		let sectionChanges = Diff.diff(fromIds, toIds, equals: sectionEquals)
		
		var rowChanges: [Int: [Diff.Change]] = [:]
		
		for (toIndex, section) in to.enumerate() {
			if let fromIndex = from.indexOf({ $0.id == section.id }) {
				let fromRowIds = from[fromIndex].rows.map { $0 as Identifiable }
				let toRowIds = section.rows.map { $0 as Identifiable }
				
				var changes = Diff.diff(fromRowIds, toRowIds, equals: rowEquals)
				
				if changes.count > 0 {
					rowChanges[toIndex] = changes
				}
			}
		}
		
		return (sectionChanges, rowChanges)
	}
	
	func applySectionChange(change: Diff.Change) -> Void {
		switch change {
		case .Insert(let at): tableView.insertSections(NSIndexSet(index: at), withRowAnimation: .Automatic)
		case .Remove(let at): tableView.deleteSections(NSIndexSet(index: at), withRowAnimation: .Automatic)
		case .Move(let from, let to): tableView.moveSection(from, toSection: to)
		case .Update(let at): tableView.reloadSections(NSIndexSet(index: at), withRowAnimation: .None)
		}
	}
	
	func applyRowChange(section: Int, change: Diff.Change) -> Void {
		switch change {
		case .Insert(let at): tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: at, inSection: section)], withRowAnimation: .Automatic)
		case .Remove(let at): tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: at, inSection: section)], withRowAnimation: .Automatic)
		case .Move(let from, let to): tableView.moveRowAtIndexPath(NSIndexPath(forRow: from, inSection: section), toIndexPath: NSIndexPath(forRow: to, inSection: section))
		case .Update(let at): tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: at, inSection: section)], withRowAnimation: .None)
		}
	}
}
