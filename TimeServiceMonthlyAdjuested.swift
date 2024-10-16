//
//  TimeServiceMonthlyAdjuested.swift
//  Project2
//
//  Created by 박수연 on 10/15/24.
//

import Foundation

struct TimeServiceMonthlyAdjuested: Decodable {
    let meta: Meta
    let timeService: [String: OHLC]
}

struct Meta: Decodable {
    let symbol: String
    enum CodingKeys: String, CodingKey {
        case symbol = "2. Symbol"
    }
}

struct OHLC: Decodable {
    
        let open: String
        let close: String
        let adjustedClose: String
    
    enum CodingKeys: String, CodingKey {
        case open =  "1. open"
        case close = "4. close"
        case adjustedClose = "5. adjusted close"
    }

}

