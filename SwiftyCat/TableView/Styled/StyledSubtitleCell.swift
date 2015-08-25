//
//  StyledSubtitleCell.swift
//  Thermo2
//
//  Created by Ulrik Damm on 04/08/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

struct ChoiceSubtitleRowType: PressableRowType, RowTypeRefresh {
	static let typeId = "ChoiceSubtitleRowType"
	let action: Void -> Void
	let subtitle: String
	
	func shouldRefresh(to to: RowType) -> Bool {
		return (to as? ChoiceSubtitleRowType)?.subtitle != subtitle
	}
}

class StyledSubtitleCell: StyledTableViewCell, DeclarativeCell {
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	override func setup() {
		super.setup()
		
		detailTextLabel?.textColor = UIColor.grayColor()
		accessoryType = .DisclosureIndicator
	}
	
	var rowType: RowType? {
		didSet {
			if let rowType = rowType as? ChoiceSubtitleRowType {
				detailTextLabel?.text = rowType.subtitle
			}
		}
	}
}
