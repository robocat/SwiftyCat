//
//  StyledImageCell.swift
//  Thermo2
//
//  Created by Ulrik Damm on 04/08/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

struct ChoiceImageRowType: PressableRowType, RowTypeRefresh {
	static let typeId = "ChoiceImageRowType"
	let action: Void -> Void
	let image: UIImage?
	
	func shouldRefresh(to to: RowType) -> Bool {
		return (to as? ChoiceImageRowType)?.image?.hashValue != image?.hashValue
	}
}

class StyledImageCell: StyledTableViewCell, DeclarativeCell {
	override func setup() {
		super.setup()
		
		accessoryType = .DisclosureIndicator
	}
	
	var rowType: RowType? {
		didSet {
			if let rowType = rowType as? ChoiceImageRowType {
				imageView?.image = rowType.image
			}
		}
	}
}
