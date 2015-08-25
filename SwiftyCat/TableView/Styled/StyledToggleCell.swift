//
//  StyledToggleCell.swift
//  Thermo2
//
//  Created by Ulrik Damm on 04/08/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

struct ToggleRowType: RowType {
	static let typeId = "ToggleRowType"
	let value: Void -> Bool
	let didToggle: Bool -> Void
}

class StyledToggleCell: StyledTableViewCell, DeclarativeCell {
	let toggle = UISwitch()
	
	var rowType: RowType? {
		didSet {
			if let rowType = rowType as? ToggleRowType {
				toggle.on = rowType.value()
			}
		}
	}
	
	override func setup() {
		super.setup()
		
		toggle.onTintColor = tintColor
		accessoryView = toggle
		
		toggle.addTarget(self, action: Selector("valueChanged"), forControlEvents: .ValueChanged)
	}
	
	func valueChanged() {
		(rowType as? ToggleRowType)?.didToggle(toggle.on)
	}
}
