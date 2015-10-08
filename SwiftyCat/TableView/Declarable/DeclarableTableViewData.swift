//
//  StyledTableViewData.swift
//  Thermo2
//
//  Created by Ulrik Damm on 27/07/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

public struct IndexPath {
	public let section: Int
	public let item: Int
}

public extension IndexPath {
	init(indexPath: NSIndexPath) {
		self.section = indexPath.section
		self.item = indexPath.row
	}
}

public struct Row: Identifiable, Equatable {
	public let id: String
	public let title: String?
	public let type: RowType
	
	public init(_ rowId: String, _ title: String?, _ type: RowType) {
		self.id = rowId
		self.title = title
		self.type = type
	}
}

public func ==(lhs: Row, rhs: Row) -> Bool {
	return lhs.id == rhs.id && lhs.title == rhs.title
}

public protocol RowType {
	static var typeId: String { get }
}

public protocol PressableRowType: RowType {
	var action: Void -> Void { get }
}

public protocol EditableRowType: RowType {
	var deleteAction: Void -> Void { get }
}

public protocol MovableRowType: EditableRowType {
	var moveAction: (IndexPath -> Void) { get }
}

public protocol DeclarativeCell {
	var rowType: RowType? { get set }
}

public protocol RowTypeRefresh {
	func shouldRefresh(to to: RowType) -> Bool
}

public protocol Section: Identifiable {
	var name: String? { get }
	var footer: String? { get }
	var rows: [Row] { get }
}

public func ==(lhs: Section, rhs: Section) -> Bool {
	return lhs.id == rhs.id
}

public struct CustomSection: Section {
	public var id: String
	public var name: String?
	public var footer: String?
	public var rows: [Row]
	
	public init(_ sectionId: String, _ name: String?, footer: String? = nil, _ rows: [Row]) {
		self.id = sectionId
		self.name = name
		self.footer = footer
		self.rows = rows
	}
}
