//
//  StylishedSection.swift
//  TableBuilder
//
//  Created by Andreas Verhoeven on 01/03/2023.
//

import UIKit
import AutoLayoutConvenience

extension Section {
	public class Stylished: TableContent<ContainerType> {
		init(@TableContentBuilder<ContainerType> builder: () -> TableContentBuilder<ContainerType>.Collection) {
			let section = Section.Group(builder: builder).stylished()
			super.init(items: section.items)
		}
	}
}

public class StylishedCustomHeader: UITableViewHeaderFooterView {
	public let label = UILabel(font: .ios.headline.rounded)
	public let button = UIButton(font: .ios.headline.rounded, type: .system)
	
	public var buttonCallback: (() -> Void)?
	
	@objc private func buttonTapped(_ sender: Any) {
		buttonCallback?()
	}
	
	public override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		button.isHidden = true
		button.contentHorizontalAlignment = .trailing
		button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
		
		contentView.addSubview(
			.horizontallyStacked(
				label.disallowHorizontalGrowing(),
				button.disallowHorizontalShrinking(),
				alignment: .lastBaseline,
				spacing: UIStackView.spacingUseDefault
			),
			filling: .bottom(.superview, others: .layoutMargins),
			insets: .bottom(6)
		)
	}
	
	@available(*, unavailable)
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


extension TableContent {
	public func stylished() -> Self {
		return self.stylishedHeader().backgroundColor(.secondarySystemBackground)
	}
	
	public func stylishedHeader() -> Self {
		return header(StylishedCustomHeader.self) { container, view, text, animated in
			view.label.setText(text, animated: animated)
		}
	}
}
