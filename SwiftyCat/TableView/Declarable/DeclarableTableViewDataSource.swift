//
//  TableViewData.swift
//  Thermo2
//
//  Created by Ulrik Damm on 27/07/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

public class DeclarableTableViewDataSource: NSObject, UITableViewDataSource {
	public var sections: [Section] = [] { didSet { /*updateSections(oldValue)*/ } }
	
	public var registeredRowTypes: [RowType.Type] = []
	public var cellTypeForRowType: (RowType.Type -> UITableViewCell.Type)?
	
	public var tableView: UITableView?
	
	public var dataChanged: (Void -> Void)?
	
	public func attachToTableView(tableView: UITableView) {
		self.tableView = tableView
		
		if let cellTypeForRowType = cellTypeForRowType {
			for rowType in registeredRowTypes {
				tableView.registerClass(cellTypeForRowType(rowType), forCellReuseIdentifier: rowType.typeId)
			}
		}
		
		tableView.dataSource = self
	}
	
	public func updateSections(from: [Section]) {
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
		
	public func rowAtIndexPath(indexPath: NSIndexPath) -> Row {
		assert(indexPath.section < sections.count, "Invalid indexPath section")
		let section = sections[indexPath.section]
		
		assert(indexPath.row < section.rows.count, "Invalid indexPath row")
		let row = section.rows[indexPath.row]
		
		return row
	}
	
	public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return sections.count
	}
	
	public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		assert(section < sections.count, "Invalid section index")
		
		return sections[section].rows.count
	}
	
	public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let row = rowAtIndexPath(indexPath)
		let cellId = row.type.dynamicType.typeId
		let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
		
		if let title = row.title {
			cell.textLabel?.text = title
			cell.accessibilityLabel = (title as NSString).accessibilityLabel
		}
		
		if var cell = cell as? DeclarativeCell {
			cell.rowType = row.type
		}
		
		return cell
	}
	
	public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		assert(section < sections.count, "Invalid section index")
		
		return sections[section].name
	}
	
	public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		assert(section < sections.count, "Invalid section index")
		
		return sections[section].footer
	}
	
	public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return rowAtIndexPath(indexPath).type is EditableRowType
	}
	
	public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		guard let row = rowAtIndexPath(indexPath).type as? EditableRowType else { fatalError("Editing non-editable cell at \(indexPath)") }
		row.deleteAction()
	}
	
	public func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return rowAtIndexPath(indexPath).type is MovableRowType
	}
	
	public func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
		guard let row = rowAtIndexPath(sourceIndexPath).type as? MovableRowType else { fatalError("Moving non-movable cell at \(sourceIndexPath)") }
		row.moveAction(IndexPath(indexPath: destinationIndexPath))
	}
}
