//
//  EventViewController.swift
//  AjmoWhatsUp
//
//  Created by Josip Hranić on 05.01.2021..
//

import UIKit
import Nuke

class EventViewController: UIViewController {

    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let eventLabel = UILabel()
    private let publishedDateLabel = UILabel()
    private let dateFormatter = DateFormatter()
    private let event: Event

    init(event: Event) {
        self.event = event
        super.init(nibName: nil,
                   bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Event"
        view.backgroundColor = .white
        edgesForExtendedLayout = []
        addSubviews()
        setupLabesl()
        setupImageViews()
        setupDateFormetter()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabels()
        updateImageViews()
    }
}

// MARK: Private methods
private extension EventViewController {

    func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(eventLabel)
        view.addSubview(publishedDateLabel)
    }

    func setupLabesl() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.setContentCompressionResistancePriority(.defaultLow,
                                                              for: .vertical)
        publishedDateLabel.font = UIFont.systemFont(ofSize: 12)
        eventLabel.font = UIFont.boldSystemFont(ofSize: 12)
        eventLabel.textColor = .blue
        eventLabel.text = "Event"
    }

    func setupImageViews() {
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.clipsToBounds = true
    }

    func setupDateFormetter() {
        dateFormatter.dateFormat = "d.M.yyyy"
    }

    func layout() {
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.3)
        }

        eventLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundImageView.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(eventLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        publishedDateLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.lessThanOrEqualToSuperview().inset(20)
        }
    }

    func updateLabels() {
        titleLabel.text = event.title
        subtitleLabel.text = event.description
        let eventDate = event.created_at
        let formattedDate = dateFormatter.string(from: eventDate)
        publishedDateLabel.text = "Published: \(formattedDate)"
    }

    func updateImageViews() {
        let urlString = event.image_url
        guard let url = URL(string: urlString) else {
            backgroundImageView.image = nil
            return
        }
        Nuke.loadImage(with: url,
                       into: backgroundImageView)
    }
}
