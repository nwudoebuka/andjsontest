//
//  EventModel.swift
//  AndelaJsonTests
//
//  Created by Chukwuebuka Nwudo on 28/07/2022.
//

import Foundation

struct EventModel: Codable {
    let events: [Event]
}
struct Event: Codable{
  let id: Int
  let city: String
  let artist: String
  let price: Int
}
