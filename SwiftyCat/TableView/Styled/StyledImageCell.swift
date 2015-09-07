//
//  StyledImageCell.swift
//  Thermo2
//
//  Created by Ulrik Damm on 04/08/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

public struct ChoiceImageRowType: PressableRowType, RowTypeRefresh {
	public static let typeId = "ChoiceImageRowType"
	public let action: Void -> Void
	public let image: UIImage?
	
	public func shouldRefresh(to to: RowType) -> Bool {
		return (to as? ChoiceImageRowType)?.image != image
	}
    
    public init(action: Void -> Void, image: UIImage? = nil) {
        self.image = image
        self.action = action
    }
}

public class StyledImageCell: StyledTableViewCell, DeclarativeCell {
	override func setup() {
		super.setup()
		
		accessoryType = .DisclosureIndicator
	}
	
	public var rowType: RowType? {
		didSet {
			if let rowType = rowType as? ChoiceImageRowType {
				imageView?.image = rowType.image
			}
		}
	}
}
