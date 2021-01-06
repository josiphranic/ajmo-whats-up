//
//  EventDataHandler.swift
//  AjmoWhatsUp
//
//  Created by Josip Hranić on 04.01.2021..
//

import Alamofire

protocol EventDataHandlerDelegate: AnyObject {

    func eventsLoaded(events: [Event])
}

class EventDataHandler {

    private let decoder = JSONDecoder()
    private let eventsUrl = "https://api.ajmo.hr/v3/news/index?isPromoted=0&amp;page=1&amp;perPage=10"
    weak var delegate: EventDataHandlerDelegate?

    init() {
        setupDecoder()
    }
}

// MARK: Public methods
extension EventDataHandler {

    func loadEvents() {
        AF.request(eventsUrl)
            .validate()
            .responseDecodable(of: EventList.self,
                               decoder: decoder) { [weak self] response in
                guard let events = response.value?.data else {
                    return
                }
                self?.delegate?.eventsLoaded(events: events)
            }
    }
}

// MARK: Private methods
private extension EventDataHandler {

    func setupDecoder() {
        decoder.dateDecodingStrategy = .secondsSince1970
    }
}
