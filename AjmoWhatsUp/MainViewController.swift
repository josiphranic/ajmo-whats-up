//
//  ViewController.swift
//  AjmoWhatsUp
//
//  Created by Josip Hranić on 04.01.2021..
//

import UIKit

class MainViewController: UIViewController {

    private let eventCellIdentifier = String(describing: EventCell.self)
    private let dataHandler = EventDataHandler()
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    private var refreshTimer: Timer?
    private var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        title = "Ajmo - What's up"
        dataHandler.delegate = self
        addSubviews()
        setupTimer()
        setupCollectionView()
        setupCollectionViewFlowLayout()
        registerCollectionViewCells()
        layout()
        dataHandler.loadEvents()
    }

    deinit {
        refreshTimer?.invalidate()
    }
}

// MARK: Private methods
private extension MainViewController {

    func addSubviews() {
        view.addSubview(collectionView)
    }

    func setupTimer() {
        refreshTimer = Timer
            .scheduledTimer(withTimeInterval: 60 * 10,
                            repeats: true) { [weak self] _ in
                self?.dataHandler.loadEvents()
        }
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }

    func setupCollectionViewFlowLayout() {
        guard let flowLayout = collectionView
                .collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        let itemHeight = UIScreen.main.bounds.height / 2
        let itemWidth = itemHeight * 0.8
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = .init(width: itemWidth,
                                    height: itemHeight)
        flowLayout.sectionInset = .init(top: 0,
                                        left: 20,
                                        bottom: 0,
                                        right: 20)
    }

    func registerCollectionViewCells() {
        collectionView.register(EventCell.self,
                                forCellWithReuseIdentifier: eventCellIdentifier)
    }

    func layout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellIdentifier,
                                                      for: indexPath)
        guard let eventCell = cell as? EventCell,
              let event = events.item(at: indexPath.row) else {
            return cell
        }
        eventCell.update(event: event)

        return eventCell
    }
}

// MARK: UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let event = events.item(at: indexPath.row) {
            let eventViewController = EventViewController(event: event)
            navigationController?.pushViewController(eventViewController,
                                                     animated: true)
        }
        collectionView.deselectItem(at: indexPath,
                                    animated: true)
    }
}

// MARK: EventDataHandlerDelegate
extension MainViewController: EventDataHandlerDelegate {

    func eventsLoaded(events: [Event]) {
        self.events = events
        collectionView.reloadData()
    }
}
