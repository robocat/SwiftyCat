//
//  StyledTableView.swift
//  Thermo2
//
//  Created by Ulrik Damm on 27/07/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

public class StyledTableView: UITableView {
	public init() {
		super.init(frame: CGRectZero, style: .Grouped)
		setup()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	public func setup() {
		backgroundColor = UIColor(hex: 0x151413)
		separatorColor = UIColor(hex: 0x322f2c)
	}
}
