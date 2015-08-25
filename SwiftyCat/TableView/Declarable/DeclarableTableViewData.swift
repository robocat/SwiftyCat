//
//  StyledTableViewData.swift
//  Thermo2
//
//  Created by Ulrik Damm on 27/07/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

struct IndexPath {
	let section: Int
	let item: Int
}

extension IndexPath {
	init(indexPath: NSIndexPath) {
		self.section = indexPath.section
		self.item = indexPath.row
	}
}

struct Row: Identifiable, Equatable {
	let id: String
	let title: String
	let type: RowType
	
	init(_ rowId: String, _ title: String, _ type: RowType) {
		self.id = rowId
		self.title = title
		self.type = type
	}
}

func ==(lhs: Row, rhs: Row) -> Bool {
	return lhs.id == rhs.id && lhs.title == rhs.title
}

protocol RowType {
	static var typeId: String { get }
}

protocol PressableRowType: RowType {
	var action: Void -> Void { get }
}

protocol EditableRowType: RowType {
	var deleteAction: Void -> Void { get }
}

protocol MovableRowType: EditableRowType {
	var moveAction: (IndexPath -> Void) { get }
}


protocol DeclarativeCell {
	var rowType: RowType? { get set }
}

protocol RowTypeRefresh {
	func shouldRefresh(to to: RowType) -> Bool
}


protocol Section: Identifiable {
	var name: String { get }
	var footer: String? { get }
	var rows: [Row] { get }
}

func ==(lhs: Section, rhs: Section) -> Bool {
	return lhs.name == rhs.name && lhs.footer == rhs.footer
}

struct CustomSection: Section {
	var id: String
	var name: String
	var footer: String?
	var rows: [Row]
	
	init(_ sectionId: String, _ name: String, footer: String? = nil, _ rows: [Row]) {
		self.id = sectionId
		self.name = name
		self.footer = footer
		self.rows = rows
	}
}
