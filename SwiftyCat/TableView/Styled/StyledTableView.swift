//
//  StyledTableView.swift
//  Thermo2
//
//  Created by Ulrik Damm on 27/07/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

class StyledTableView: UITableView {
	init() {
		super.init(frame: CGRectZero, style: .Grouped)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	func setup() {
		backgroundColor = UIColor(hex: 0x151413)
		separatorColor = UIColor(hex: 0x322f2c)
	}
}
