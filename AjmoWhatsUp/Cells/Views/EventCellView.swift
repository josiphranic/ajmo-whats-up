//
//  EventCellView.swift
//  AjmoWhatsUp
//
//  Created by Josip Hranić on 04.01.2021..
//

import UIKit
import Nuke

class EventCellView: UIView {

    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let eventLabel = UILabel()
    private let publishedDateLabel = UILabel()
    private let dateFormatter = DateFormatter()
    private var event: Event?

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupViews()
        setupLabesl()
        setupImageViews()
        setupDateFormetter()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public method
extension EventCellView {

    func update(event: Event) {
        self.event = event
        updateLabels()
        updateImageViews()
    }
}

// MARK: Private method
private extension EventCellView {

    func addSubviews() {
        addSubview(backgroundImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(eventLabel)
        addSubview(publishedDateLabel)
    }

    func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
    }

    func setupLabesl() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(.defaultHigh,
                                             for: .vertical)
        subtitleLabel.setContentHuggingPriority(.defaultLow,
                                                for: .vertical)
        publishedDateLabel.font = UIFont.systemFont(ofSize: 12)
        eventLabel.font = UIFont.boldSystemFont(ofSize: 12)
        eventLabel.textColor = .blue
        eventLabel.text = "Event"
    }

    func setupImageViews() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
    }

    func setupDateFormetter() {
        dateFormatter.dateFormat = "d.M.yyyy"
    }

    func layout() {
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.6)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundImageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(eventLabel.snp.top)
        }

        eventLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(10)
        }

        publishedDateLabel.snp.makeConstraints {
            $0.leading.equalTo(eventLabel.snp.trailing).offset(10)
            $0.trailing.lessThanOrEqualToSuperview().inset(10)
            $0.centerY.equalTo(eventLabel).priority(.high)
            $0.bottom.lessThanOrEqualToSuperview().inset(10)
        }
    }

    func updateLabels() {
        titleLabel.text = event?.title
        subtitleLabel.text = event?.caption
        guard let eventDate = event?.created_at else {
            publishedDateLabel.text = nil
            return
        }
        let formattedDate = dateFormatter.string(from: eventDate)
        publishedDateLabel.text = "• published: \(formattedDate)"
    }

    func updateImageViews() {
        guard let urlString = event?.image_url,
              let url = URL(string: urlString) else {
            backgroundImageView.image = nil
            return
        }
        Nuke.loadImage(with: url,
                       into: backgroundImageView)
    }
}
