//
//  MainViewModel.swift
//  AndelaJsonTests
//
//  Created by WEMABANK on 28/07/2022.
//

import Foundation
import CoreData
import UIKit

enum EventsViewModelState {
    case EventsViewModelDidStartRetrievingItems
    case EventsViewModelDidFailToRetrieveItems
    case EventsViewModelDidEndRetrievingItems
}

protocol EventsViewModelDelegate: AnyObject {
    func EventsViewModelDidTransitionToState(model: MainViewModel, state: EventsViewModelState)
}

final class MainViewModel: NSObject  {
    private var apiLoader: ServiceProtocol?
    public weak var delegate:EventsViewModelDelegate?
    var eventList: [Event]?
    var errorMessage: String?
    required init(apiLoader: ServiceProtocol = Service()) {
        self.apiLoader = apiLoader
        super.init()
    }
    
    public func getEvents() {
        delegate?.EventsViewModelDidTransitionToState(model: self, state: .EventsViewModelDidStartRetrievingItems)
        apiLoader?.getEvents(completion: { [weak self] result in
            guard let self = self else {
                return
            }
    
            switch result {
            case .success(let response):
              self.eventList = response.events
              self.delegate?.EventsViewModelDidTransitionToState(model: self, state: .EventsViewModelDidEndRetrievingItems)
            case .failure(let failure):
              self.errorMessage = failure.localizedDescription
              self.delegate?.EventsViewModelDidTransitionToState(model: self, state: .EventsViewModelDidFailToRetrieveItems)
           
            }
        })
    }
    

}
