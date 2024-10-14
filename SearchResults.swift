//
//  SearchResults.swift
//  Project_2
//
//  Created by 박수연 on 10/10/24.
//

import Foundation

struct SearchResults: Decodable {
    var items: [SearchResult]
    enum CodingKeys: String,CodingKey {
        case items = "bestMatches"
    }
}
struct SearchResult : Decodable {
    let symbol : String
    let name: String
    let type: String
    let currency: String
    
    enum CodingKeys: String,CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case currency = "8. currency"
        
    }
    
    

}
