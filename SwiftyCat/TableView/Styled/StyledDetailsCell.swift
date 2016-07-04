//
//  StyledDetailsCell.swift
//  Thermo2
//
//  Created by Ulrik Damm on 04/08/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

public struct DetailsRowType: PressableRowType {
	public static let typeId = "DetailsRowType"
	public let action: Void -> Void
    
    public init(action: Void -> Void) {
        self.action = action
    }
}

public struct ChoiceDetailsRowType: PressableRowType {
	public static let typeId = "ChoiceDetailsRowType"
	public let action: Void -> Void
    
    public init(action: Void -> Void) {
        self.action = action
    }
}

public class StyledDetailsCell: StyledTableViewCell {
	override public func setup() {
		super.setup()
		
		accessoryType = .DisclosureIndicator
	}
}
