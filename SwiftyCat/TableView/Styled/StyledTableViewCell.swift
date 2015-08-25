//
//  StyledTableViewCells.swift
//  Thermo2
//
//  Created by Ulrik Damm on 27/07/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

public struct PlainRowType: RowType {
	public static let typeId = "PlainRowType"
}

public class StyledTableViewCell: UITableViewCell {
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	func setup() {
		backgroundColor = UIColor(hex: 0x282523)
		textLabel?.textColor = .whiteColor()
		
		let selection = UIView()
		selection.backgroundColor = UIColor(hex: 0x4b4846)
		selectedBackgroundView = selection
	}
}
