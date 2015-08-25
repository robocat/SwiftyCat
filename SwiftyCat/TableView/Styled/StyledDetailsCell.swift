//
//  StyledDetailsCell.swift
//  Thermo2
//
//  Created by Ulrik Damm on 04/08/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

struct DetailsRowType: PressableRowType {
	static let typeId = "DetailsRowType"
	let action: Void -> Void
}

struct ChoiceDetailsRowType: PressableRowType {
	static let typeId = "ChoiceDetailsRowType"
	let action: Void -> Void
}

class StyledDetailsCell: StyledTableViewCell {
	override func setup() {
		super.setup()
		
		accessoryType = .DisclosureIndicator
	}
}
