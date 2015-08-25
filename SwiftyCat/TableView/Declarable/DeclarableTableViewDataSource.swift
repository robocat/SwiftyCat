//
//  TableViewData.swift
//  Thermo2
//
//  Created by Ulrik Damm on 27/07/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

class DeclarableTableViewDataSource: NSObject, UITableViewDataSource {
	var sections: [Section] = [] { didSet { /*updateSections(oldValue)*/ } }
	
	var registeredRowTypes: [RowType.Type] = []
	var cellTypeForRowType: (RowType.Type -> UITableViewCell.Type)?
	
	var tableView: UITableView?
	
	var dataChanged: (Void -> Void)?
	
	func attachToTableView(tableView: UITableView) {
		self.tableView = tableView
		
		if let cellTypeForRowType = cellTypeForRowType {
			for rowType in registeredRowTypes {
				tableView.registerClass(cellTypeForRowType(rowType), forCellReuseIdentifier: rowType.typeId)
			}
		}
		
		tableView.dataSource = self
	}
	
	func updateSections(from: [Section]) {
		guard let tableView = tableView else { return }
		let diff = DeclarableTableViewDiff(tableView: tableView)
		diff.updateTableView(from, to: sections)
		
		for cell in tableView.visibleCells {
			let indexPath = tableView.indexPathForCell(cell)
			
			if let indexPath = indexPath, var cell = cell as? DeclarativeCell {
				cell.rowType = rowAtIndexPath(indexPath).type
			}
		}
	}
	
	
	
	func rowAtIndexPath(indexPath: NSIndexPath) -> Row {
		assert(indexPath.section < sections.count, "Invalid indexPath section")
		let section = sections[indexPath.section]
		
		assert(indexPath.row < section.rows.count, "Invalid indexPath row")
		let row = section.rows[indexPath.row]
		
		return row
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return sections.count
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		assert(section < sections.count, "Invalid section index")
		
		return sections[section].rows.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let row = rowAtIndexPath(indexPath)
		let cellId = row.type.dynamicType.typeId
		let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
		
		cell.textLabel?.text = row.title
		cell.accessibilityLabel = (row.title as NSString).accessibilityLabel
		
		if var cell = cell as? DeclarativeCell {
			cell.rowType = row.type
		}
		
		return cell
	}
	
	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		assert(section < sections.count, "Invalid section index")
		
		return sections[section].name
	}
	
	func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		assert(section < sections.count, "Invalid section index")
		
		return sections[section].footer
	}
	
	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return rowAtIndexPath(indexPath).type is EditableRowType
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		guard let row = rowAtIndexPath(indexPath).type as? EditableRowType else { fatalError("Editing non-editable cell at \(indexPath)") }
		row.deleteAction()
	}
	
	func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return rowAtIndexPath(indexPath).type is MovableRowType
	}
	
	func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
		guard let row = rowAtIndexPath(sourceIndexPath).type as? MovableRowType else { fatalError("Moving non-movable cell at \(sourceIndexPath)") }
		row.moveAction(IndexPath(indexPath: destinationIndexPath))
	}
}
