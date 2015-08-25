//
//  StyledSubtitleCell.swift
//  Thermo2
//
//  Created by Ulrik Damm on 04/08/15.
//  Copyright © 2015 Robocat. All rights reserved.
//

import UIKit

public struct ChoiceSubtitleRowType: PressableRowType, RowTypeRefresh {
	public static let typeId = "ChoiceSubtitleRowType"
	public let action: Void -> Void
	public let subtitle: String
	
    public init(action: Void -> Void, subtitle: String) {
        self.action = action
        self.subtitle = subtitle
    }
    
	public func shouldRefresh(to to: RowType) -> Bool {
		return (to as? ChoiceSubtitleRowType)?.subtitle != subtitle
	}
}

public class StyledSubtitleCell: StyledTableViewCell, DeclarativeCell {
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
		setup()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	override func setup() {
		super.setup()
		
		detailTextLabel?.textColor = UIColor.grayColor()
		accessoryType = .DisclosureIndicator
	}
	
	public var rowType: RowType? {
		didSet {
			if let rowType = rowType as? ChoiceSubtitleRowType {
				detailTextLabel?.text = rowType.subtitle
			}
		}
	}
}
