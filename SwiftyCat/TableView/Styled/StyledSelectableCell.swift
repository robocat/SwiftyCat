//
//  StyledSelectableCell.swift
//  Thermo2
//
//  Created by Ulrik Damm on 04/08/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

public struct SelectableRowType: PressableRowType {
	public static let typeId = "SelectableRowType"
	public let selected: Bool
	public let action: Void -> Void
    
    public init(selected: Bool, action: Void -> Void) {
        self.selected = selected
        self.action = action
    }
}

public class StyledSelectableCell: StyledTableViewCell, DeclarativeCell {
	public var rowType: RowType? {
		didSet {
			if let rowType = rowType as? SelectableRowType {
				accessoryType = (rowType.selected ? .Checkmark: .None)
			}
		}
	}
}
