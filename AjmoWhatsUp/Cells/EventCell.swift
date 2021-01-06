//
//  EventCell.swift
//  AjmoWhatsUp
//
//  Created by Josip Hranić on 04.01.2021..
//

import UIKit
import SnapKit

class EventCell: UICollectionViewCell {

    private let view = EventCellView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public methods
extension EventCell {

    func update(event: Event) {
        view.update(event: event)
    }
}

// MARK: Private methods
private extension EventCell {

    func addSubviews() {
        contentView.addSubview(view)
    }

    func layout() {
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
