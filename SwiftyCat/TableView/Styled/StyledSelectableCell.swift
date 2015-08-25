//
//  StyledSelectableCell.swift
//  Thermo2
//
//  Created by Ulrik Damm on 04/08/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

struct SelectableRowType: PressableRowType {
	static let typeId = "SelectableRowType"
	let selected: Bool
	let action: Void -> Void
}

class StyledSelectableCell: StyledTableViewCell, DeclarativeCell {
	var rowType: RowType? {
		didSet {
			if let rowType = rowType as? SelectableRowType {
				accessoryType = (rowType.selected ? .Checkmark: .None)
			}
		}
	}
}
