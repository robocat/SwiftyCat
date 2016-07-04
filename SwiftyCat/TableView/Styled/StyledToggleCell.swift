//
//  StyledToggleCell.swift
//  Thermo2
//
//  Created by Ulrik Damm on 04/08/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

public struct ToggleRowType: RowType {
	public static let typeId = "ToggleRowType"
	public let value: Void -> Bool
	public let didToggle: Bool -> Void
    
    public init(value: Void -> Bool, didToggle: Bool -> Void) {
        self.value = value
        self.didToggle = didToggle
    }
}

public class StyledToggleCell: StyledTableViewCell, DeclarativeCell {
	public let toggle = UISwitch()
	
	public var rowType: RowType? {
		didSet {
			if let rowType = rowType as? ToggleRowType {
				toggle.on = rowType.value()
			}
		}
	}
	
	override public func setup() {
		super.setup()
		
		toggle.onTintColor = tintColor
		accessoryView = toggle
		
		toggle.addTarget(self, action: #selector(StyledToggleCell.valueChanged), forControlEvents: .ValueChanged)
	}
    
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        
        toggle.onTintColor = tintColor
    }
	
	func valueChanged() {
		(rowType as? ToggleRowType)?.didToggle(toggle.on)
	}
}
